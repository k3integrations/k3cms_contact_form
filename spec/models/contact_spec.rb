require 'spec_helper'
require 'app/models/k3cms/contact_form/contact'

module K3cms::ContactForm
  describe Contact do

    describe "validation" do
      describe "blank record" do
        it "shouldn't be valid" do
          #puts "subject=#{subject.inspect}"
          subject.valid?
          subject.should_not be_valid
        end
      end

      %w[name email message].each do |attr_name|
        describe attr_name do
          #subject { Contact.new }
          it "shouldn't allow blank values" do
            subject.send "#{attr_name}=", nil 
            subject.valid?
            subject.errors[attr_name].should include("can't be blank")

            subject.send "#{attr_name}=", 'not blank'
            subject.valid?
            subject.errors[attr_name].should_not include("can't be blank")
          end
        end
      end

    end

  end
end
