class RatingCLI
  # Greet User // Enter Restuarant
  def call
    greet_user
    help_text
    program_menu
  end

  def program_menu

    input = prompt_for_search_term

    case input.downcase
      when "exit"
        puts "Goodbye!"
      when "help"
        help_text
        program_menu #later fill this in with helpful puts
      when "quick"
        # this works but can't access out of help
        input = prompt_for_quick_result
        if input.downcase == "help"
          help_text
          program_menu #later fill this in with helpful puts
        elsif input.downcase == "exit"
          puts "Goodbye!"
          exit
        else
            quick_list(input)
            program_menu
        end

      when "full"
        input = prompt_for_full_result
        if input.downcase == "help"
          help_text
          program_menu #later fill this in with helpful puts
        elsif input.downcase == "exit"
          puts "Goodbye!"
          exit
        else
            full_list(input)
            program_menu
        end
      end
  end

  def greet_user
    puts ""
    puts "**********"
    puts "Welcome to the restaurant ratings CLI. Here you can search your favorite restaurants to see their grade!"
    puts "**********"
  end

  def prompt_for_search_term
    # Bonus: Additional search catagories borough, most recent grade date
    # Prompt Search Term
    print "Enter a command: (QUICK, FULL, HELP or EXIT) "
    gets.strip
  end

  def prompt_for_quick_result
    # Bonus: Additional search catagories borough, most recent grade date
    # Prompt Search Term
    print "(QUICKMODE) Enter Restaurant or command: "
    gets.strip
  end

  def prompt_for_full_result
    # Bonus: Additional search catagories borough, most recent grade date
    # Prompt Search Term
    print "(FULLMODE) Enter Restaurant Name or command: "
    gets.strip
  end

  def help_text
    puts ""
    puts "==============================="
    puts "Here's how to use the program: "
    puts "  Type 'EXIT' exits program"
    puts "  Type 'HELP' show you commands you can enter"
    puts "  Type 'QUICK' shows quick restuarant name and grade"
    puts "  Type 'FULL' shows full restaurant info"
    puts "==============================="
    puts ""
    puts ""
  end

  def fetch_restaurants
    adapter = RestaurantAdapter.new
    ratings_data = adapter.fetch_restaurants #pull restaurant info from API
    adapter.add_restaurants(ratings_data) #instantiate restaurant objects from hash
  end

  def full_list(user_input)
    fetch_restaurants
    matches = false
    Restaurant.all.each do |restaurant|
      if restaurant.name == user_input.upcase
      puts " "
        puts "Name: #{restaurant.name}"
        puts "Grade: #{restaurant.grade}"
        puts "Grade Date: #{restaurant.grade_date}"
        puts "Violation Description(s):"

        restaurant.violations.uniq.each.with_index(1) do | indv_violation, index |
          #binding.pry
          puts "   #{index}. #{indv_violation}"
        end
        puts " "
        matches = true
      end
    end
    puts "Sorry! No matches found for '#{user_input}'." if matches == false
  end

  def quick_list(user_input)
    fetch_restaurants
    matches = false
    Restaurant.all.each do |restaurant|
      if restaurant.name == user_input.upcase
        puts " "
        puts "========================================"
        puts "Name: #{restaurant.name}, Grade: #{restaurant.grade}, Violations: #{restaurant.violations.count}"
        puts "========================================"
        puts " "
        matches = true
      end
    end
    puts "Sorry! No matches found for '#{user_input}'." if matches == false
  end
#KEYWORDS
# add help keyword to prompt.
# if help
# elsif exit
# else search term
# The CLI should also respond to at least two more keywords of your choosing (these will probably vary depending on the purpose of your app, some might be "start", "search", etc.).

end
