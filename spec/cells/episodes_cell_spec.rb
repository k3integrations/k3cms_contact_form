require 'spec_helper'

module K3cms::ContactForm
  describe ContactFormsCell do
    let(:user) { mock_model(User, :k3cms_permitted? => true) }
    before do
      controller.stub :k3cms_user => user
      controller.session[:edit_mode] = true
    end

    let(:contact_form) { ContactForm.make }

    context "cell instance" do
      subject { cell('k3cms/contact_form/contact_forms') }
      it { should respond_to(:index) }
      it { should respond_to(:show) }
      it { should respond_to(:context_ribbon) }
    end

    context "#index" do
      before do
        @contact_form = contact_form
      end
      it "renders something" do
        output = render_cell('k3cms/contact_form/contact_forms', :index, {})
        output.should have_tag('div.k3cms_contact_form_contact_form_list') do |list|
          list.should have_tag(".header")
          list.should have_tag(".the_list") do |the_list|
            the_list.should have_selector(".k3cms_contact_form_contact_form.show.new_record")
            the_list.should have_selector(".k3cms_contact_form_contact_form.show.record_exists##{dom_id(@contact_form)}")
          end
        end
      end
    end

    context "#show" do
      it "renders something" do
        output = render_cell('k3cms/contact_form/contact_forms', :show, :contact_form => contact_form)
        output.should have_tag(".k3cms_contact_form_contact_form.show.record_exists") do |record_box|
          #puts "record_box.inner_html=#{record_box.inner_html}"
          record_box.should have_tag(".editable[data-attribute='title']")
          record_box.should have_tag(".editable[data-attribute='header']")
        end
      end
    end

    context "#context_ribbon" do
      context "for new record" do
        let(:contact_form) { ContactForm.new }
        it "uses plain inputs" do
          output = render_cell('k3cms/contact_form/contact_forms', :context_ribbon, :contact_form => contact_form)
          output.should have_tag('div.context_ribbon') do |ribbon|
            ribbon.should have_tag("input[name='contact_form[recipient_email]']")
          end
        end
      end

      context "for existing record" do
        let(:contact_form) { ContactForm.make }
        it "uses best_in_place" do
          output = render_cell('k3cms/contact_form/contact_forms', :context_ribbon, :contact_form => contact_form)
          output.should have_tag('div.context_ribbon') do |ribbon|
            ribbon.should have_tag(".best_in_place[data-attribute='recipient_email']")
          end
        end
      end
    end

    context "when you override app/cells/k3cms/contact_form/contact_forms/_form.html.haml in your app" do
      pending "uses it instead of the standard form template"
    end

  end
end
