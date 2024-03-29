require 'yaml'

module FutureLearn
  class Country
    attr_reader :code, :name, :postal_region, :alpha3

    def self.all
      return @all if @all
      countries_by_region = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'config', 'countries.yml'))
      @all = countries_by_region.each_with_object([]) do |(region, country_list), list|
        country_list.each_pair do |code, (name, alpha3)|
          list << Country.new(code, name, region, alpha3)
        end
      end
    end

    def self.find_by_code(code)
      all.detect { |country| country.code == code }
    end

    def self.find_by_name(name)
      all.detect { |country| country.name == name }
    end

    def initialize(code, name, postal_region, alpha3)
      @code = code
      @name = name
      @postal_region = postal_region
      @alpha3 = alpha3
    end

    def ==(other)
      code == other.code
    end
    alias_method :eql?, :==

    def <=>(other)
      name <=> other.name
    end

    def hash
      code.hash
    end
  end
end
