# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "k3cms/contact_form/version"

Gem::Specification.new do |s|
  s.name          = "k3cms_contact_form"
  s.summary       = %q{K3cms ContactForm}
  s.description   = %q{Easily add a contact form to your K3cms app with this gem}
  s.homepage      = "http://k3cms.org/#{s.name}"

  s.add_dependency 'facets'
  s.add_dependency 'rails',        '~> 3.0.0'
  s.add_dependency 'activerecord', '~> 3.0.0'
  s.add_dependency 'actionpack',   '~> 3.0.0'
 #s.add_dependency 'cancan'
  s.add_dependency 'k3cms_core'
  s.add_dependency 'cells'
  s.add_dependency 'attribute_normalizer'
  s.add_dependency 'mail_form'

  s.authors       = `git shortlog --summary --numbered         | awk '{print $2, $3    }'`.split("\n")
  s.email         = `git shortlog --summary --numbered --email | awk '{print $2, $3, $4}'`.split("\n")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.version       = K3cms::ContactForm::Version
  s.platform      = Gem::Platform::RUBY
end
