require "rails"
require "k3cms_contact_form"
require "k3cms/core/railtie"
require 'facets/kernel/__dir__'
require 'facets/pathname'

module K3cms
  module ContactForm
    class Railtie < Rails::Engine
      puts self

      config.before_initialize do
        # Anything in the .gemspec that needs to be *required* should be required here.
        # This is a workaround for the fact that this line:
        #   Bundler.require(:default, Rails.env) if defined?(Bundler)
        # in config/application.rb only does a 'require' for the gems explicitly listed in the *app*'s Gemfile -- not for the gems *they* might depend on (which are listed in a .gemspec file, not a Gemfile).
        require 'haml'
        require 'mail_form'
        require 'cancan'

        # Ensure that active_record is loaded before attribute_normalizer, since attribute_normalizer only loads its active_record-specific code if active_record is loaded.
        require 'active_record'
        require 'attribute_normalizer'
      end

      # This is to avoid errors like undefined method `can?' for cells
      initializer 'k3cms.contact_form.cancan' do
        ActiveSupport.on_load(:action_controller) do
          include CanCan::ControllerAdditions
          Cell::Base.send :include, CanCan::ControllerAdditions
        end
      end

      initializer 'k3cms.contact_form.helpers' do
        config.after_initialize do
          helpers = proc {
            helper K3cms::ContactForm::ContactFormHelper
          }
          ActiveSupport.on_load(:action_controller, &helpers)
          Cell::Rails.class_eval(                   &helpers)
        end
      end

      config.action_view.javascript_expansions[:k3cms].concat [
        'k3cms/contact_form.js',
      ]
      config.action_view.javascript_expansions[:k3cms_editing].concat [
        'jquery.tools.tooltip.js',
      ]
      config.action_view.stylesheet_expansions[:k3cms] ||= []
      config.action_view.stylesheet_expansions[:k3cms].concat [
        'k3cms/contact_form.css',
      ]

      initializer 'k3cms.contact_form.cells_paths' do |app|
        Cell::Base.view_paths += [config.root + 'app/cells',]
                                  #config.root + 'app/views']
      end

    end
  end
end
