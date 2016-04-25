User.transaction do

User.delete_all
#Users
User.create( :email => 'admin@fnd.com', :password => 'adminpass', :password_confirmation => 'adminpass', :role => "Admin", :name => "John Smith", :address => "222 Fairview Drive")
User.create( :email => 'happytree@hotmail.com', :password => 'treepass', :password_confirmation => 'treepass', :role => "User", :points => 59, :name => "Cassandra	Wilson", :address => "142 Sunnymeade Drive")
User.create( :email => 'polarbear@gmail.com', :password => 'icecold10', :password_confirmation => 'icecold10', :role => "User", :points => 71, :name => "Sergio	Brooks", :address => "132 Sunnymeade Drive")
User.create( :email => 'yellowrabbit@yahoo.com', :password => 'wyth133s', :password_confirmation => 'wyth133s', :role => "User", :points => 22, :name => "Aaron	Horton", :address => "126 Sunnymeade Drive")
User.create( :email => 'viktor@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 25, :name => "Viktor Graczyk", :address => "202 Fairview Drive")
User.create( :email => 'michael@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 48, :name => "Michael Hollis", :address => "203 Fairview Drive")
User.create( :email => 'akshay@hotmail.com', :password => 'password', :password_confirmation => 'password', :role => "User", :points => 60, :name => "Akshay Patel", :address => "201 Fairview Drive")
User.create( :email => 'clothesminded@gmail.com', :password => 'clothpass', :password_confirmation => 'clothpass', :role => "Business", :points => 0, :name => "Clothes Minded", :address => "100 Starmount Avenue")
User.create( :email => 'abcmarkets@yahoo.com', :password => 'marketpass', :password_confirmation => 'marketpass', :role => "Business", :points => 0, :name => "ABC Markets", :address => "305 Starmount Avenue")
User.create( :email => 'hoa@hotmail.com', :password => 'homeassociation', :password_confirmation => 'homeassociation', :role => "Business", :points => 0, :name => "Home Owners Association", :address => "133 Hayfield Lane")
#Messages
admin_id = (User.find_by(email: 'admin@fnd.com')).id
Message.create!(title: 'Welcome to Friends Next Door!',
                content: 'Enjoy your stay everyone, contact me if you have any issues with the site. Take care!',
                category: 'Alert',
                user_id: admin_id)
vik_id = (User.find_by(email: 'viktor@hotmail.com')).id
Message.create!(title: 'Found Brass Watch',
                content: 'I found a small brass watch in my backyard this morning, if it belongs to you please come on by as soon as you can',
                category: 'Lost & Found',
                user_id: vik_id)
Message.create!(title: 'Pool Party',
                content: 'Was thinking about organizing a neighborhood pool party sometime next week, anybody interested? Please comment!',
                category: 'General',
                user_id: vik_id)
mike_id = (User.find_by(email: 'michael@hotmail.com')).id
Message.create!(title: 'Selling Sofa',
                content: 'Hey all, I am restructuring my living room and need to get rid of my current sofa. I am willing to negotiate a fair price, so come on by and take a look!',
                category: 'Sale',
                user_id: mike_id)
akshay_id = (User.find_by(email: 'akshay@hotmail.com')).id
Message.create!(title: 'Lawn Mower Needed',
                content: 'Looking for a local to mow the lawn for me, 30$ starting offer.',
                category: 'Jobs',
                user_id: akshay_id)
cass_id = (User.find_by(email: 'happytree@hotmail.com')).id
Message.create!(title: 'Campaigning for Lead!',
                content: 'Hello everyone! I wanted to ask for support from all of you to help me secure a lead position. I would work hard and take the responsibilty very seriously should I be promoted.',
                category: 'General',
                user_id: cass_id)
sergei_id = (User.find_by(email: 'polarbear@gmail.com')).id
Message.create!(title: 'Robbery',
                content: 'Just wanted to give everyone a heads up, last night someone broke into my back porch and took a few tools I had laying around. Make sure your homes are extra secure just in case they try to strike again!',
                category: 'Alert',
                user_id: sergei_id)
aaron_id = (User.find_by(email: 'yellowrabbit@yahoo.com')).id
Message.create!(title: 'Painters Wanted',
                content: 'If anyone in the neighborhood is handy with a paintbrush and wants to earn some spending money, I need a few people to help me re-paint several rooms in my house. I have all the materials, so all you need to bring is a can-do attitude!',
                category: 'Jobs',
                user_id: aaron_id)
#Business Messages             
hoa_id = (User.find_by(email: 'hoa@hotmail.com')).id
BusinessMessage.create!(title: 'Rule Change',
                        content: 'Fences around a property must be either wood or stone, no more chain-link fences are allowed. This change will take strict effect in November to give time for changes to take affect.', 
                        user_id: hoa_id)
clothes_id = (User.find_by(email: 'clothesminded@gmail.com')).id
BusinessMessage.create!(title: 'Sale on Pants!',
                        content: 'We are proud to announce a 50% off sale on all pants at Clothes Minded! Come on down to 100 Starmount Avenue soon to take advantage of this great deal!', 
                        user_id: clothes_id)
abc_id = (User.find_by(email: 'abcmarkets@yahoo.com')).id
BusinessMessage.create!(title: 'Fresh Produce Arrives!',
                        content: 'Just got in a fresh new shipment of produce, straight from local fields! ABC Markets carries only the best, come to 305 Starmount Avenue today and see for yourself!', 
                        user_id: abc_id)
BusinessMessage.create!(title: 'HOA Official Meeting',
                        content: 'We will be hosting a community get-together this May 1st, we encourage all members to come and talk about current policies and issues that need to be addressed. We look forward to seeing you all there!', 
                        user_id: hoa_id)
#Private Messages
PrivateMessage.create!(user_id: vik_id,
                       to: 'John Smith',
                       content: 'Please add my brother to this website: Vlad Graczyk at 202 Fairview Drive, his email is: vograczyk@valdosta.edu')
PrivateMessage.create!(user_id: cass_id,
                       to: 'John Smith',
                       content: 'Just wanted to ask if you could consider me for a lead position, I would do a lot of good for this site!')
PrivateMessage.create!(user_id: sergei_id,
                       to: 'John Smith',
                       content: 'Hey I wanted to organize a BBQ at my house on the 30th, do you think you could add that to the calendar? Thanks in advance!')
end