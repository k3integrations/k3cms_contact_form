require 'spec_helper'

module K3cms::ContactForm
  describe ContactsController do

    let(:user) { mock_model(User, :k3cms_permitted? => true) }
    before { controller.stub :current_user => user }

    it "should understand routes" do
     #assert_routing "/contacts/new",                  {:controller=>"k3cms/contact_form/contacts", :action=>"new", }
      assert_routing "/contact_forms/1/contacts/new",  {:controller=>"k3cms/contact_form/contacts", :action=>"new", :k3cms_contact_form_contact_form_id => "1"}
    end

    before do
      @contact_form = ContactForm.make
    end

    describe "#new" do
      it "assigns Contact as @contact" do
        get :new, :k3cms_contact_form_contact_form_id => @contact_form
        response.should redirect_to(k3cms_contact_form_contact_form_path(@contact_form))
      end
    end

    describe "#create" do
      describe "with incomplete data" do
        before do
        end

        it "assigns variables" do
          post :create, :k3cms_contact_form_contact_form_id => @contact_form
          assigns(:k3cms_contact_form_contact_form).should == @contact_form
          assigns(:contact).should be_instance_of(Contact)
        end

        pending "it should show validation errors"
      end

      describe "with complete data" do
        before do
        end

        pending "it should send an e-mail"
      end
    end

    pending "it has complete spec coverage"
  end
end
