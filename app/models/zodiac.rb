class Zodiac < ActiveRecord::Base

  class Western < Zodiac
    def to_s
      'Zodiac sign: %s "%s"' % [name, phrase]
    end
  end

  class Chinese < Zodiac
    def to_s
      'Chinese zodiac sign: %s "%s"' % [name, phrase]
    end

    def self.from_year(year)
      find_by_lookup(year % 12)
    end
  end

  def to_s
    name
  end

end


