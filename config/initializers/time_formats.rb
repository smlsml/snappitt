Time::DATE_FORMATS[:mdy] = lambda { |time| time.strftime("%B #{time.day.ordinalize} %Y") }
Time::DATE_FORMATS[:timem] = '%I:%M%p'