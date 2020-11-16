$:.push File.expand_path('../lib', __FILE__)
require 'active_merchant_adyen_extension/version'

Gem::Specification.new do |spec|
  spec.name          = "active_merchant_adyen_extension"
  spec.version       = ActiveMerchantAdyenExtension::VERSION
  spec.authors       = ["Raul Souza Lima"]
  spec.email         = ["raulsouzalima@gmail.com"]

  spec.summary       = "Extension to Adyen gateway implemented by ActiveMerchant"
  spec.description   = "ActiveMerchant implements Adyen gateway, but some missing things will be added as a extension here."
  spec.homepage      = "http://youse.com.br"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["allowed_push_host"] = "http://geminabox-qa.youse.io:9292"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/youse-seguradora/active_merchant_adyen_extension"
  spec.metadata["changelog_uri"] = "https://github.com/youse-seguradora/active_merchant_adyen_extension/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('activemerchant', '>= 1.104', '< 1.118')
end
