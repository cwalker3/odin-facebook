User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(:users)
ActiveRecord::Base.connection.reset_pk_sequence!(:posts)
ActiveRecord::Base.connection.reset_pk_sequence!(:comments)
ActiveRecord::Base.connection.reset_pk_sequence!(:likings)
ActiveRecord::Base.connection.reset_pk_sequence!(:friendships)
ActiveRecord::Base.connection.reset_pk_sequence!(:friend_requests)

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

posts = Post.all

30.times do
  post = posts[rand(posts.count)]
  liking = post.likings.build(user_id: rand(users.count))
  liking.save
end

