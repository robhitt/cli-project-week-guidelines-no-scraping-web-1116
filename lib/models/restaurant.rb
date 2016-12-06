class Restaurant
  attr_reader :name, :grade, :violation_description, :camis
  ALL = []

  def self.all
    ALL
  end

  def initialize(name, grade, violation_description, camis)
      @name = name
      @grade = grade
      @violation_description = violation_description
      @camis = camis
      ALL << self
# restaurant["dba"], restaurant["grade"], restaurant["violation_description"]
  end

end
