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
  def spoc_handle(email,count)
    checkIfAdmin()
    if User.exists?(:email=>email)
      @user=User.find_by email:email
      if @user.spoc==true
        @eve=Event.find_by id:@user.spoc_event_id
        @err[count]=email.to_s+" is already a spoc of the event \"".to_s+@eve.name+"\" click the edit button to enter another spoc"
      else
        @user.spoc_event_id=@event.id
        @user.spoc=true
        @user.save
      end
    else
      @err[count]="The email \"".to_s+email+"\" was not found click on the edit button to enter a valid email"
    end
  end
  def spoc
    checkIfAdmin()
    @err = Array.new(6, "")
    spoc_handle(params["email_spoc1"],0)
    spoc_handle(params["email_spoc2"],1)
    spoc_handle(params["email_spoc3"],2)
    spoc_handle(params["email_spoc4"],3)
    spoc_handle(params["email_spoc5"],4)
    spoc_handle(params["email_spoc6"],5)
    if(params["email_spoc1"]=="")
      @err[0]=""
    end
    if(params["email_spoc2"]=="")
      @err[1]=""
    end
    if(params["email_spoc3"]=="")
      @err[2]=""
    end
    if(params["email_spoc4"]=="")
      @err[3]=""
    end
    if(params["email_spoc5"]=="")
      @err[4]=""
    end
    if(params["email_spoc6"]=="")
      @err[5]=""
    end
    @err1=@err[0]
    @err2=@err[1]
    @err3=@err[2]
    @err4=@err[3]
    @err5=@err[4]
    @err6=@err[5]
  end
  def create
    checkIfAdmin()
    @event = Event.new(event_params)
    #render plain: @exist
    #render plain: @user
    if @event.save
      spoc()
      render "show"
    else
      render 'new'
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    checkIfAdmin()
    #respond_to do |format|
    if @event.update(event_params)
      User.where(spoc_event_id: @event.id).find_each do |user|
        user.spoc=false
        user.spoc_event_id=0
        user.save
      end
      spoc()
      #format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      #format.json { render :show, status: :ok, location: @event }
      render 'show'
    else
      render 'edit'
      #format.html { render :edit }
      #format.json { render json: @event.errors, status: :unprocessable_entity }
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
    params.require(:event).permit(:name, :description, :icon, :rules, :minimum_team_size, :maximum_team_size, :contact_details, :last_date, :event_type)
  end
end

# Only admin allowed to manage events

private

def checkIfAdmin()
  if current_user.user_type != "admin"
    redirect_to controller: 'registration', action: 'index'
  end
end
