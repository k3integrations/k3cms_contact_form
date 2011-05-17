require 'spec_helper'
require 'app/models/k3cms/contact_form/contact'

module K3cms::ContactForm
  describe Contact do
    before :all do
      @contact_form = ContactForm.make
    end

    before do
      @contact = Contact.new({
        :name                   => "Sender Name",
        :email                  => "sender@example.com",
        :message                => "My message",
        :nonhuman_catcher       => '',
        :fill_in_via_javascript => 'Not spam!',
      })
      @contact.request      = ActionController::TestRequest.new
      @contact.contact_form = @contact_form
    end

    describe "validation" do
      describe "blank record" do
        it "shouldn't be valid" do
          #puts "subject=#{subject.inspect}"
          subject.valid?
          subject.should_not be_valid
        end
      end

      describe "spam fields" do
        subject { @contact }

        context "not filled in properly" do
          before do
            @contact.nonhuman_catcher = 'Something a spam bot might put in this field'
            @contact.fill_in_via_javascript = ''
          end

          # Apparently mail_form does not use validation errors, but rather a before_create/before_deliver callback
          #it { should have(1).error_on(:nonhuman_catcher) }
          #it { should have(1).error_on(:fill_in_via_javascript) }

          describe "delivery" do
            it "should be prevented" do
              @contact.deliver.should be_false
            end
          end
        end

        context "filled in properly" do

          describe "delivery" do
            it "should be allowed" do
              @contact.deliver.should be_true
            end
          end
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

      context "a valid contact object" do
        before do
          @contact = Contact.new({
            :name                   => "Sender Name",
            :email                  => "sender@example.com",
            :message                => "My message",
            :nonhuman_catcher       => '',
            :fill_in_via_javascript => 'Not spam!',
          })
          @contact.request      = ActionController::TestRequest.new
          @contact.contact_form = ContactForm.make
        end
        subject { @contact }

        it { should be_valid }

        describe "subject" do
          subject { @contact.headers[:subject] }
          it { should == "[test.host] Message from website" }
        end

        describe "to" do
          subject { @contact.headers[:to] }
          it { should == @contact.contact_form.recipient_email }
          it { should == 'test@example.com' }
        end

        describe "from" do
          subject { @contact.headers[:from] }
          it { should == '"Sender Name" <sender@example.com>' }
        end

      end

    end

  end
end
