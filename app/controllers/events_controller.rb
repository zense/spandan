class EventsController < ApplicationController
  # Make this controller available only to admins
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    checkIfAdmin()
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    checkIfAdmin()
  end

  # GET /events/new
  def new
    checkIfAdmin()
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    checkIfAdmin()
  end

  # POST /events
  # POST /events.json
  def create
    checkIfAdmin()
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    checkIfAdmin()
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    checkIfAdmin()
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :avatar, :rules, :minimum_team_size, :maximum_team_size, :contact_details, :last_date, :event_type)
    end
end

# Only admin allowed to manage events

private

  def checkIfAdmin()
    if current_user.user_type != "admin"
      redirect_to controller: 'registration', action: 'index'
    end
  end
