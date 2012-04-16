class MessageMailer < ActionMailer::Base
  default :from => 'loseitwithus@gmail.com',
          :return_path => 'loseitwithus@gmail.com'

  def send_email(contact)
    @messagefrom = contact.name
    @message = contact.message
    @messagesubject = "Message from #{contact.name} <#{contact.email_address}>"
    mail(:to => "loseitwithus@gmail.com", :from => contact.email_address,
           :bcc => [""]) do |format|
        format.html {render "message.html.erb"}
    end
  end

  def welcome(user)
    @user = user
    mail(:to => user.email,
         :bcc => [""]) do |format|
      format.text
      format.html {render "signup_notification.text.plain.haml"}
    end
  end

  def reset(user)
    @user = user
    mail(:to => user.email,
         :bcc => [""]) do |format|
      format.text
      format.html {render "reset.text.plain.haml"}
    end
  end
end
