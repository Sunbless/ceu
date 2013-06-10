class TestbasController < ApplicationController
  # GET /testbas
  # GET /testbas.json
  def index
    @testbas = Testba.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @testbas }
    end
  end

  # GET /testbas/1
  # GET /testbas/1.json
  def show
    @testba = Testba.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @testba }
    end
  end

  # GET /testbas/new
  # GET /testbas/new.json
  def new
    @testba = Testba.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @testba }
    end
  end

  # GET /testbas/1/edit
  def edit
    @testba = Testba.find(params[:id])
  end

  # POST /testbas
  # POST /testbas.json
  def create
    @testba = Testba.new(params[:testba])

    respond_to do |format|
      if @testba.save
        format.html { redirect_to @testba, notice: 'Testba was successfully created.' }
        format.json { render json: @testba, status: :created, location: @testba }
      else
        format.html { render action: "new" }
        format.json { render json: @testba.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /testbas/1
  # PUT /testbas/1.json
  def update
    @testba = Testba.find(params[:id])

    respond_to do |format|
      if @testba.update_attributes(params[:testba])
        format.html { redirect_to @testba, notice: 'Testba was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @testba.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testbas/1
  # DELETE /testbas/1.json
  def destroy
    @testba = Testba.find(params[:id])
    @testba.destroy

    respond_to do |format|
      format.html { redirect_to testbas_url }
      format.json { head :no_content }
    end
  end
end
