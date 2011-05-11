require 'machinist/active_record'
require 'sham'

module K3cms::ContactForm
  Sham.title { |i| "Contact form #{i}" }
  ContactForm.blueprint do
    title
    recipient_email 'test@example.com'
  end
end
