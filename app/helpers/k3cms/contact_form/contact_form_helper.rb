module K3cms::ContactForm::ContactFormHelper
  def k3cms_contact_form_contact_form_classes(contact_form)
    [
      dom_class(contact_form),
      dom_id(contact_form),
      (contact_form.new_record? ? 'new_record' : 'record_exists'),
    ].compact
  end
end
