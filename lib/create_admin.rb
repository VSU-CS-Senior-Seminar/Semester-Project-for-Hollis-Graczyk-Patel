User.transaction do

User.delete_all
User.create( :email => 'admin@fnd.com', :password => 'changeme', :password_confirmation => 'changeme', :role => "Admin", :name => "John Jones", :address => "222 FND Lane")
user_id = (User.find_by(email: 'admin@fnd.com')).id
  Message.create!(title: 'Admin Test Post',
                  content: 'Welcome to Friends Next Door!',
                  category: 'Alert',
                  user_id: user_id)
end