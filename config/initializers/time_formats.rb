Time::DATE_FORMATS[:mdy] = lambda { |time| time.strftime("%B #{time.day.ordinalize} %Y") }
Time::DATE_FORMATS[:mdyz] = lambda { |time| time.strftime("%B #{time.day.ordinalize} %Y %Z") }
Time::DATE_FORMATS[:timem] = '%I:%M%p'