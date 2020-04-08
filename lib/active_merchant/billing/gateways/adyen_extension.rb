# frozen_string_literal: true

ActiveMerchant::Billing::AdyenGateway.class_eval do
  attr_reader :request_payload

  class_attribute :test_checkout_url
  self.test_checkout_url = 'https://checkout-test.adyen.com/'

  class_attribute :live_checkout_url
  self.live_checkout_url = "https://#{ENV['ADYEN_LIVE_URL_PREFIX']}-checkout-live.adyenpayments.com/checkout/"

  def secure_store(credit_card, options = {})
    post = init_post(options)
    add_invoice(post, 0, options)
    add_payment(post, credit_card, options)
    add_shopper_reference(post, options)
    add_stored_credentials(post, credit_card, options)
    post[:storePaymentMethod] = true

    initial_response = commit('secureStore', post, options)

    if initial_response.success? && card_not_stored?(initial_response)
      unsupported_failure_response(initial_response)
    else
      initial_response
    end
  end

  private

  def add_payment(post, payment, options)
    if payment.is_a?(String)
      _, _, recurring_detail_reference = payment.split('#')
      post[:selectedRecurringDetailReference] = recurring_detail_reference
      options[:recurring_contract_type] ||= 'RECURRING'
    elsif payment.respond_to?(:encrypted_number)
      add_encrypted_card(post, payment)
    else
      add_mpi_data_for_network_tokenization_card(post, payment) if payment.is_a?(ActiveMerchant::Billing::NetworkTokenizationCreditCard)
      add_card(post, payment)
    end
  end

  def add_encrypted_card(post, credit_card)
    post[:paymentMethod] = {}
    post[:paymentMethod][:type] = 'scheme'
    post[:paymentMethod][:encryptedCardNumber] = credit_card.encrypted_number
    post[:paymentMethod][:encryptedExpiryMonth] = credit_card.encrypted_month
    post[:paymentMethod][:encryptedExpiryYear] = credit_card.encrypted_year
    post[:paymentMethod][:encryptedSecurityCode] = credit_card.encrypted_verification_value
    post[:paymentMethod][:holderName] = credit_card.name
  end

  def url(action)
    if action == 'secureStore'
      url = test? ? test_checkout_url : live_checkout_url
      "#{url}#{ActiveMerchant::Billing::AdyenGateway::PAYMENT_API_VERSION}/payments"
    else
      if test?
        "#{test_url}#{endpoint(action)}"
      elsif @options[:subdomain]
        "https://#{@options[:subdomain]}-pal-live.adyenpayments.com/pal/servlet/#{endpoint(action)}"
      else
        "#{live_url}#{endpoint(action)}"
      end
    end
  end

  def success_from(action, response)
    case action.to_s
    when 'authorise', 'authorise3d'
      ['Authorised', 'Received', 'RedirectShopper'].include?(response['resultCode'])
    when 'capture', 'refund', 'cancel'
      response['response'] == "[#{action}-received]"
    when 'adjustAuthorisation'
      response['response'] == 'Authorised' || response['response'] == '[adjustAuthorisation-received]'
    when 'storeToken'
      response['result'] == 'Success'
    when 'disable'
      response['response'] == '[detail-successfully-disabled]'
    when 'secureStore'
      response['resultCode'] == 'Authorised'
    else
      false
    end
  end

  def message_from(action, response)
    return authorize_message_from(response) if %w[authorise authorise3d secureStore].include?(action.to_s)

    response['response'] || response['message'] || response['result']
  end
end
