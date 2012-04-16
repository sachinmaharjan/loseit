class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def forgotpassword
    @title = "Forgot Password"
  end

  def sendresetpasswordlink
    @title = "Send Reset Password Link"
    @user = User.find_by_email(params[:session][:email])
    if @user
      @user.create_reset_code
      flash[:notice] = "Reset password link has been sent to #{@user.email}"
      sendmail(@user)
      redirect_to "/signin"
    else
      flash[:notice] = "The email you have entered does not exist in system. Please try again."
      redirect_to :action => "forgotpassword"
    end
  end

  def resetpassword
    @title = "Reset Password"
    @user = User.find_by_reset_code(params[:code])
    code =  params[:code]
    if @user.reset_code_until < Time.now
      flash[:notice] = "Reset password link has been expired. Please try again."
      redirect_to :action => "forgotpassword"
    end
  end

#    @user = User.find_by_reset_code(params[:id])
#    self.current_user = user if user &&  user.reset_code_until  && Time.now < user.reset_code_until
#    redirect_to logged_in? ? "/MySpyder.swf?a=account" : "/MySpyder.swf?a=login"

  def create
    @title = "Sign in"
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to "/members/#{user.member_id}"
    end
  end

  def destroy
    @title = "Sign out"
    sign_out
    redirect_to root_path
  end

  private
    def sendmail(user)
      @user = user
      mail = MessageMailer.reset(@user)
      mail.deliver
    end

end
