Rails.application.routes.draw do
  #resources :k3cms_contact_form_contacts,      :path => '/contacts',      :controller => 'k3cms/contact_form/contacts', :only => [:new, :create]
  resources :k3cms_contact_form_contact_forms, :path => '/contact_forms', :controller => 'k3cms/contact_form/contact_forms' do
    # FIXME: This ugly route (k3cms_contact_form_contact_form_contacts POST) is here only so that form_for [@contact_form, @contact] can find the route it needs
    resources :k3cms_contact_form_contacts,    :path => '/contacts',      :controller => 'k3cms/contact_form/contacts', :only => [:new, :create, :index]
    resources :contacts,                       :path => '/contacts',      :controller => 'k3cms/contact_form/contacts', :only => [:new, :create, :index]
  end
end
