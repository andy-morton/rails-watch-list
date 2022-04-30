# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "open-uri"

puts "cleaning up database"
Movie.destroy_all
puts "database is clean"

puts "Creating Movies"

url = "https://tmdb.lewagon.com/movie/top_rated"


  movies_serialized = URI.open("#{url}?page=1").read
  movies = JSON.parse(movies_serialized)['results']
  movies.each do |movie|
  base_poster_url = 'https://image.tmdb.org/t/p/original'
    movie = Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      rating: movie['vote_average'],
      poster_url: "#{base_poster_url}#{movie['poster_path']}"
    )
    puts "movie #{movie.title} is created"
  end
