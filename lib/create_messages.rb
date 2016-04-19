PrivateMessage.transaction do

PrivateMessage.create!(user_id: 2, to: 'admin@fnd.com', content: 'Please add my neighbor, Vlad Graczyk at 20 Test Ave, his email is: vograczyk@valdosta.edu')
PrivateMessage.create!(user_id: 2, to: 'admin@fnd.com', content: 'Also I would really love to be a lead!')
end

Message.transaction do

Message.create!(title: 'Important announcement', content: 'Please support me for becoming a lead!', category: 'Alert', user_id: 2)
Message.create!(title: 'Old Box for Sale', content: 'I am eslling a quality old box, we can negotiate a fair price in person', category: 'Sale', user_id: 3)
Message.create!(title: 'Found Old Green Boot', content: 'I found an old green boot in my backyard recently, if anyone lost it please come by to pick it up!', category: 'Lost & Found', user_id: 4)
Message.create!(title: 'Paint my House!', content: 'Offering top dollar to anyone willing to paint my house', category: 'Jobs', user_id: 5)
end

BusinessMessage.transaction do

BusinessMessage.create!(title: 'Sale Happening!', content: 'Come on down to Business Deliveries for a hot new sale!', user_id: 6)
BusinessMessage.create!(title: 'New Rule', content: 'No more trees allowed in the backyard, if you have a tree please have it removed by May 1st', user_id: 7)

end