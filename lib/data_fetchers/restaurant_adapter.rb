require "rest-client"
require "json"
require 'pry'

class RestaurantAdapter

    def fetch_restaurants
      response = RestClient.get("https://data.cityofnewyork.us/resource/xx67-kt59.json")
      JSON.parse(response)
    end
# https://data.cityofnewyork.us/resource/9w7m-hzhe.json This includes rating_dates after 1/1/2016

    def add_restaurants(data)
        data.each do | restaurant |
          if restaurant["grade_date"]
            Restaurant.find_or_create_restaurant(restaurant["dba"], restaurant["grade"], restaurant["violation_description"], restaurant["camis"], restaurant["grade_date"])
          end
        end
    end

      #  data[0]  =>
      # {
      #  "cuisine_description"=>"Bakery",
      #  "dba"=>"MORRIS PARK BAKE SHOP",
      #  "boro"=>"BRONX",
      #  "inspection_date"=>"2016-02-18T00:00:00",
      #  "zipcode"=>"10462",
      #  "score"=>"10",
      #  "phone"=>"7188924968",
      #  "street"=>"MORRIS PARK AVE",
      #  "grade"=>"A",
      #  "critical_flag"=>"Critical",
      #  "camis"=>"30075445",
      #  "action"=>"Violations were cited in the following area(s).",
      #  "violation_code"=>"04L",
      #  "violation_description"=>"Evidence of mice or live mice present in facility's food and/or non-food areas.",
      #  "grade_date"=>"2016-02-18T00:00:00",
      #  "inspection_type"=>"Cycle Inspection / Initial Inspection"
      # }


end
