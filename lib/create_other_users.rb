User.transaction do

User.create( :email => 'wannabeLead@fnd.com', :password => 'changeme', :password_confirmation => 'changeme', :role => "User", :points => 59, :name => "Lead Me", :address => "21 Test Ave")
User.create( :email => 'viktor@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 0, :name => "Viktor Graczyk", :address => "19 FND Lane")
User.create( :email => 'michael@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 10, :name => "Michael Hollis", :address => "20 FND Lane")
User.create( :email => 'akshay@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 20, :name => "Akshay Patel", :address => "21 FND Lane")
User.create( :email => 'business@hotmail.com', :password => 'business', :password_confirmation => 'business', :role => "Business", :points => 0, :name => "Business Deliveries", :address => "100 Business Road")
User.create( :email => 'hoa@hotmail.com', :password => 'business', :password_confirmation => 'business', :role => "Business", :points => 0, :name => "Home Owners Association", :address => "0 HOA St")

end