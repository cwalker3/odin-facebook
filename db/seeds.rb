User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(:users)
ActiveRecord::Base.connection.reset_pk_sequence!(:posts)
ActiveRecord::Base.connection.reset_pk_sequence!(:comments)
ActiveRecord::Base.connection.reset_pk_sequence!(:likings)
ActiveRecord::Base.connection.reset_pk_sequence!(:friendships)
ActiveRecord::Base.connection.reset_pk_sequence!(:friend_requests)

# create 10 users with a profile, a post
10.times do
  user = FactoryBot.build(:user)
  user.skip_confirmation!
  user.save
  FactoryBot.create(:profile, user: user)
  FactoryBot.create(:post, user: user)
end

# add friends for first User, 3 as friend2, 3 as friend 1, 3 left unfriended
for i in 2..10
  case i
  when 5..7
    Friendship.create(friend1_id: 1, friend2_id: i)
  when 8..10
    Friendship.create(friend1_id: i, friend2_id: 1)
  end
end

for i in 1..10
  user = User.all[i - 1]
  Post.first.likings.create(user_id: user.id)
end


