# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'httparty'
require 'json'

base_url = 'https://api.pokemontcg.io/v2/cards'
page = 1
per_page = 100
loop do
  response = HTTParty.get(base_url, query: { page: page, pageSize: per_page })
  data = JSON.parse(response.body)
  cards = data['data']
  break if cards.empty?

  cards.each do |card_data|
    Card.create(
      name: card_data['name'],
      set: card_data['set']['name'], # Assuming set data is nested
      rarity: card_data['rarity'],
      type: card_data['types']&.join(', '), # Assuming types is an array
      image_url: card_data['images']['large'] # Assuming image URL is under 'images' key
    )
  end
  page += 1
end
