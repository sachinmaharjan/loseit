class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :show, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :admin_user,   :only => :destroy
  protect_from_forgery :only => [:create, :update, :destroy, :edit]
#  protect_from_forgery :only => [:create, :destroy, :update, :edit]
  # GET /users
  # GET /users.xml
  def index
    @users = User.order("created_at desc").all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_member_id(params[:id])
    @title = @user.name


    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_member_id(params[:id])
    @title = "Edit #{@user.name}"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params['user'])
    @user.admin= 0
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
#      sendmail(@user)
      redirect_to "/members/#{@user.member_id}"
    else
      flash[:error] = "Error!"
      @title = "Sign up"
      render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_by_member_id(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = "Successfully updated."
        format.html { redirect_to("/members/#{@user.member_id}", :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def updatepassword
    @title = "Reset Password"
    @user = User.find_by_reset_code(params[:code])
    if @user.reset_code_until < Time.now
      flash[:notice] = "Reset password link has been expired. Please try again."
      redirect_to "/forgotpassword"
    else
      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash[:notice] = "Password has been reset!"
          format.html { redirect_to "/signin" }
          format.xml  { head :ok }
        else
          flash[:error] = @user.errors.full_messages.last()
          format.html { redirect_to "/resetpassword/#{@user.reset_code}" }
          format.xml  { render :xml => @user.errors}
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_member_id(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def search
    @users = User.search(params[:search])
    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @users }
    end
  end

   def auto_complete_for_search_query
     @users = User.find_by_names(params["search"]["query"]+"*", {:limit => 5})
     render :partial => "search_result"
    end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find_by_member_id(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def sendmail(user)
      @user = user
      mail = MessageMailer.welcome(@user)
      mail.deliver
    end
end
