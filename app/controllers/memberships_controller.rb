class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :moderator_only, only: [:index, :show, :edit]
  before_action :no_business, only: [:new]
  

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @userInfo = User.where.not(id: current_user, role: 2)
    @userEmail = Array.new
    @userInfo.each do |user|
      @userEmail.push(user.email)
    end
  
    
    @groupInfo = Group.all
    @yourGroups = Array.new
    @groupInfo.each do |group|
      if group.user_id == current_user.id
        @yourGroups.push(group.title)
      end
    end
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to groups_path, notice: 'User was successfully added to group.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :group_id, :email, :title)
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
    
end
