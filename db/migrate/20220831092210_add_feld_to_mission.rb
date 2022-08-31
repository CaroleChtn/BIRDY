class AddFeldToMission < ActiveRecord::Migration[7.0]
  def change
    add_column :missions, :img, :string
    add_column :missions, :departure_date, :string
    add_column :missions, :duration, :string
    add_column :missions, :experience_title1, :string
    add_column :missions, :experience_title2, :string
    add_column :missions, :experience_title3, :string
    add_column :missions, :experience_detail1, :text
    add_column :missions, :experience_detail2, :text
    add_column :missions, :experience_detail3, :text
    add_column :missions, :experience_img1, :string
    add_column :missions, :experience_img2, :string
    add_column :missions, :experience_img3, :string
    add_column :missions, :jour_par_jour_img, :string
    add_column :missions, :jour_par_jour_text, :text
    add_column :missions, :impact_local_img, :string
    add_column :missions, :impact_local_text, :text
    add_column :missions, :infos_voyage_title1, :string
    add_column :missions, :infos_voyage_title2, :string
    add_column :missions, :infos_voyage_title3, :string
    add_column :missions, :infos_voyage_title4, :string
    add_column :missions, :infos_voyage_text1, :text
    add_column :missions, :infos_voyage_text2, :text
    add_column :missions, :infos_voyage_text3, :text
    add_column :missions, :infos_voyage_text4, :text
  end
end
