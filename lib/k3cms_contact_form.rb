$:.unshift File.join(File.dirname(__FILE__), '..')  # so we can require 'app/models/...'

module K3cms
  module ContactForm
  end
end

require 'k3cms/contact_form/railtie'
