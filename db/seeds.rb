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

  if response.code != 200
    puts "Error: #{response.message} (status code: #{response.code})"
    break
  end

  data = JSON.parse(response.body)
  cards = data['data']

  if cards.nil? || cards.empty?
    puts "No more cards to fetch."
    break
  end

  puts "Fetched page #{page} with #{cards.size} cards."

  ActiveRecord::Base.transaction do
    cards.each do |card_data|
      begin
        card = Card.create!(
          name: card_data['name'],
          set: card_data['set']['name'],
          rarity: card_data['rarity'],
          type: card_data['types']&.join(', '),
          image_url: card_data['images']['large']
        )
        puts "Created card: #{card.name}"
      rescue => e
        puts "Error creating card: #{e.message}"
        puts "Card data: #{card_data.inspect}"
      end
    end
  end

  page += 1

  # Sleep to avoid hitting rate limits
  sleep(1)
end
