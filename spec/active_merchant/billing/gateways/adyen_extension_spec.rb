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
    expect(described_class.live_checkout_url).to eq('https://checkout-live.adyen.com/')
  end

  it 'set test_checkout_url' do
    expect(described_class.test_checkout_url).to eq('https://checkout-test.adyen.com/')
  end

  it 'implements secure_store' do
    expect(subject.respond_to?(:secure_store)).to be_truthy
  end
end
