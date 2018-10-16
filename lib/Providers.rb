class Providers

  @@all = Array.new

  attr_accessor :name, :team, :specialties, :languages, :title, :qualifications

  def initialize(attr_hash)

    @name = attr_hash[:name]
    @team = attr_hash[:team]
    @specialties = attr_hash[:specialties]
    Languages.add_by_name(attr_hash[:languages], self)
    @title = attr_hash[:title]
    @qualifications = attr_hash[:qualification]

    @@all << self
  end

  def self.all
    @@all
  end

end
