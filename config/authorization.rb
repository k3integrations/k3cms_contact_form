K3cms::ContactForm::Railtie.authorization.draw do
  suggested_permission_set :default, 'Allows managers to create & edit all contact_forms; guests cannot list forms'

  context :contact_forms do
    ability :view, 'Can view a contact_form'  # Creates :view_contact_form ability
    ability :list, 'Can list contact_forms'
    ability :edit, 'Can edit a contact_form'
    ability :create, 'Can create a new contact_form'
    ability :delete, 'Can delete a contact_form'

    extend_suggested_permission_set :default do
      guest   :has => :view
      user    :has => :list, :includes_role => :guest
      manager :has => :all
      admin   :has => :all
    end
  end

end
