Friendship.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:friendships)
FriendRequest.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:friend_requests)
Post.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:posts)
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:users)

10.times do
  user = FactoryBot.build(:user)
  user.skip_confirmation!
  user.save
end

users = User.all

30.times do
  user = users[rand(users.count)]
  post = user.posts.build(body: Faker::Lorem.paragraph(sentence_count: rand(1..6)))
  post.save
end
