class PhisController < ApplicationController
  before_filter :authenticate_user!
  # GET /phis
  # GET /phis.json
  def index
    if current_user.district_id and !current_user.admin?
      @phis = Phi.where("district_id = #{current_user.district_id}")
    else
      @phis = Phi.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phis }
    end
  end

  # GET /phis/1
  # GET /phis/1.json
  def show
    @phi = Phi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phi }
    end
  end

  # GET /phis/new
  # GET /phis/new.json
  def new
    @phi = Phi.new
    @municipalities = Municipality.all
    @districts = District.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phi }
    end
  end

  # GET /phis/1/edit
  def edit
    @phi = Phi.find(params[:id])
    @municipalities = Municipality.all
    @districts = District.all
  end

  # POST /phis
  # POST /phis.json
  def create
    @phi = Phi.new(params[:phi])
    @municipalities = Municipality.all
    @districts = District.all
    respond_to do |format|
      if @phi.save
        format.html { redirect_to @phi, notice: 'Phi was successfully created.' }
        format.json { render json: @phi, status: :created, location: @phi }
      else
        format.html { render action: "new" }
        format.json { render json: @phi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phis/1
  # PUT /phis/1.json
  def update
    @phi = Phi.find(params[:id])
    @municipalities = Municipality.all
    @districts = District.all

    respond_to do |format|
      if @phi.update_attributes(params[:phi])
        format.html { redirect_to @phi, notice: 'Phi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phis/1
  # DELETE /phis/1.json
  def destroy
    @phi = Phi.find(params[:id])
    @phi.destroy

    respond_to do |format|
      format.html { redirect_to phis_url }
      format.json { head :no_content }
    end
  end
end
