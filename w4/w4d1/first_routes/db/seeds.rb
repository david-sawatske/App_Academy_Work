# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  User.destroy_all
  u1 = User.create(username: 'dobrynin')
  u2 = User.create(username: 'sawatske')

  Artwork.destroy_all
  a1 = Artwork.create(image_url: 'https://upload.wikimedia.org/wikipedia/en/5/58/Interchange_%28de_Kooning%29.jpg',
                      title: 'Interchange', artist_id: u1.id)
  a2 = Artwork.create(image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Card_Players-Paul_Cezanne.jpg/1024px-Card_Players-Paul_Cezanne.jpg',
                    title: 'The Card Players', artist_id: u2.id)

  ArtworkShare.destroy_all
  as1 = ArtworkShare.create(artwork_id: a1.id, viewer_id: u2.id)
  as2 = ArtworkShare.create(artwork_id: a2.id, viewer_id: u1.id)
  as3 = ArtworkShare.create(artwork_id: a1.id, viewer_id: u1.id)

  Comment.destroy_all
  c1 = Comment.create(artwork_id: as1.id, user_id: u2.id, body: "This thing. I don't like this thing.")
  c2 = Comment.create(artwork_id: as1.id, user_id: u1.id, body: "I like it!")
