namespace :k3cms do
  namespace :contact_form do
    desc "Install K3cms ContactForm"
    task :install => [:copy_public, :copy_migrations] do
      puts "Don't forget to run:
rails generate k3cms_contact_form_initializer bucket_name"
    end
    
    desc "Copy public files"
    task :copy_public do
      K3cms::FileUtils.copy_or_symlink_files_from_gem K3cms::ContactForm, 'public/**/*'
    end
    
    desc "Copy migrations"
    task :copy_migrations do
      K3cms::FileUtils.copy_from_gem K3cms::ContactForm, 'db/migrate'
    end
  end
end
