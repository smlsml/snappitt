# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Zodiac::Western.create(:name => 'Aries',       :phrase => 'The Ram')
Zodiac::Western.create(:name => 'Taurus',      :phrase => 'The Bull')
Zodiac::Western.create(:name => 'Gemini',      :phrase => 'The Twins')
Zodiac::Western.create(:name => 'Cancer',      :phrase => 'The Crab')
Zodiac::Western.create(:name => 'Leo',         :phrase => 'The Lion')
Zodiac::Western.create(:name => 'Virgo',       :phrase => 'The Virgin')
Zodiac::Western.create(:name => 'Libra',       :phrase => 'The Scales')
Zodiac::Western.create(:name => 'Scorpio',     :phrase => 'The Scorpion')
Zodiac::Western.create(:name => 'Sagittarius', :phrase => 'The Archer')
Zodiac::Western.create(:name => 'Capricorn',   :phrase => 'The Sea-goat')
Zodiac::Western.create(:name => 'Aquarius',    :phrase => 'The Water Carrier')
Zodiac::Western.create(:name => 'Pisces',      :phrase => 'The Two Fish')

Zodiac::Chinese.create(:name => 'Rooster', :phrase => '', :lookup => 1)
Zodiac::Chinese.create(:name => 'Dog',     :phrase => '', :lookup => 2)
Zodiac::Chinese.create(:name => 'Pig',     :phrase => '', :lookup => 3)
Zodiac::Chinese.create(:name => 'Rat',     :phrase => '', :lookup => 4)
Zodiac::Chinese.create(:name => 'Ox',      :phrase => '', :lookup => 5)
Zodiac::Chinese.create(:name => 'Tiger',   :phrase => '', :lookup => 6)
Zodiac::Chinese.create(:name => 'Rabbit',  :phrase => '', :lookup => 7)
Zodiac::Chinese.create(:name => 'Dragon',  :phrase => '', :lookup => 8)
Zodiac::Chinese.create(:name => 'Snake',   :phrase => '', :lookup => 9)
Zodiac::Chinese.create(:name => 'Horse',   :phrase => '', :lookup => 10)
Zodiac::Chinese.create(:name => 'Goat',    :phrase => '', :lookup => 11)
Zodiac::Chinese.create(:name => 'Monkey',  :phrase => '', :lookup => 0)