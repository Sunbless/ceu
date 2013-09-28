class HesController < ApplicationController
  before_filter :authenticate_user!
  # GET /hes
  # GET /hes.json
  def index
    if current_user.district_id and !current_user.admin?
      district = District.find(current_user.district_id)
      @hes = district.hes
    else
      @hes = He.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hes }
    end
  end

  # GET /hes/1
  # GET /hes/1.json
  def show
    @he = He.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @he }
    end
  end

  # GET /hes/new
  # GET /hes/new.json
  def new
    @he = He.new
    if current_user.district_id and !current_user.admin?
      district = District.find(current_user.district_id)
      @centers = district.centers
    else
      @centers = Center.all
    end
    @chiefs = User.find_all_by_user_type(1)
    @nurses = User.find_all_by_user_type(2)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @he }
    end
  end

  # GET /hes/1/edit
  def edit
    @he = He.find(params[:id])
    if current_user.district_id and !current_user.admin?
      district = District.find(current_user.district_id)
      @centers = district.centers
    else
      @centers = Center.all
    end
    @chiefs = User.find_all_by_user_type(1)
    @nurses = User.find_all_by_user_type(2)
  end

  # POST /hes
  # POST /hes.json
  def create
    @he = He.new(params[:he])
    if current_user.district_id and !current_user.admin?
      district = District.find(current_user.district_id)
      @centers = district.centers
    else
      @centers = Center.all
    end
    @chiefs = User.find_all_by_user_type(1)
    @nurses = User.find_all_by_user_type(2)
    respond_to do |format|
      if @he.save
        format.html { redirect_to @he, notice: t(:record_created) }
        format.json { render json: @he, status: :created, location: @he }
      else
        format.html { render action: "new" }
        format.json { render json: @he.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hes/1
  # PUT /hes/1.json
  def update
    @he = He.find(params[:id])
    if current_user.district_id and !current_user.admin?
      district = District.find(current_user.district_id)
      @centers = district.centers
    else
      @centers = Center.all
    end
    @chiefs = User.find_all_by_user_type(1)
    @nurses = User.find_all_by_user_type(2)
    respond_to do |format|
      if @he.update_attributes(params[:he])
        format.html { redirect_to @he, notice: t(:record_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @he.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hes/1
  # DELETE /hes/1.json
  def destroy
    @he = He.find(params[:id])
    @he.destroy

    respond_to do |format|
      format.html { redirect_to hes_url }
      format.json { head :no_content }
    end
  end
end
