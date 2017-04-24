# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do

  User.destroy_all
  user1 = User.create(email: 'email1')
  user2 = User.create(email: 'email2')
  user3 = User.create(email: 'email3')
  user4 = User.create(email: 'email4')
  user5 = User.create(email: 'email5')
  user6 = User.create(email: 'email6')
  user7 = User.create(email: 'email7')
  user8 = User.create(email: 'email8')
  user9 = User.create(email: 'email9')
  user10 = User.create(email: 'email10')

  ShortenedUrl.destroy_all
  url1 = ShortenedUrl.from_url(user: user1, long_url: 'url1')
  url2 = ShortenedUrl.from_url(user: user2, long_url: 'url2')
  url3 = ShortenedUrl.from_url(user: user3, long_url: 'url3')
  url4 = ShortenedUrl.from_url(user: user4, long_url: 'url4')
  url5 = ShortenedUrl.from_url(user: user5, long_url: 'url5')
  url6 = ShortenedUrl.from_url(user: user6, long_url: 'url6')
  url7 = ShortenedUrl.from_url(user: user7, long_url: 'url7')
  url8 = ShortenedUrl.from_url(user: user7, long_url: 'url8')
  url9 = ShortenedUrl.from_url(user: user7, long_url: 'url9')
  url10 = ShortenedUrl.from_url(user: user8, long_url: 'url10')

  Visit.destroy_all
  v1 = Visit.record_visit!(user: user1, short_url: url3)
  v12 = Visit.record_visit!(user: user1, short_url: url3)
  v11 = Visit.record_visit!(user: user1, short_url: url3)
  v2 = Visit.record_visit!(user: user1, short_url: url2)
  v3 = Visit.record_visit!(user: user1, short_url: url10)
  v4 = Visit.record_visit!(user: user1, short_url: url9)
  v5 = Visit.record_visit!(user: user2, short_url: url2)
  v6 = Visit.record_visit!(user: user3, short_url: url9)
  v7 = Visit.record_visit!(user: user1, short_url: url3)
  v8 = Visit.record_visit!(user: user7, short_url: url9)
  v9 = Visit.record_visit!(user: user6, short_url: url2)
  v10 = Visit.record_visit!(user: user9, short_url: url3)

end
