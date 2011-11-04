module K3cms
  module ContactForm
    class ContactForm < ActiveRecord::Base
      self.include_root_in_json = false
      set_table_name 'k3cms_contact_forms'

      belongs_to :page
      belongs_to :author, :class_name => 'User'

      normalize_attributes :title, :header, :recipient_email, :with => [:strip, :blank]

      validates :title, :recipient_email, :presence => true
      validates :recipient_email, :email => true

      #---------------------------------------------------------------------------------------------

      def set_defaults
        self.title  = 'Contact Us'
        self.header = '<p>Header goes here</p>'
        self
      end

      def to_s
        title
      end

      #---------------------------------------------------------------------------------------------
    end
  end
end

