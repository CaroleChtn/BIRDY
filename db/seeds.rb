require "open-uri"
require "nokogiri"

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
