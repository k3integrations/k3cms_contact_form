require 'spec_helper'

module K3cms::ContactForm
  describe ContactFormsController do

    let(:user) { mock_model(User, :k3cms_permitted? => true) }
    before { controller.stub :current_user => user }

    it "should understand routes" do
      assert_routing "/contact_forms",   :controller=>"k3cms/contact_form/contact_forms", :action=>"index"
      assert_routing "/contact_forms/1", :controller=>"k3cms/contact_form/contact_forms", :action=>"show", :id => "1"
    end

    describe "#new" do
      before do
        xhr :get, :new
      end

      it "assigns" do
        assigns(:contact_form).should be_new_record
      end
    end

    describe "#show" do
      before do
        @contact_form = ContactForm.make
        get :show, :id => @contact_form.id
      end

      it "assigns" do
        assigns(:contact_form).should == @contact_form
      end
    end

    describe "#create" do
      pending
    end

    pending "it has complete spec coverage"
  end
end
