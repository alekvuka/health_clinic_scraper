require 'pry'
require 'nokogiri'
require 'open-uri'


class Scraper

  def self.scrape_page(clinic_url)
    html = open(clinic_url)
    doc = Nokogiri::HTML(html)

    name_qualifications_title = doc.css(".middleColumn_three").css('h3').first.text.split(",")

    name = name_qualifications_title[0]
    qualification = name_qualifications_title[1]
    title = name_qualifications_title[2]

    team_specialties_languages = doc.css(".middleColumn_three").css('ul').first.text
    t_s_l_array = team_specialties_languages.split("\n").reject { |n| n == "" }

    cleaned_t_s_l_array = t_s_l_array.map do |ele|
      ele.gsub(/\w+[:]/, "").strip
    end

    team = cleaned_t_s_l_array[0]
    specialties = cleaned_t_s_l_array[1]
    languages = cleaned_t_s_l_array[2]


    attr_hash = Hash.new
    array_of_providers = Array.new


    #getting name, qualification and title attributes 
    doc.css(".middleColumn_three").css('h3').each do |provider|
      new_hash = Hash.new
      team_specialties_languages = provider.text.split(",")
      new_hash[:name] = team_specialties_languages[0].strip
      new_hash[:qualification] = team_specialties_languages[1].strip
      new_hash[:title] = team_specialties_languages[1].strip
      array_of_providers << new_hash
    end



    #binding.pry






  end

end

Scraper.scrape_page("http://callen-lorde.org/meet-our-providers/")
