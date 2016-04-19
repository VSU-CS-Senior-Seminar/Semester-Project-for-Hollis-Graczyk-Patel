class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :check_your_group, only: [:show]
  before_action :no_business, only: [:index, :new]
  before_action :group_owner, only: [:edit]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @memberships = Membership.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @memberships = Membership.all
    @allGroupMessages = GroupMessage.all
    @currentMessages = Array.new
    
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    points = current_user.points + 4
    current_user.update_column(:points, points)
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, :description)
    end
    
    def check_your_group
      if  (Membership.find_by(user_id: current_user.id, group_id: @group.id)) == nil
        flash[:notice] = 'You cannot access that group'
        redirect_to home_path
      end
    end
    
    def no_business
      if current_user.role == "Business"
        flash[:notice] = "Account not authorized for this action"
        redirect_to home_path
      end
    end
    
    def group_owner
      if (Group.find_by(user_id: current_user.id, id: @group.id)) == nil
        flash[:notice] = "You cannot edit that group"
        redirect_to home_path
      end
    end
    
end
