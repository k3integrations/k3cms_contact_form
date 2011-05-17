module K3cms
  module ContactForm
    class Contact < MailForm::Base
      attr_accessor :contact_form

      attribute :name,      :validate => true
      attribute :email,     :validate => /^[^@\s]+@[\w\-]+\.[\w\.\-]+$/
      attribute :subject
      attribute :message,   :validate => true

      append :url, :remote_ip, :user_agent, :session

      def headers
        {
          :subject => subject_prefix + (subject.present? ? subject : "Message from website"),
          :to      => contact_form.recipient_email,
          :from    => %("#{name}" <#{email}>)
        }
      end

      def subject_prefix
        "[#{request.host}] "
      end

      #---------------------------------------------------------------------------------------------

      attribute :nonhuman_catcher,  :captcha  => true
      attribute :fill_in_via_javascript

      # For it to *not* be considered spam:
      # * nonhuman_catcher field (:captcha => true) must be blank
      # * fill_in_via_javascript field must be set to "Not spam!" (automatically set via JavaScript)
      def spam?
        super || fill_in_via_javascript != 'Not spam!'
      end

    end
  end
end
