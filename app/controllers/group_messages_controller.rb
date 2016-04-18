class GroupMessagesController < ApplicationController
  before_action :set_group_message, only: [:show, :edit, :update, :destroy]
  before_action :moderator_only, only: [:index, :show]
  before_action :your_message, only: [:edit]
  before_action :no_business, only: [:new]

  # GET /group_messages
  # GET /group_messages.json
  def index
    @group_messages = GroupMessage.all
  end

  # GET /group_messages/1
  # GET /group_messages/1.json
  def show
  end

  # GET /group_messages/new
  def new
    @group_message = GroupMessage.new
    @allGroups = Group.all
    @yourGroups = Array.new
    @allGroups.each do |group|
      @allMemberships = Membership.all
      @groupMemberships = Array.new
      @allMemberships.each do |membership|
        if membership.title == group.title
          @groupMemberships.push(membership)
        end
      end
      @groupMemberships.each do |gmember|
        if current_user.id == gmember.user_id
         @yourGroups.push(group.title)
        end
      end
    end
  end
 

  # GET /group_messages/1/edit
  def edit
  end

  # POST /group_messages
  # POST /group_messages.json
  def create
    @group_message = GroupMessage.new(group_message_params)
    @group_message.user_id = current_user.id 
    respond_to do |format|
      if @group_message.save
        format.html { redirect_to groups_path, notice: 'Group message was successfully created.' }
        format.json { render :show, status: :created, location: @group_message }
      else
        format.html { render :new }
        format.json { render json: @group_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_messages/1
  # PATCH/PUT /group_messages/1.json
  def update
    respond_to do |format|
      if @group_message.update(group_message_params)
        format.html { redirect_to groups_path, notice: 'Group message was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_message }
      else
        format.html { render :edit }
        format.json { render json: @group_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_messages/1
  # DELETE /group_messages/1.json
  def destroy
    @group_message.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_message
      @group_message = GroupMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_message_params
      params.require(:group_message).permit(:group_id, :group_name, :content)
    end
    
    def moderator_only
      if current_user.role != "Lead" 
        if current_user.role != "Admin"
          flash[:notice] = "You are not authorized to view this page"
          redirect_to home_path
        end
      end
    end 
    
    def your_message
      if (GroupMessage.find_by(user_id: current_user.id, id: @group_message.id)) == nil
        flash[:notice] = "You cannot edit that comment"
        redirect_to home_path
      end
    end
    
    def no_business
      if current_user.role == "Business"
        flash[:notice] = "Account not authorized for this action"
        redirect_to home_path
      end
    end
end
