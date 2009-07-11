Gem::Specification.new do |s|
  s.name     = "mq"
  s.version  = "0.1.2"
  s.date     = "2009-07-11"
  s.summary  = "An email queue that actually works"
  s.email    = "matt@matt-darby.com"
  s.homepage = "http://github.com/mdarby/mq"
  s.description = "A Rails gem that generates an MVC stack that does email queuing"
  s.has_rdoc = false
  s.authors  = ["Matt Darby"]
  s.files    = [
    "MIT-LICENSE",
    "README.textile",
    "Rakefile",
    "generators/mq/mq_generator.rb",
    "generators/mq/templates/create_email_table.rb",
    "generators/mq/templates/email.rb",
    "generators/mq/templates/emails_controller.rb",
    "generators/mq/templates/spec/emails_routing_spec.rb",
    "generators/mq/templates/spec/email_spec.rb",
    "generators/mq/templates/spec/emails_controller_spec.rb",
    "generators/mq/templates/views/_email.html.erb",
    "generators/mq/templates/views/index.html.erb",
    "generators/mq/USAGE",
    "init.rb",
    "install.rb",
    "lib/mq.rb",
    "mq.gemspec",
    "uninstall.rb"
  ]
  
end