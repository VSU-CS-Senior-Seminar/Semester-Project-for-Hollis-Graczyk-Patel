class HomeController < ApplicationController
  before_action :no_business, only: [:profile]
  before_action :moderator_only, only: [:leadCandidates, :currentLeads, :userDirectory]
  
  layout "profile", only: [:profile, :leadCandidates, :currentLeads, :userDirectory]
  
  def index
    @messages = Message.all
  end
  
  def profile
    @messages = Message.all
    @userMessages = Array.new
    @messages.each do |message|
      if message.user_id == current_user.id
        @userMessages.push(message)
      end
    end
    
    @privateMessages = PrivateMessage.all
    @inbox = Array.new
    @privateMessages.each do |message|
      if message.to == current_user.name
        @inbox.push(message)
      end
    end

    @userBookmarks = @current_user.find_up_voted_items
  end
  
 
  def calendar
    @events = Event.all
  end
 
  def leadCandidates
    @allUsers = User.where(:role => 0)
    @possibleLeads = Array.new
    @allUsers.each do |user|
      if user.points > 50
        @possibleLeads.push(user)
      end
    end
  end
  
  def currentLeads
    @allLeads = User.where(:role => 1)
    @leads = Array.new
    @allLeads.each do |lead|
      if lead.id != current_user.id
        @leads.push(lead)
      end
    end
  end
  
  def userDirectory
    @users = User.all
  end
  
  def promote
    user = User.find(params[:id])
    user.update_column(:role, 1)
    redirect_to home_leadCandidates_path
  end
 
  def demote
    lead = User.find(params[:id])
    lead.update_column(:role, 0)
    redirect_to home_currentLeads_path
  end
  
  private
  
    def no_business
      if current_user.role == "Business"
        flash[:notice] = "Account not authorized for this action"
        redirect_to home_path
      end
    end
    
    def moderator_only
      if current_user.role != "Lead" 
        if current_user.role != "Admin"
          flash[:notice] = "You are not authorized to view this page"
          redirect_to home_path
        end
      end
    end 
 
end
