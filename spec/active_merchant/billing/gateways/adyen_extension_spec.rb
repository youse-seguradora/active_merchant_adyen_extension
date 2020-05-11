RSpec.describe ActiveMerchant::Billing::AdyenGateway do
  let(:options) { { username: 'foo', password: 'bar', merchant_account: 'foo' } }
  subject { described_class.new(options) }

  it 'has attr_reader :request_payload' do
    expect(subject.respond_to?(:request_payload)).to be_truthy
  end

  it 'use payment api version v40' do
    expect(described_class::PAYMENT_API_VERSION).to eq('v40')
  end

  it 'set live_checkout_url' do
    expect(described_class.live_checkout_url).to eq('https://-checkout-live.adyenpayments.com/checkout/')
  end

  it 'set test_checkout_url' do
    expect(described_class.test_checkout_url).to eq('https://checkout-test.adyen.com/')
  end

  it 'implements secure_store' do
    expect(subject.respond_to?(:secure_store)).to be_truthy
  end

  describe '#add_extra_data' do
    it 'adds the shopper name when it is given' do
      post = {}

      subject.send(:add_extra_data, post, '8835205392522157', shopper_name: 'John Doe')

      expect(post[:shopperName][:firstName]).to eq('John')
      expect(post[:shopperName][:lastName]).to eq('Doe')
    end

    it 'adds the shopper email when it is given' do
      post = {}

      subject.send(:add_extra_data, post, '8835205392522157', shopper_email: 'JDoe@email.com')

      expect(post[:shopperEmail]).to eq('JDoe@email.com')
    end
  end
end
