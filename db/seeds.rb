# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "nokogiri"

img = []
i = 0

html = URI.open("https://www.doublesens.fr/26-action-solidaire").read
# 1. Parse HTML
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").each_with_index do |ele, index|
  img << ele.attr("src") if index.even? && index <= 28
  img << ele.attr("src") if index.odd? && index >= 28
end


puts img
puts img.size
