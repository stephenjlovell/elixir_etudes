module Geography

  class Country
    attr_accessor :name, :language, :cities
    def initialize(name, language, cities = [])
      @name, @language, @cities = name, language, cities
    end
  end

  class City
    attr_accessor :name, :population, :latitude, :longitude
    def initialize(name, population, latitude, longitude)
      @name, @population, @latitude, @longitude = name, population.to_i, latitude.to_f, longitude.to_f
    end
  end

  def self.make_geo_list(file = "geography.csv")
    countries = []
    File.open(file) {|f| f.each_line {|line| add_place(line.chomp.split(","), countries) } }
    countries
  end

  def self.add_place(fields, countries)
    case fields.length
    when 2
      countries << Country.new(*fields)
    when 4
      countries.last.cities << City.new(*fields)
    else
      raise "improper file format" # fail on bad format
    end
  end
end

puts Geography::make_geo_list.inspect
