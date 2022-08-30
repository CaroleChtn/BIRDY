
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

price_trek = []
doc.search(".price").each do |ele|
  price_trek << ele.text.strip
end

img = []
city = []
title = []
departure_date = [] #sur certaines missions y'a pas de date départ prévu, du coup sur la vue -> faire une conidition if "nil" indiquer "pas de départ prévu"
price = []
duration = []

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


doc.search(".product-miniature-text a").each_with_index do |link, index|
  # if index.even?
    mission_html = URI.open(link).read
    mission_doc = Nokogiri::HTML(mission_html, nil, "utf-8")

    # mission_doc.search(".description_long span").each do |element2|
    #   mission_description << element2.text
    # end

    # mission_doc.search(".text-experience-product h3").each do |element3|
    #   exp_title << element3.text
    # end

    # mission_doc.search(".text-experience-product li").each do |element4|
    #   exp_description1 << element4.text
    # end

    # onglets

    experiences = mission_doc.at('#experience').text.strip.squish
    p experiences
    # mission_doc.search(".img-experience-product img").each do |element5|
    #   img_exp << element5.text
    #   end
  # end
end






# html = URI.open("https://www.joeyrent.com/classic-cars.php").read
# # 1. Parse HTML
# doc = Nokogiri::HTML(html, nil, "utf-8")

# doc.search(".product-image a").each_with_index do |ele, index|
#   title << ele.attr("href") if index.even?
#   car_url = "https://www.joeyrent.com/" + ele.attr("href") if index.even?
#   car_html = URI.open(car_url).read
#   car_doc = Nokogiri::HTML(car_html, nil, "utf-8")
#   seats << car_doc.search(".table > tbody > tr > td").at(1).text if index.even?
#   overview << car_doc.search(".col-md-12 p").at(3).text if index.even?
# end
