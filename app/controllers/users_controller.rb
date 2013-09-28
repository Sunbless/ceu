class UsersController < ApplicationController
  # skip_before_filer :require_no_authentication 
  before_filter :authenticate_user!
  # before_filter :allow_admin_access


  # GET /users
  # GET /users.xml
  def index
    allow_admin_access
    @users = User.order(:name,:surname,:email).page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


  def users_type
    allow_admin_access if (!current_user.admin && params[:user_type] == "3")
    if params[:user_type] == "regular"
      @users = User.where('user_type != 3')
    else
      @users = User.where('user_type = '+params[:user_type])
    end
    if current_user.district_id and !current_user.admin?
      @users = @users.where("district_id = #{current_user.district_id}")
    end
    @users = @users.order(:name,:surname,:email).page params[:page]
    respond_to do |format|
      format.html  { render :index }
      format.json  { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @current_method = "new"
    if current_user.district_id and !current_user.admin?
      @districts =  District.where("id = #{current_user.district_id}")
      @municipalities = Municipality.where("district_id = #{current_user.district_id}")
    else
      @municipalities = Municipality.all
      @districts = District.all
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @municipalities = Municipality.all
    @districts = District.all
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if params[:user][:password].blank?
      @user.password = (0...30).map{ ('a'..'z').to_a[rand(26)] }.join
    end
    if !params[:user][:email] || params[:user][:email] == "false" 
      @user.email = "#{params[:user][:name]}.#{params[:user][:surname]}@ceu.ba".delete(' ')
    end
    @municipalities = Municipality.all
    @districts = District.all
    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_type_path(params[:user][:user_type]), :notice => t(:user_created)) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.json  { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @municipalities = Municipality.all
    @districts = District.all

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => t(:user_updated)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    allow_admin_access
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end