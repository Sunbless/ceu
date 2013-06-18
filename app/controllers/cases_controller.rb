class CasesController < ApplicationController
  before_filter :authenticate_user!
  # GET /cases
  # GET /cases.json
  def index
    @cases = Case.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cases }
    end
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @case = Case.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case }
    end
  end

  # GET /cases/new
  # GET /cases/new.json
  def new
    @case = Case.new
    @case.date_entry = Time.now.strftime("%Y-%m-%d")
    @case.date_report = Time.now.strftime("%Y-%m-%d")
    @case.date_lab = Time.now.strftime("%Y-%m-%d")
    @districts = District.all
    @phis = Phi.all
    @hes = He.all
    @laboratories = Laboratory.all
    @agents = Agent.all
    @doctors = User.find_all_by_user_type(1)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case }
    end
  end

  # GET /cases/1/edit
  def edit
    @case = Case.find(params[:id])
    @districts = District.all
    @phis = Phi.all
    @hes = He.all
    @laboratories = Laboratory.all
    @agents = Agent.all
    @doctors = User.find_all_by_user_type(1)
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(params[:case])
    @case.operator_id = current_user.id
    @districts = District.all
    @phis = Phi.all
    @hes = He.all
    @laboratories = Laboratory.all
    @agents = Agent.all
    @doctors = User.find_all_by_user_type(1)

    respond_to do |format|
      if @case.save
        format.html { redirect_to @case, notice: t("record_created") }
        format.json { render json: @case, status: :created, location: @case }
      else
        format.html { render action: "new" }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cases/1
  # PUT /cases/1.json
  def update
    @case = Case.find(params[:id])
    @districts = District.all
    @phis = Phi.all
    @hes = He.all
    @laboratories = Laboratory.all
    @agents = Agent.all
    @doctors = User.find_all_by_user_type(1)

    respond_to do |format|
      if @case.update_attributes(params[:case])
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case = Case.find(params[:id])
    @case.destroy

    respond_to do |format|
      format.html { redirect_to cases_url }
      format.json { head :no_content }
    end
  end
end
