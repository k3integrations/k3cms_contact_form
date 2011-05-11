module K3cms
  module ContactForm
    class ContactFormsController < K3cms::ContactForm::BaseController
      load_and_authorize_resource :contact_form, :class => 'K3cms::ContactForm::ContactForm'

      def index
        @contact_forms = ContactForm.order('id asc')

        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @contact_forms }
        end
      end

      def show
        respond_to do |format|
          if request.xhr?
            format.html {
              render :text => render_cell('k3cms/contact_form/contact_forms', :show, :contact_form => @contact_form)
            }
          else
            format.html # show.html.erb
          end
          format.js # not currently used
          format.json {
            K3cms::ContactForm::ContactForm.model_name.instance_variable_set('@element', dom_class(@contact_form))
            render :json => @contact_form
          }
        end
      end

      def new
        # TODO: duplicated with ContactFormsCell
        @contact_form = K3cms::ContactForm::ContactForm.new.set_defaults

        respond_to do |format|
          if request.xhr?
            format.html {
              render :text => render_cell('k3cms/contact_form/contact_forms', :show, :contact_form => @contact_form)
            }
          else
            format.html # new.html.erb
          end
          format.json { render :json => @contact_form }
        end
      end

      def create
        @contact_form.attributes = params[:k3cms_contact_form_contact_form]
        @contact_form.author = current_user

        respond_to do |format|
          if @contact_form.save
            format.html do
              redirect_to(k3cms_contact_form_contact_form_url(@contact_form, :focus => ".editable[data-object-id=#{dom_id(@contact_form)}][data-attribute=title]:visible"),
                          :notice => 'Contact Form was successfully created.')
            end
            format.json { redirect_to(k3cms_contact_form_contact_form_url(@contact_form)) }
          else
            format.html { render :action => "new" }
            format.json { render :json => {:error => @contact_form.errors.full_messages.join('<br/>'), :status => :unprocessable_entity} }
          end
        end
      end

      def edit
      end

      def update
        respond_to do |format|
          if @contact_form.update_attributes(params[:k3cms_contact_form_contact_form])
            format.html { redirect_to(k3cms_contact_form_contact_form_url(@contact_form), :notice => 'ContactForm was successfully updated.') }
            format.json { render :json => {} }
          else
            format.html { render :action => "edit" }
            format.json { render :json => {:error => @contact_form.errors.full_messages.join('<br/>')}, :status => :unprocessable_entity }
          end
        end
      end

      def destroy
        @contact_form.destroy
        respond_to do |format|
          format.html { redirect_to(k3cms_contact_form_contact_forms_url) }
          format.js
          format.json { render :nothing =>  true }
        end
      end
    end
  end
end
