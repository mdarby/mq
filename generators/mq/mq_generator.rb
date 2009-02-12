class MqGenerator < Rails::Generator::NamedBase
  
  @@mailer_name = nil
  
  def initialize(*runtime_args)
    super(*runtime_args) if @@mailer_name = runtime_args[0][1]
  end

  def manifest
    record do |m|
      install_routes(m)
      
      m.directory(File.join('app/models'))
      m.directory(File.join('app/controllers'))
      m.directory(File.join('app/helpers'))
      m.directory(File.join('app/views'))
      m.directory(File.join("app/views/#{table_name}"))
      m.directory(File.join('db/migrate'))
      
      if has_rspec?
        m.directory(File.join('spec/controllers'))
        m.directory(File.join('spec/models'))
        m.directory(File.join('spec/helpers'))
        m.directory(File.join('spec/views'))
        m.directory(File.join("spec/views/#{table_name}"))
        
        # Controllers
        m.template "spec/emails_controller_spec.rb", File.join('spec/controllers', "#{table_name}_controller_spec.rb")
        m.template "spec/emails_routing_spec.rb", File.join('spec/controllers', "#{table_name}_routing_spec.rb")
        
        # Models
        m.template "spec/email_spec.rb", File.join('spec/models', "#{table_name.singularize}_spec.rb")
      end
      
      # Controllers
      m.template "emails_controller.rb", File.join('app/controllers', "#{table_name}_controller.rb")
      
      # Models
      m.template "email.rb", File.join('app/models', "#{table_name.singularize}.rb")

      # Migrations
      m.migration_template "create_email_table.rb", "db/migrate", :migration_file_name => "create_#{object_name}_table"
      
      # Views
      m.template "views/index.html.erb", File.join("app/views/#{table_name}", "index.html.erb")
      m.template "views/_email.html.erb", File.join("app/views/#{table_name}", "_#{object_name}.html.erb")
      
    end
  end
  
  def mailer_name
    @@mailer_name
  end
    
  def table_name
    class_name.tableize
  end
  
  def model_name
    class_name.demodulize
  end
  
  def object_name
    table_name.singularize
  end
  
  def install_routes(m)
    route_string = ":#{table_name}, :member => {:deliver => :get}, :collection => {:deliver_all => :get, :destroy_all => :get}"
    def route_string.to_sym; to_s; end
    def route_string.inspect; to_s; end
    m.route_resources route_string
  end
  
  def has_rspec?
    spec_dir = File.join(RAILS_ROOT, 'spec')
    options[:rspec] ||= (File.exist?(spec_dir) && File.directory?(spec_dir)) unless (options[:rspec] == false)
  end
  
  
  protected
  
    def banner
      "Usage: #{$0} #{spec.name} ModelName MailerModelName"
    end
    
end