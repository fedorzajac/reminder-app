class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ show edit update destroy dismiss ]

  def dismiss
    @reminder.update(due: false)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@reminder) }
      format.html { redirect_to posts_path, notice: "Post snoozed!" }
    end
  end

  # GET /reminders or /reminders.json
  def index
    @reminders = Reminder.all
    @due_reminders = Reminder.where(due: true)
  end

  # GET /reminders/1 or /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders or /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to reminders_path, notice: "Reminder was successfully created." }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1 or /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to reminders_path, notice: "Reminder was successfully updated." }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1 or /reminders/1.json
  def destroy
    @reminder.destroy!

    respond_to do |format|
      format.html { redirect_to reminders_path, status: :see_other, notice: "Reminder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reminder_params
      params.require(:reminder).permit(:title, :description, :datetime, :price, :recurrence, :due, :scheduler)
    end
end
