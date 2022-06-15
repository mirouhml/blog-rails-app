# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'Tom',
  photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxM[…]G90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', bio: 'Teacher from Mexico.', email: 'tom@gmail.com', password: 'tom12345', confirmed_at: DateTime.now)
User.create(name: 'Lilly',
  photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxM[…]G90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', bio: 'Teacher from Poland.', email: 'lilly@gmail.com', password: 'lilly12345', role: 'admin', confirmed_at: DateTime.now)

Post.create(author: User.first, title: 'Post 1', text: 'This is my first post')
Post.create(author: User.first, title: 'Post 2', text: 'This is my second post')
Post.create(author: User.first, title: 'Post 3', text: 'This is my third post')
Post.create(author: User.first, title: 'Post 4', text: 'This is the fourth post')

Comment.create(post: Post.first, author: User.second, text: '1 ')
Comment.create(post: Post.first, author: User.second, text: '2 ')
Comment.create(post: Post.first, author: User.second, text: '3 ')
Comment.create(post: Post.first, author: User.second, text: '4 ')
Comment.create(post: Post.first, author: User.second, text: '5 ')
Comment.create(post: Post.first, author: User.second, text: '6 ')

Like.create(post: Post.first, author: User.first)
Like.create(post: Post.second, author: User.first)
Like.create(post: Post.third, author: User.second)
Like.create(post: Post.fourth, author: User.first)