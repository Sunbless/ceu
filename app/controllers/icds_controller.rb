class IcdsController < ApplicationController
  # GET /icds
  # GET /icds.json
  def index
    @icds = Icd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @icds }
    end
  end

  # GET /icds/1
  # GET /icds/1.json
  def show
    @icd = Icd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @icd }
    end
  end

  # GET /icds/new
  # GET /icds/new.json
  def new
    @icd = Icd.new
    @parents = Icd.find_all_by_int(0)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @icd }
    end
  end

  # GET /icds/1/edit
  def edit
    @icd = Icd.find(params[:id])
    @parents = Icd.find_all_by_int(0)
  end

  # POST /icds
  # POST /icds.json
  def create
    @icd = Icd.new(params[:icd])
    @parents = Icd.find_all_by_int(0)
    respond_to do |format|
      if @icd.save
        format.html { redirect_to @icd, notice: 'Icd was successfully created.' }
        format.json { render json: @icd, status: :created, location: @icd }
      else
        format.html { render action: "new" }
        format.json { render json: @icd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /icds/1
  # PUT /icds/1.json
  def update
    @icd = Icd.find(params[:id])
    @parents = Icd.find_all_by_int(0)
    respond_to do |format|
      if @icd.update_attributes(params[:icd])
        format.html { redirect_to @icd, notice: 'Icd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @icd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icds/1
  # DELETE /icds/1.json
  def destroy
    @icd = Icd.find(params[:id])
    @icd.destroy

    respond_to do |format|
      format.html { redirect_to icds_url }
      format.json { head :no_content }
    end
  end
end
