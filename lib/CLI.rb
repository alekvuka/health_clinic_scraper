#this is the class that is responsible for interacting with the user

require_relative "Scraper.rb"
require_relative "Providers.rb"

class CLI


  def initialize(clinic_url = "http://callen-lorde.org/meet-our-providers/")
    Scraper.scrape_page(clinic_url)
  end


  def start

    puts "Choose from the following menu:"
    puts "1) List of all providers"
    puts "2) Details on a specific provider"
    puts "3) List of providers by their team"
    puts "4) List of providers by their specialty"

    user_input = gets.strip.to_i


    if valid?(user_input) == true
      if user_input == 1
        choice_1
      elsif user_input == 2
        choice_2
      elsif user_input == 3
        choice_3
      else
        choice_4
      end
    end
    start

  end

  def choice_1


    name_array = Providers.all.map do |provider|
              provider.name
            end
    printer(name_array)

  end


  def choice_2

    puts "Which provider would you like to know more about?"
    user_input = gets.strip



    all_providers = Providers.all
    req_provider = all_providers.detect do |provider|
      user_input == provider.name
      #binding.pry
      end

    return_validator(req_provider)

    puts "=============================="
    if req_provider.team != nil
      puts "#{req_provider.name}'s team: #{req_provider.team}"
    end 
    puts "#{req_provider.name}'s specialties: #{req_provider.specialties}"
    puts "#{req_provider.name}'s languages: #{req_provider.languages}"
    puts "#{req_provider.name}'s qualifications: #{req_provider.qualifications}"
    puts "=============================="

  end

  def choice_3
    puts "From what team would you like to get a list of providers (Orange, Green, Purple, Blue)"
    user_input = gets.strip

    all_providers = Providers.all

    return_array = Array.new

    all_providers.each do |provider|
      if provider.team == user_input
        return_array << provider.name
      end
    end

    return_validator(return_array)
    printer(return_array)

  end

  def choice_4
    puts "From what specialty: Adolescent Health, Family Practice, HIV, Adult Primary Care or Internal Medicine"
    user_input = gets.strip

    all_providers = Providers.all

    return_array = Array.new

    all_providers.each do |provider|
      temp_arr = provider.specialties.split(",")

      i = 0
      while i < temp_arr.size
        #binding.pry
        if temp_arr[i].strip == user_input
          return_array << provider.name
        end
        i+=1
      end
    end

    return_validator(return_array)
    printer(return_array.uniq)

  end

  def valid?(user_input)
    if user_input == 1 || user_input == 2 || user_input == 3 || user_input == 4
      true
    else
      false
    end
  end

  def return_validator(array_or_hash)

    #binding.pry

    if array_or_hash == nil #|| array_or_hash.any?
      puts "======================================================================================================"
      puts "!!!!!!!!   The doctor, team or specialty that you have choosen does not exit in this clinic   !!!!!!!!"
      puts "======================================================================================================"
      start

    elsif array_or_hash.instance_of?(Array) && array_or_hash.any? == false
      puts "======================================================================================================"
      puts "!!!!!!!!   The doctor, team or specialty that you have choosen does not exit in this clinic   !!!!!!!!"
      puts "======================================================================================================"
      start

    end



  end

  def printer(arry_to_print)


    puts "<<<<<<<<<<<<                HERE IS THE LIST:                             >>>>>>>>>>>"

    i = 0
    while i < arry_to_print.size
      puts arry_to_print[i]
      i+=1
    end
    puts "^^^^^^               THE PROVIDERS ARE LISTED ABOVE                         ^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

  end

end