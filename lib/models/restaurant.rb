class Restaurant
  attr_reader :name, :camis
  attr_accessor :violations, :grade_date, :grade, :violation_description
  ALL = []

  def self.all
    ALL
  end

  def initialize(name, grade, violation_description, camis, grade_date)
      @name = name
      @grade = grade
      @violation_description = violation_description
      @camis = camis
      @grade_date = grade_date
      @violations = []
      ALL << self
      # restaurant["dba"], restaurant["grade"], restaurant["violation_description"]
  end


  def self.find_or_create_restaurant(name, grade, violation_description, camis, grade_date)
    duplicate_restaurant = self.find_restaurant(camis)

    if duplicate_restaurant == nil #DIDN'T FIND IT!
      new_restaurant = self.new(name, grade, violation_description, camis, grade_date)
    else  #FOUND IT!
      #go to the methods that check whether date is most recent, update values, etc
      #instantiate a Restaurant with the given values
      duplicate_restaurant.violation_description = violation_description
      #duplicate_restaurant.grade_date = grade_date
      self.date_checker(duplicate_restaurant)
    end
  # first, call on a finder method to locate any existing objects that match camis
  # second, if not found, use new method to create the Restaurant
  # if camis found, call on another method to determine if most recent date
  #   if hash's date matches the object date, push the violation to the self.violations
  #   if hash's date is more recent than existing, overwrite date and grade and self.violations.clear, then push violation
  #   else nothing
  end

  def self.date_checker(duplicate_restaurant)
    self.all.each do |restaurant|

      if restaurant.camis == duplicate_restaurant.camis
        if duplicate_restaurant.grade_date > restaurant.grade_date
          restaurant.grade_date = duplicate_restaurant.grade_date
          restaurant.grade = duplicate_restaurant.grade
          restaurant.violations.clear
          restaurant.violations << duplicate_restaurant.violation_description
        elsif duplicate_restaurant.grade_date == restaurant.grade_date
          restaurant.violations << duplicate_restaurant.violation_description

        end
      end
      # binding.pry
    end
  end

  def self.find_restaurant(camis)
    self.all.each do |restaurant|
      if restaurant.camis == camis
        return restaurant
      end
    end
    nil
  end
end
######## THOUGHT PROCESS #########
#
# one helper -- looks for Camis in ALL and returns objects
# one helper -- once uniquity is confirmed, looks for the violation in the restaurant instance
