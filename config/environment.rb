# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Maharjan::Application.initialize!

ActionMailer::Base.smtp_settings = {
       :enable_starttls_auto => true,
      :address => "smtp.gmail.com",
      :port => "587",
      :domain => "gmail.com",
      :authentication => :plain,
      :user_name => 'loseitwithus@gmail.com',
      :password => 'loseitwithus'
}


