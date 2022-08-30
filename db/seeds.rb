
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"
require "nokogiri"
img_trek = []
regex = /^https:\/\/www.doublesens.fr\/\d{3}\S*/
html = URI.open("https://www.doublesens.fr/34-treks-randonnees").read
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").each do |ele|
  ele.attr("src").match(regex)
end

city_trek = []
title_trek = []
doc.search(".product-link").each_with_index do |ele, index|
  ele.text if index.even?
  ele.text if index.odd?
end

departure_date_trek = []
doc.search(".product-miniature-depart-container").each do |ele|
  departure_date_trek << ele.text.strip
end

days_missions_trek = []
doc.search(".nbjours").each do |ele|
  days_missions_trek << ele.text.strip
end

price_trek =[]
doc.search(".price").each do |ele|
  price_trek << ele.text.strip


img = []
city = []
title = []
departure_date = [] #sur certaines missions y'a pas de date départ prévu, du coup sur la vue -> faire une conidition "if "nil" indiquer "pas de départ prévu"
price = []
duration= []

html = URI.open("https://www.doublesens.fr/26-action-solidaire").read
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").each_with_index do |element, index|
  img << element.attr("src") if index.even? && index <= 28
  img << element.attr("src") if index.odd? && index >= 28
end


doc.search(".product-link").each_with_index do |element, index|
  city << element.text if index.even?
  title << element.text if index.odd?
end


doc.search(".product-miniature-depart-container").each do |element|
  departure_date << element.text.strip
end


doc.search(".price").each do |element|
  price << element.text.strip
end


doc.search(".nbjours").each do |element|
  duration << element.text.strip
end
