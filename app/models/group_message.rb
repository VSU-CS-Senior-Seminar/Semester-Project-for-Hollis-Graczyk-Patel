class GroupMessage < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
   private
    before_save {|message| message.group_id = (Group.find_by(title: message.group_name)).id }
end
