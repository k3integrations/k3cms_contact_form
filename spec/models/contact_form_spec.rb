require 'spec_helper'

module K3cms::ContactForm
  describe ContactForm do
    describe "validation" do
      describe "blank record" do
        it "shouldn't be valid" do
          #puts "subject=#{subject.inspect}"
          subject.valid?
          subject.should_not be_valid
        end
      end

      describe "normalization" do
        [:title, :header, :recipient_email].each do |attr_name|
          it { should normalize_attribute(attr_name).from('  Something  ').to('Something') }
          it { should normalize_attribute(attr_name).from('').to(nil) }
        end
      end

      %w[title recipient_email].each do |attr_name|
        describe attr_name do
          #subject { ContactForm.new }
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

      describe 'recipient_email' do
        it 'allows valid e-mails' do
          subject.recipient_email = 'test@example.com'
          subject.valid?
          subject.errors['recipient_email'].should be_empty
        end

        it 'disallows invalid e-mails' do
          subject.recipient_email = 'test.example.com'
          subject.valid?
          subject.errors['recipient_email'].should include("is not a valid e-mail address")
        end
      end

    end
  end
end
