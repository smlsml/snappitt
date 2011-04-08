class RedoZodiac < ActiveRecord::Migration

  def self.up
    execute "TRUNCATE zodiacs"

    execute <<-SQL
    INSERT INTO zodiacs (name, phrase, type, lookup) VALUES
    ('Aries','The Ram', 'Zodiac::Western', null),
    ('Taurus','The Bull', 'Zodiac::Western', null),
    ('Gemini','The Twins', 'Zodiac::Western',  null),
    ('Cancer','The Crab', 'Zodiac::Western', null),
    ('Leo','The Lion', 'Zodiac::Western', null),
    ('Virgo','The Virgin', 'Zodiac::Western', null),
    ('Libra','The Scales', 'Zodiac::Western', null),
    ('Scorpio','The Scorpion', 'Zodiac::Western', null),
    ('Sagittarius','The Archer/Centaur', 'Zodiac::Western', null),
    ('Capricorn','The Sea-goat', 'Zodiac::Western', null),
    ('Aquarius','The Water Carrier', 'Zodiac::Western', null),
    ('Pisces','The Two Fish', 'Zodiac::Western', null),
    ('Rooster', 'I know better', 'Zodiac::Chinese', 1),
    ('Dog', 'I worry', 'Zodiac::Chinese', 2),
    ('Pig', 'I preserve','Zodiac::Chinese', 3),
    ('Rat', 'I Rule','Zodiac::Chinese', 4),
    ('Ox', 'I Persevere','Zodiac::Chinese', 5),
    ('Tiger', 'I Win','Zodiac::Chinese', 6),
    ('Rabbit', 'I retreat','Zodiac::Chinese', 7),
    ('Dragon', 'I reign','Zodiac::Chinese', 8),
    ('Snake', 'I feel','Zodiac::Chinese', 9),
    ('Horse', 'I control','Zodiac::Chinese', 10),
    ('Goat', 'I depend','Zodiac::Chinese', 11),
    ('Monkey', 'I Entertain','Zodiac::Chinese', 0)
    SQL
  end

  def self.down
    execute "TRUNCATE zodiacs"
  end

end
