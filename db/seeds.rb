require "open-uri"
require "nokogiri"
require "faker"



MissionTag.destroy_all
Tag.destroy_all
Booking.destroy_all
Favorite.destroy_all
Mission.destroy_all
User.destroy_all
Category.destroy_all

img = []
city = []
title = []
departure_date = [] #sur certaines missions y'a pas de date départ prévu, du coup sur la vue -> faire une conidition "if "nil" indiquer "pas de départ prévu"
price = []
duration = []
exception = (12..22).to_a
exception_departure_date = (6..11).to_a # exception pour price et duration aussi


# Scrapping Action solidaire -------------------------------------------

html = URI.open("https://www.doublesens.fr/26-action-solidaire").read
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").each_with_index do |element, index|
  img << element.attr("src") if index.even? && index <= 28 && exception.include?(index) == false
  img << element.attr("src") if index.odd? && index >= 28 && exception.include?(index) == false
end

doc.search(".product-link").each_with_index do |element, index|
  city << element.text if index.even? && exception.include?(index) == false
  title << element.text if index.odd? && exception.include?(index) == false && index !=23
end

doc.search(".product-miniature-depart-container").each_with_index do |element, index|
  departure_date << element.text.strip if exception_departure_date.include?(index) == false
end

doc.search(".price").each_with_index do |element, index|
  price << element.text.strip if exception_departure_date.include?(index) == false
end

doc.search(".nbjours").each_with_index do |element, index|
  duration << element.text.strip if exception_departure_date.include?(index) == false
end

description = []
experience_title1 = []
experience_title2 = []
experience_title3 = []
experience_detail1= []
experience_detail2= []
experience_detail3= []
experience_img1 = []
experience_img2 = []
experience_img3 = []
pattern_for_2nd_paragraphe = [6, 8, 32, 38, 40, 42, 48, 56]
jour_par_jour_img = []
jour_par_jour_text = []
impact_local_img = []
impact_local_text = []
infos_voyage_title1 = []
infos_voyage_title2 = []
infos_voyage_title3 = []
infos_voyage_title4 = []
infos_voyage_text1 = []
infos_voyage_text2 = []
infos_voyage_text3 = []
infos_voyage_text4 = []
banner_img = []

doc.search(".product-miniature-text a").each_with_index do |ele, index|
  if index.even?  && exception.include?(index) == false
    link = ele.attr("href")
    mission_html = URI.open(link).read
    mission_doc = Nokogiri::HTML(mission_html, nil, "utf-8")
    mission_doc.search(".description_long").each do |ele|
      description << ele.text.strip
    end

    # 1er paragraphe de expérience
    experience_img1 << mission_doc.search(".experience-product img").first.attr("src")
    first_title = mission_doc.search(".text-experience-product h3").first
    experience_title1 << first_title.text
    first_ele = mission_doc.search(" .text-experience-product ul").first
    experience_detail1 << first_ele.text

    #la 2eme paragraphe de expérience
    experience_img2 << mission_doc.search(".experience-product img").at(1).attr("src")
    experience_title2 << mission_doc.search(".text-experience-product h3").at(1).text
    experience_detail2 << mission_doc.search(".text-experience-product p").first.text if (pattern_for_2nd_paragraphe.include?(index) == false && index!=34 && index != 36 && index != 46)
    experience_detail2 << mission_doc.search(".text-experience-product p").at(1).text if pattern_for_2nd_paragraphe.include?(index)
    # puts mission_doc.search(".text-experience-product p").first.text if (pattern_for_2nd_paragraphe.include?(index) == false)
    # puts mission_doc.search(".text-experience-product p").at(1).text if pattern_for_2nd_paragraphe.include?(index)
    experience_detail2 << mission_doc.search(".text-experience-product p.MsoNormal").first.text if index == 34
    # experience_detail2 << mission_doc.search(".text-experience-product p").at(2).text if index == (36 || 46)
    # puts mission_doc.search(".text-experience-product p.MsoNormal").first.text if index == 34
    experience_detail2 << mission_doc.search(".text-experience-product p").at(2).text if index == 36 || index == 46

    #3eme paragraphe de expérience
    experience_img3 << mission_doc.search(".experience-product img").at(2).attr("src")
    experience_title3 << mission_doc.search(".text-experience-product h3").at(2).text
    # experience_detail3 << mission_doc.search(".text-experience-product").last.to_s.gsub(/<h3.*?>[\s\S]*<\/h3>/, "")
    experience_detail3 << mission_doc.search(".text-experience-product").at(2).text.gsub("DIMENSION SOLIDAIRE", "").gsub("DIMENSION SOLIDAIRE", "")

    # JOUR PAR JOUR
    jour_par_jour_img << mission_doc.search(".jour_par_jour img").attr("src")
    # puts mission_doc.search(".jour_par_jour").text
    jour_par_jour_text << mission_doc.search(".jour_par_jour")

    # Impact local
    impact_local_img << mission_doc.search(".impact_local img").attr("src")
    impact_local_text << mission_doc.search(".impact_local")

    # Infos voyages
  infos_voyage_title1 << mission_doc.search(".info_voyage h3").first.text
  infos_voyage_title2 << mission_doc.search(".info_voyage h3").at(1).text
  infos_voyage_title3 << mission_doc.search(".info_voyage h3").at(2).text
  infos_voyage_title4 << mission_doc.search(".info_voyage h3").at(3).text

  infos_voyage_text1 << mission_doc.search(".info_voyage p").first.text
  infos_voyage_text2 << mission_doc.search(".info_voyage p").at(1).text
  infos_voyage_text3 << mission_doc.search(".info_voyage p").at(2).text
  infos_voyage_text4 << mission_doc.search(".info_voyage p").at(3).text

  banner_img << mission_doc.search(".imagecover img").attr("src")
  end

end


# Variable TEST --------------------

# puts img
# puts img.size
# puts city
# puts city.size
# puts title
# puts title.size
# puts departure_date
# puts departure_date.size
# puts price
# puts price.size
# puts duration
# puts duration.size
# puts description
# puts description.size

# Variable TEST pour la show ---------------

# puts banner_img
# puts banner_img.size
# puts experience_img1
# puts experience_img1.size
# puts experience_img2
# puts experience_img2.size
# puts experience_img3
# puts experience_img3.size
# puts experience_title1
# puts experience_title1.size
# p experience_detail1[0].split("\n")
# puts experience_detail1.size
# puts experience_title2
# puts experience_title2.size
# experience_detail2.each_with_index do |ele, index|
#   puts ele
#   puts index
# end
# puts experience_detail2.size
# puts experience_title3
# puts experience_title3.size
# experience_detail3.each_with_index do |ele, index|
#   puts ele
#   puts index
# end
# puts experience_detail3.size

# JOUR PAR JOUR
# puts jour_par_jour_img
# puts jour_par_jour_img.size
# puts jour_par_jour_text
# puts jour_par_jour_text.size

# Impact local
# puts impact_local_img
# puts impact_local_img.size
# puts impact_local_text
# puts impact_local_text.size

# Infos voyage
# puts infos_voyage_title1
# puts infos_voyage_title1.size
# puts infos_voyage_title2
# puts infos_voyage_title2.size
# puts infos_voyage_title3
# puts infos_voyage_title3.size
# puts infos_voyage_title4
# puts infos_voyage_title4.size

# puts infos_voyage_text1
# puts infos_voyage_text1.size
# puts infos_voyage_text2
# puts infos_voyage_text2.size
# puts infos_voyage_text3
# puts infos_voyage_text3.size
# puts infos_voyage_text4
# puts infos_voyage_text4.size

# End scrapping Action solidaire-------------------------------

# Creation des mission action solidaire ----------------------------------

i = 0
missions = []
24.times do
  if Mission.where(title: title[i] ).empty?
    mission = Mission.new(
      title: title[i],
      description: description[i],
      address: city[i],
      price: price[i],
      img: img[i],
      departure_date: departure_date[i],
      duration: duration[i],
      experience_title1: experience_title1[i],
      experience_title2: experience_title2[i],
      experience_title3: experience_title3[i],
      experience_detail1: experience_detail1[i],
      experience_detail2: experience_detail2[i],
      experience_detail3: experience_detail3[i],
      experience_img1: experience_img1[i],
      experience_img2: experience_img2[i],
      experience_img3: experience_img3[i],
      jour_par_jour_img: banner_img[i], # Remplacer par la banner car on n'utilise plus jpj_img
      jour_par_jour_text: jour_par_jour_text[i],
      impact_local_img: impact_local_img[i],
      impact_local_text: impact_local_text[i],
      infos_voyage_title1: infos_voyage_title1[i],
      infos_voyage_title2: infos_voyage_title2[i],
      infos_voyage_title3: infos_voyage_title3[i],
      infos_voyage_title4: infos_voyage_title4[i],
      infos_voyage_text1: infos_voyage_text1[i],
      infos_voyage_text2: infos_voyage_text2[i],
      infos_voyage_text3: infos_voyage_text3[i],
      infos_voyage_text4: infos_voyage_text4[i]
    )
    mission.save!
    missions << mission
    puts "one more mission"
  end
  i += 1
end

# End Action solidaire ---------------------------------------------------

# Start scrapping Trek ----------------------------------------

img_trek = []
city_trek = []
title_trek = []
departure_date_trek = [] #sur certaines missions y'a pas de date départ prévu, du coup sur la vue -> faire une conidition "if "nil" indiquer "pas de départ prévu"
price_trek = []
duration_trek = []
exception_trek = [(10..18).to_a]
exception_trek = [1, 3, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 27]

regex = /^https:\/\/www.doublesens.fr\/\d{3}\S*/

html = URI.open("https://www.doublesens.fr/34-treks-randonnees").read
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").each_with_index do |ele, index|
  img_trek << ele.attr("src").match(regex) if exception_trek.include?(index) == false
end

doc.search("#products_full .product-link").each_with_index do |ele, index|
  city_trek << ele.text if index.even?
  title_trek << ele.text if index.odd?
end

doc.search("#products_full .product-miniature-depart-container").each do |ele|
  departure_date_trek << ele.text.strip
end

doc.search("#products_full .nbjours").each do |ele|
  duration_trek << ele.text.strip
end

doc.search("#products_full .price").each do |ele|
  price_trek << ele.text.strip
end

description_trek = []
experience_title1_trek = []
experience_title2_trek = []
experience_title3_trek = []
experience_detail1_trek = []
experience_detail2_trek = []
experience_detail3_trek = []
experience_img1_trek = []
experience_img2_trek = []
experience_img3_trek = []
jour_par_jour_img_trek = []
jour_par_jour_text_trek = []
impact_local_img_trek = []
impact_local_text_trek = []
infos_voyage_title1_trek = []
infos_voyage_title2_trek = []
infos_voyage_title3_trek = []
infos_voyage_title4_trek = []
infos_voyage_text1_trek = []
infos_voyage_text2_trek = []
infos_voyage_text3_trek = []
infos_voyage_text4_trek = []
banner_img_trek = []

# faut mettre products_full sur les searchs pour enlever les doublons ==> du coup c'est fait pour moi Nid mdr
doc.search("#products_full .backgroundimage3 a").uniq.each_with_index do |ele, index|
  mission_trek_url = ele.attr("href")
  mission_trek_html = URI.open(mission_trek_url).read
  mission_trek_doc = Nokogiri::HTML(mission_trek_html, nil, "utf-8")
  mission_trek_doc.search(".description_long").each do |ele|
    description_trek << ele.text.strip
  end

  experience_img1_trek << mission_trek_doc.search(".experience-product img").first.attr("src")
  first_title = mission_trek_doc.search(".text-experience-product h3").first
  experience_title1_trek << first_title.text
  first_ele = mission_trek_doc.search(" .text-experience-product ul").first
  experience_detail1_trek << first_ele.text

  #la 2eme paragraphe de expérience
  experience_img2_trek << mission_trek_doc.search(".experience-product img").at(1).attr("src")
  experience_title2_trek << mission_trek_doc.search(".text-experience-product h3").at(1).text
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").first.text if index != 6 && index != 4 && index != 3 && index != 5 && index != 9 && index != 10 && index != 11
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").at(1).text if index == 4
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").at(2).text if index == 3 || index == 5
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").first.text + mission_trek_doc.search(".text-experience-product p").at(1).text + mission_trek_doc.search(".text-experience-product p").at(2).text if index == 6
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").first.text + mission_trek_doc.search(".text-experience-product p").at(1).text + mission_trek_doc.search(".text-experience-product p").at(2).text + mission_trek_doc.search(".text-experience-product p").at(3).text if index == 9
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").first.text + mission_trek_doc.search(".text-experience-product p").at(1).text + mission_trek_doc.search(".text-experience-product p").at(2).text if index == 10
  experience_detail2_trek << mission_trek_doc.search(".text-experience-product p").first.text + mission_trek_doc.search(".text-experience-product p").at(1).text if index == 11

  # La 3eme paragraphe de expérience
  experience_img3_trek << mission_trek_doc.search(".experience-product img").at(2).attr("src")
  experience_title3_trek << mission_trek_doc.search(".text-experience-product h3").at(2).text
  experience_detail3_trek << mission_trek_doc.search(".text-experience-product").at(2).text.gsub("DIMENSION SOLIDAIRE", "").gsub("DIMENSION SOLIDAIRE", "")

  # JOUR PAR JOUR
  jour_par_jour_img_trek << mission_trek_doc.search(".jour_par_jour img").attr("src")
  jour_par_jour_text_trek << mission_trek_doc.search(".jour_par_jour")

  # Impact local
  impact_local_img_trek << mission_trek_doc.search(".impact_local img").attr("src")
  impact_local_text_trek << mission_trek_doc.search(".impact_local")

  # Infos voyages
  infos_voyage_title1_trek << mission_trek_doc.search(".info_voyage h3").first.text
  infos_voyage_title2_trek << mission_trek_doc.search(".info_voyage h3").at(1).text
  infos_voyage_title3_trek << mission_trek_doc.search(".info_voyage h3").at(2).text
  infos_voyage_title4_trek << mission_trek_doc.search(".info_voyage h3").at(3).text

  infos_voyage_text1_trek << mission_trek_doc.search(".info_voyage p").first.text
  infos_voyage_text2_trek << mission_trek_doc.search(".info_voyage p").at(1).text
  infos_voyage_text3_trek << mission_trek_doc.search(".info_voyage p").at(2).text
  infos_voyage_text4_trek << mission_trek_doc.search(".info_voyage p").at(3).text

  banner_img_trek << mission_trek_doc.search(".imagecover img").attr("src")
end

# Creation mission trek

i = 0
12.times do
  if Mission.where(title: title_trek[i] ).empty?
    mission = Mission.new(
      title: title_trek[i],
      description: description_trek[i],
      address: city_trek[i],
      price: price_trek[i],
      img: img_trek[i],
      departure_date: departure_date_trek[i],
      duration: duration_trek[i],
      experience_title1: experience_title1_trek[i],
      experience_title2: experience_title2_trek[i],
      experience_title3: experience_title3_trek[i],
      experience_detail1: experience_detail1_trek[i],
      experience_detail2: experience_detail2_trek[i],
      experience_detail3: experience_detail3_trek[i],
      experience_img1: experience_img1_trek[i],
      experience_img2: experience_img2_trek[i],
      experience_img3: experience_img3_trek[i],
      jour_par_jour_img: banner_img_trek[i], # Remplacer par la banner car on n'utilise plus jpj_img
      jour_par_jour_text: jour_par_jour_text_trek[i],
      impact_local_img: impact_local_img_trek[i],
      impact_local_text: impact_local_text_trek[i],
      infos_voyage_title1: infos_voyage_title1_trek[i],
      infos_voyage_title2: infos_voyage_title2_trek[i],
      infos_voyage_title3: infos_voyage_title3_trek[i],
      infos_voyage_title4: infos_voyage_title4_trek[i],
      infos_voyage_text1: infos_voyage_text1_trek[i],
      infos_voyage_text2: infos_voyage_text2_trek[i],
      infos_voyage_text3: infos_voyage_text3_trek[i],
      infos_voyage_text4: infos_voyage_text4_trek[i]
    )
    mission.save!
    missions << mission
    puts "one more mission"
  end
  i += 1
end


# Variable TEST

# puts img_trek
# puts img_trek.size
# puts city_trek
# puts city_trek.size
# puts title_trek
# puts title_trek.size
# puts departure_date_trek
# puts departure_date_trek.size
# puts duration_trek
# puts duration_trek.size
# puts price_trek
# puts price_trek.size

# Variable TEST pour la show

# puts banner_img_trek
# puts banner_img_trek.size
# puts experience_img1_trek
# puts experience_img1_trek.size
# puts experience_img2_trek
# puts experience_img2_trek.size
# puts experience_img3_trek
# puts experience_img3_trek.size
# puts description_trek
# puts description_trek.size
# puts experience_title1_trek
# puts experience_title1_trek.size
# puts experience_detail1_trek
# puts experience_detail1_trek.size
# puts experience_title2_trek
# puts experience_title2_trek.size
# puts experience_detail2_trek
# puts experience_detail2_trek.size
# puts experience_title3_trek
# puts experience_title3_trek.size
# experience_detail3_trek.each_with_index do |ele, index|
#   puts ele
#   puts index
# end
# puts experience_detail3_trek.size

# JOUR PAR JOUR
# puts jour_par_jour_img_trek
# puts jour_par_jour_img_trek.size
# puts jour_par_jour_text_trek
# puts jour_par_jour_text_trek.size

# Impact local
# puts impact_local_img_trek
# puts impact_local_img_trek.size
# puts impact_local_text_trek
# puts impact_local_text_trek.size

# Infos voyage
# puts infos_voyage_title1_trek
# puts infos_voyage_title1_trek.size
# puts infos_voyage_title2_trek
# puts infos_voyage_title2_trek.size
# puts infos_voyage_title3_trek
# puts infos_voyage_title3_trek.size
# puts infos_voyage_title4_trek
# puts infos_voyage_title4_trek.size

# puts infos_voyage_text1_trek
# puts infos_voyage_text1_trek.size
# puts infos_voyage_text2_trek
# puts infos_voyage_text2_trek.size
# puts infos_voyage_text3_trek
# puts infos_voyage_text3_trek.size
# puts infos_voyage_text4_trek
# puts infos_voyage_text4_trek.size

# End scrapping trek ------------------------------------------------


# Scrapping vie nomade start ---------------------------------------

img_nomad = []
city_nomad = []
title_nomad = []
departure_date_nomad = [] #sur certaines missions y'a pas de date départ prévu, du coup sur la vue -> faire une conidition "if "nil" indiquer "pas de départ prévu"
price_nomad = []
duration_nomad = []
exception_nomad = [1, 3, 8, 10, 12, 17, 19]
exception_departure_nomad = [6, 7, 8, 9, 10, 11]


html = URI.open("https://www.doublesens.fr/35-vie-nomade").read
doc = Nokogiri::HTML(html, nil, "utf-8")
doc.search(".product-min-container img").uniq.each_with_index do |element, index|
  img_nomad << element.attr("src") if exception_nomad.include?(index) == false
end

img_nomad.uniq!

doc.search(".product-link").each_with_index do |element, index|
  city_nomad << element.text if index.even? && exception_nomad.include?(index) == false
  title_nomad << element.text if index.odd? && exception_nomad.include?(index) == false
end

city_nomad.delete_at(3)
city_nomad.delete_at(3)
city_nomad.delete_at(3)

title_nomad.uniq!

doc.search(".product-miniature-depart-container").each_with_index do |element, index|
  departure_date_nomad << element.text.strip if exception_departure_nomad.include?(index) == false
end


doc.search(".price").each_with_index do |element, index|
  price_nomad << element.text.strip if exception_departure_nomad.include?(index) == false
end

doc.search(".nbjours").each_with_index do |element, index|
  duration_nomad << element.text.strip if exception_departure_nomad.include?(index) == false
end



description_nomad = []
experience_title1_nomad = []
experience_title2_nomad = []
experience_title3_nomad = []
experience_detail1_nomad = []
experience_detail2_nomad = []
experience_detail3_nomad = []
experience_img1_nomad = []
experience_img2_nomad = []
experience_img3_nomad = []
jour_par_jour_img_nomad = []
jour_par_jour_text_nomad = []
impact_local_img_nomad = []
impact_local_text_nomad = []
infos_voyage_title1_nomad = []
infos_voyage_title2_nomad = []
infos_voyage_title3_nomad = []
infos_voyage_title4_nomad = []
infos_voyage_text1_nomad = []
infos_voyage_text2_nomad = []
infos_voyage_text3_nomad = []
infos_voyage_text4_nomad = []
banner_img_nomad = []

doc.search("#products_full .backgroundimage3 a").uniq.each_with_index do |ele, index|
  mission_nomad_url = ele.attr("href")
  mission_nomad_html = URI.open(mission_nomad_url).read
  mission_nomad_doc = Nokogiri::HTML(mission_nomad_html, nil, "utf-8")
  mission_nomad_doc.search(".description_long").each do |ele|
    description_nomad << ele.text.strip
  end

  experience_img1_nomad << mission_nomad_doc.search(".experience-product img").first.attr("src")
  first_title = mission_nomad_doc.search(".text-experience-product h3").first
  experience_title1_nomad << first_title.text
  first_ele = mission_nomad_doc.search(" .text-experience-product ul").first
  experience_detail1_nomad << first_ele.text

  # #la 2eme paragraphe de expérience
  experience_img2_nomad << mission_nomad_doc.search(".experience-product img").at(1).attr("src")
  experience_title2_nomad << mission_nomad_doc.search(".text-experience-product h3").at(1).text
  experience_detail2_nomad << mission_nomad_doc.search(".text-experience-product p").first.text if index != 0  && index != 2 && index != 3 && index != 4
  experience_detail2_nomad << mission_nomad_doc.search(".text-experience-product p").at(1).text if index == 0 || index == 2 || index == 4
  experience_detail2_nomad << mission_nomad_doc.search(".text-experience-product p").at(2).text if index == 3

  # # La 3eme paragraphe de expérience
  experience_img3_nomad << mission_nomad_doc.search(".experience-product img").at(2).attr("src")
  experience_title3_nomad << mission_nomad_doc.search(".text-experience-product h3").at(2).text
  experience_detail3_nomad << mission_nomad_doc.search(".text-experience-product").at(2).text.gsub("DIMENSION SOLIDAIRE", "").gsub("DIMENSION SOLIDAIRE", "")

  # # JOUR PAR JOUR
  jour_par_jour_img_nomad << mission_nomad_doc.search(".jour_par_jour img").attr("src")
  jour_par_jour_text_nomad << mission_nomad_doc.search(".jour_par_jour")

  # # Impact local
  impact_local_img_nomad << mission_nomad_doc.search(".impact_local img").attr("src")
  impact_local_text_nomad << mission_nomad_doc.search(".impact_local")

  # Infos voyages
  infos_voyage_title1_nomad << mission_nomad_doc.search(".info_voyage h3").first.text
  infos_voyage_title2_nomad << mission_nomad_doc.search(".info_voyage h3").at(1).text
  infos_voyage_title3_nomad << mission_nomad_doc.search(".info_voyage h3").at(2).text
  infos_voyage_title4_nomad << mission_nomad_doc.search(".info_voyage h3").at(3).text

  infos_voyage_text1_nomad << mission_nomad_doc.search(".info_voyage p").first.text
  infos_voyage_text2_nomad << mission_nomad_doc.search(".info_voyage p").at(1).text
  infos_voyage_text3_nomad << mission_nomad_doc.search(".info_voyage p").at(2).text
  infos_voyage_text4_nomad << mission_nomad_doc.search(".info_voyage p").at(3).text

  banner_img_nomad << mission_nomad_doc.search(".imagecover img").attr("src")
end


# puts img_nomad
# puts img_nomad.size
# puts city_nomad
# puts city_nomad.size
# puts title_nomad
# puts title_nomad.size
# puts departure_date_nomad
# puts departure_date_nomad.size
# puts price_nomad
# puts price_nomad.size
# puts duration_nomad
# puts duration_nomad.size

# puts banner_img_nomad
# puts banner_img_nomad.size
# puts experience_img1_nomad
# puts experience_img1_nomad.size
# puts experience_img2_nomad
# puts experience_img2_nomad.size
# puts experience_img3_nomad
# puts experience_img3_nomad.size
# puts description_nomad
# puts description_nomad.size
# puts experience_title1_nomad
# puts experience_title1_nomad.size
# puts experience_detail1_nomad
# puts experience_detail1_nomad.size
# puts experience_title2_nomad
# puts experience_title2_nomad.size
# puts experience_detail2_nomad
# puts experience_detail2_nomad.size
# puts experience_title3_nomad
# puts experience_title3_nomad.size
# experience_detail3_nomad.each_with_index do |ele, index|
#   puts ele
#   puts index
# end
# puts experience_detail3_nomad.size

# JOUR PAR JOUR
# puts jour_par_jour_img_nomad
# puts jour_par_jour_img_nomad.size
# puts jour_par_jour_text_nomad
# puts jour_par_jour_text_nomad.size

# Impact local
# puts impact_local_img_nomad
# puts impact_local_img_nomad.size
# puts impact_local_text_nomad
# puts impact_local_text_nomad.size

# Infos voyage
# puts infos_voyage_title1_nomad
# puts infos_voyage_title1_nomad.size
# puts infos_voyage_title2_nomad
# puts infos_voyage_title2_nomad.size
# puts infos_voyage_title3_nomad
# puts infos_voyage_title3_nomad.size
# puts infos_voyage_title4_nomad
# puts infos_voyage_title4_nomad.size

# puts infos_voyage_text1_nomad
# puts infos_voyage_text1_nomad.size
# puts infos_voyage_text2_nomad
# puts infos_voyage_text2_nomad.size
# puts infos_voyage_text3_nomad
# puts infos_voyage_text3_nomad.size
# puts infos_voyage_text4_nomad
# puts infos_voyage_text4_nomad.size


# Creation des missions "vie nomade"
i = 0
8.times do
  if Mission.where(title: title_nomad[i] ).empty?
    mission = Mission.new(
      title: title_nomad[i],
      description: description_nomad[i],
      address: city_nomad[i],
      price: price_nomad[i],
      img: img_nomad[i],
      departure_date: departure_date_nomad[i],
      duration: duration_nomad[i],
      experience_title1: experience_title1_nomad[i],
      experience_title2: experience_title2_nomad[i],
      experience_title3: experience_title3_nomad[i],
      experience_detail1: experience_detail1_nomad[i],
      experience_detail2: experience_detail2_nomad[i],
      experience_detail3: experience_detail3_nomad[i],
      experience_img1: experience_img1_nomad[i],
      experience_img2: experience_img2_nomad[i],
      experience_img3: experience_img3_nomad[i],
      jour_par_jour_img: banner_img_nomad[i], # Remplacer par la banner car on n'utilise plus jpj_img
      jour_par_jour_text: jour_par_jour_text_nomad[i],
      impact_local_img: impact_local_img_nomad[i],
      impact_local_text: impact_local_text_nomad[i],
      infos_voyage_title1: infos_voyage_title1_nomad[i],
      infos_voyage_title2: infos_voyage_title2_nomad[i],
      infos_voyage_title3: infos_voyage_title3_nomad[i],
      infos_voyage_title4: infos_voyage_title4_nomad[i],
      infos_voyage_text1: infos_voyage_text1_nomad[i],
      infos_voyage_text2: infos_voyage_text2_nomad[i],
      infos_voyage_text3: infos_voyage_text3_nomad[i],
      infos_voyage_text4: infos_voyage_text4_nomad[i]
    )
    mission.save!
    missions << mission
    puts "one more mission"
  end
  i += 1
end

puts missions.size

# Creating categories

poussin = Category.create(name: "Poussin Baroudeur", description: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took.")
hibou = Category.create(name: "Hibou Curieux", description: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took.")
toucan = Category.create(name: "Toucan Nomade", description: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took.")
aigle = Category.create(name: "Super Aigle", description: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took.")

# Creating users

10.times do
  name = Faker::Name.first_name
  email = Faker::Internet.email
  password = "123456"
  phone_number = "0607080919"
  user = User.create!(name: name, email: email, password: password, phone_number: phone_number, category: poussin)
end

carole = User.create!(email: "carole@mail.com", password: "123456", name: "Carole", phone_number: "0123456789", category: toucan)
nidal = User.create!(email: "nidal@mail.com", password: "123456", name: "Nidal", phone_number: "0123456789", category: toucan)
clara = User.create!(email: "clara@mail.com", password: "123456", name: "Clara", phone_number: "0123456789", category: toucan)
ruzan = User.create!(email: "ruzan@mail.com", password: "123456", name: "Ruzan", phone_number: "0123456789", category: hibou)
kevin = User.create!(email: "kevin@mail.com", password: "kevlebest", name: "Kevin", phone_number: "0123456789", category: aigle)

puts "finished !!"

Tag.create(name: 'Animal lover', category: toucan)
Tag.create(name: 'Confort', category: toucan)
Tag.create(name: 'Courte durée', category: toucan)

MissionTag.create(mission: Mission.first, tag: Tag.first)
MissionTag.create(mission: Mission.first, tag: Tag.second)
MissionTag.create(mission: Mission.first, tag: Tag.third)
