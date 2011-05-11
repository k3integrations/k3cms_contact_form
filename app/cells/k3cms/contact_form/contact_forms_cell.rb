module K3cms
  module ContactForm
    class ContactFormsCell < Cell::Rails
      # FIXME: These don't need to be here normally since the Railtie includes them into Cell::Rails,
      # but for some reason they aren't available when the views are rendered by the cell spec.
      # TODO: figure out why that is and then remove them from here
      helper K3cms::ContactForm::ContactFormHelper
      helper K3cms::InlineEditor::InlineEditorHelper

      def current_ability
        @current_ability ||= K3cms::ContactForm::Ability.new(k3cms_user)
      end

      def index
        @contact_forms = options[:contact_forms]
        @contact_forms ||= ContactForm.accessible_by(current_ability).order('id desc')

        # FIXME: duplicated with #new action in controller
        @new_contact_form = K3cms::ContactForm::ContactForm.new.set_defaults

        render
      end

      def show
        set_up_show
        @contact = options[:contact]
        @contact ||= Contact.new
        render if @contact_form
      end

      def context_ribbon
        set_up_show
        render
      end

    private
      def set_up_show
        @contact_form = options[:contact_form] or raise('contact_form is required')
      end

    end
  end
end
