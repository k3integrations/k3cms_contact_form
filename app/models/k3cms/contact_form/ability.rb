module K3cms
  module ContactForm
    class Ability
      include CanCan::Ability

      def initialize(user)
        #----------------------------------------------------------------------------------------------------
        # ContactForms

        if user.k3cms_permitted?(:view_contact_form)
          can :read, K3cms::ContactForm::ContactForm
        end

        # CanCan automatically aliases :index => :read (https://github.com/ryanb/cancan/wiki/Action-Aliases), but we can override that:
        unless user.k3cms_permitted?(:list_contact_form)
          cannot :index, K3cms::ContactForm::ContactForm
        end

        if user.k3cms_permitted?(:edit_contact_form)
          can :read, K3cms::ContactForm::ContactForm
          can :update, K3cms::ContactForm::ContactForm
        end

        if user.k3cms_permitted?(:create_contact_form)
          can :create, K3cms::ContactForm::ContactForm
        end

        if user.k3cms_permitted?(:delete_contact_form)
          can :destroy, K3cms::ContactForm::ContactForm
        end
      end
    end
  end
end
