class HomeController < ApplicationController

  def index
    @title = "Lose it!"
  end
  
  def about
    @title = "About"
     @members = User.order("created_at desc").all
  end
  
  def contact
    @title = "Contact us"
    @contact = Contact.new
  end
  
  def sendmessage
    @title = "Contact us"
    @contact = Contact.new(params['contact'])
    flash[:error] = ''
    flash[:success] = ''
    flash[:notice] = ''
    if @contact.save
      begin
        mail = MessageMailer.send_email(@contact)
        mail.deliver
        flash[:success] = 'Your message was sent.'
        @contact = Contact.new
        render "contact"
      rescue Exception => exc
        flash[:error] = 'Something went wrong. Please try again.'
        render "contact"
      end
    else
      flash[:error] = 'Please correct the error below:'
      render "contact"
    end
  end


  def signin
    @title = "Sign in"
  end
end
