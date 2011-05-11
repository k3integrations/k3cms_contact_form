module K3cms
  module ContactForm
    class BaseController < ApplicationController

      include CanCan::ControllerAdditions
      #include K3cms::Ribbon::RibbonHelper # for edit_mode?
      helper K3cms::InlineEditor::InlineEditorHelper

      def current_ability
        @current_ability ||= K3cms::ContactForm::Ability.new(k3cms_user)
      end

      rescue_from CanCan::AccessDenied do |exception|
        k3cms_authorization_required(exception)
      end
    end
  end
end
