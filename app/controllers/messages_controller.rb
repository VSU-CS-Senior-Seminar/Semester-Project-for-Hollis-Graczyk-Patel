class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :moderator_only, only: [:index]
  before_action :no_business, only: [:new]
  before_action :your_message, only: [:edit]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.html { redirect_to home_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    user = User.find_by(id: @message.user_id)
    points = user.points + 1
    if (current_user.voted_as_when_voting_on @message) == true
      #Do nothing
    else
      user.update_column(:points, points)
    end
    @message.upvote_from current_user
    redirect_to home_path
  end

  def downvote
    user = User.find_by(id: @message.user_id)
    if user.points > 0
      points = user.points - 1
    else
      points = 0
    end
    if (current_user.voted_as_when_voting_on @message) == false
      #Do nothing
    else
      user.update_column(:points, points)
    end
    @message.downvote_from current_user
    redirect_to home_path
  end

  def count
    @current_user.find_voted_items
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :content, :category, :user_id)
    end
    
    def moderator_only
      if current_user.role != "Lead" 
        if current_user.role != "Admin"
          flash[:notice] = "You are not authorized to view this page"
          redirect_to home_path
        end
      end
    end 
    
    def no_business
      if current_user.role == "Business"
        flash[:notice] = "Account not authorized for this action"
        redirect_to home_path
      end
    end
    
    def your_message
      if (Message.find_by(user_id: current_user.id, id: @message.id)) == nil
        flash[:notice] = "You cannot edit that message"
        redirect_to home_path
      end
    end
    
end
