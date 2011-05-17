module K3cms
  module ContactForm
    class ContactsController < K3cms::ContactForm::BaseController
      load_and_authorize_resource :k3cms_contact_form_contact_form, :class => 'K3cms::ContactForm::ContactForm'

      before_filter :require_contact_form
      def require_contact_form
        @contact_form = @k3cms_contact_form_contact_form or raise "contact_form must be specified in the url (use the nested route, new_k3cms_contact_form_contact_form_contact_path(contact_form))"
      end

      def index
        redirect_to k3cms_contact_form_contact_form_path(@contact_form)
      end

      def new
        redirect_to k3cms_contact_form_contact_form_path(@contact_form)
      end

      def create
        @contact = Contact.new(params[:k3cms_contact_form_contact])
        @contact.contact_form = @contact_form
        @contact.request = request

        if @contact.deliver
          redirect_to k3cms_contact_form_contact_form_path(@contact_form),
            :notice => 'Thank you.  Your message has been sent.'
        else
          # Note: contact_forms/show is responsible for actually showing the form (on a page by itself); so we don't need a separate contact/new view.
          #render :action => "new"
          render :file => 'k3cms/contact_form/contact_forms/show'
        end
      end

    end
  end
end
