

##This Ruby application allows multiple animal shelters to coordinate all availble placements for strays
#by sharing data between all area animal shelters and all registered foster homes
#Users are able to deterimine the best placement for each stray animal using
#current information about all available options

# This ruby code is designed to interact with users
#The CLI obtains information about stray animals, animal shelters and
#foster family status

class CommandLine

attr_accessor :species, :name
#create class variables
@@species="Stray_animal"
@@name="Something_different"

  def clear_term
    print "\e[2J\e[f"
  end


# Greet Users so they know they are in the correct application
  def greet
    clear_term
    puts Rainbow("Welcome, you are in the right place to get help with Stray Pet Placement.").white.background(0).bright
    stray?
  end
  # Clarify that user is looking for Stray pet placement or something else
  def stray?
    clear_term
    puts Rainbow("Do you have a stray pet that needs to be placed into care?").white.background(0).bright
    puts "\n\t1. Yes"
    puts "\t2. No"
    puts Rainbow("\n\t0. Exit").red
  # Mwthod changes all responses to lc, analyzes response and route user accordingly
  # Yes responses are sent to the Species method
  #No responses to the other_options method and x is sent to the Goodbye method
  #if neither Y, N or x is entered the program will ask again.

    #returns Y or N from user as lowercase

  answer = gets.chomp.downcase
  case answer
  when "1"
    animal_species?
  when "2"
    other_options
  when '0'
    puts "Goodbye"
  else
    stray?
  end
end

def other_options
  clear_term
  puts Rainbow("Are you a shelter or a family looking to foster?").white.background(0).bright
  puts "\n\t1. Shelter"
  puts "\t2. Foster\n"
  puts Rainbow("\n\t0. Exit").red
  answer = gets.chomp
  case answer
  when "2"
    select_foster_id
  when "1"
    shelter_select_id
  when "0"
    puts "Goodbye"
  else
    stray?
  end
end

  # ----------- Animal methods
  # When the user needs to place an animal, the first step is determine species.
  #Currently the code accomodates Dogs, Cats and Birds
  #the code could be enhanced to include other species by adding optons here

  def animal_species?
    clear_term
    array =["1", "2", "3"]
    puts Rainbow("What kind of animal is this?").white.background(0).bright
    puts "\n\t1. Cat"
    puts "\t2. Dog"
    puts "\t3. Bird"
    species_answer = gets.chomp
      if array.include?(species_answer)
        case species_answer
        when "1"
          animal_name?("cat")
        when "2"
          animal_name?("dog")
        when "3"
          animal_name?("bird")
        end
      else
        animal_species?
      end
  end

  # The method asks that the stray pet be named.  This provides additional
  #identification data and adds a human element.
  #the "thank you" message provides a chance to verify the data before it is added
    def animal_name?(species)
      clear_term
      puts Rainbow("Everyone needs a name!").white.background(0).bright
      puts Rainbow("Please give this stray animal a name.").white.background(0).bright
      name = gets.chomp
      puts Rainbow("Thank you for registering this #{species} named #{name}.").white.background(0).bright
      puts Rainbow("Is this accurate?").white.background(0).bright
      puts "\n\t1. Yes"
      puts "\t2. No"
      if gets.chomp == "1"
        animal_create(name, species)
      else
        stray?
      end
    end

# This method accepts the verified data and enters it into the Animals Table
#It puts out a response giving the named animal a unique id number.
#The name and the ID number provide a two step authentication for each entry
  def animal_create(name, species)
    clear_term
    a1 = Animal.create(name: name, species: species)
    puts Rainbow("#{a1.name} has been assigned a stray animal tracking id of #{a1.id}.").white.background(0).bright
    puts Rainbow("Please use the name #{a1.name} and id of #{a1.id} when inquiring about this stray.").white.background(0).bright
  end

  def animal_destroy(a_id)
    puts "#{Animal.find(a_id).name} has been removed from the system."
    Animal.destroy(a_id)
    #deletes an Animal instance
  end

  #---------- Foster methods
  #Foster care providers are an important of the shelter system.
  #First we identify if the Foster family is already registered in the system
  #after providing their name, they can locate their id

    def create_foster
      clear_term
      puts Rainbow("Please enter your name.").white.background(0).bright
      Foster.create(name: gets.chomp)
      puts Rainbow("Welcome #{Foster.last.name}.").white.background(0).bright
      select_foster_id
    end
  # the next step has the Foster family enter their ID if they are registered or
  # provides them the opportunity to register as a Foster care family
  def select_foster_id
    clear_term
    curr_fosters = Foster.all.map do |f|
      f.id
    end

    puts Rainbow("Please select your foster ID.").white.background(0).bright
    choices = Foster.all.map do |f|
      "\t#{f.id} - #{f.name}"
    end

    puts choices
    puts "\n\tN - New foster home"
    puts Rainbow("\n\t0. Exit").red

    response = gets.chomp
    if curr_fosters.include?(response.to_i)
      foster_options(response)
    elsif response == "0"
      puts "Goodbye."
    elsif response.downcase == "n"
      create_foster
    else
      puts "Please enter a valid ID."
      select_foster_id
    end
  end

# method to give choices for fosters
def foster_options(f_id)
  clear_term
  puts Rainbow("Hello #{Foster.find(f_id).name}.").white.background(0).bright
  puts Rainbow("How may we help you?").white.background(0).bright
  puts "\t1. Select an animal to foster."
  puts "\t2. Review your current pets."
  puts "\t3. Remove yourself from the database.\n"
  puts Rainbow("\n\t0. Exit").red
  choice = gets.chomp.downcase
  case choice
  when "1"
    foster_select_pet(f_id)
  when "2"
    foster_show_list_of_animals_by_shelter(f_id)
  when "3"
    foster_remove(f_id)
  when "0"
    puts "Goodbye"
  else
    foster_options(f_id)
  end
end
# allow a foster to remove itself from the database, sets foster_id of pets previously assigned to them to nil
def foster_remove(f_id)
  clear_term
  Foster.destroy(f_id)
  puts Rainbow("Thank you. You have been removed from our records.").white.background(0).bright
  Animal.where(foster_id: f_id).update(foster_id: nil)
end

  def foster_show_list_of_animals_by_shelter(f_id)
    clear_term
    puts Rainbow("Below is a list of all your current animals, and their associated shelters").white.background(0).bright

    Animal.where(foster_id: f_id).map { |a| puts "#{a.name} - #{a.shelter.name}" }

  end

  # this code allows the registered Foster families to
  #select an availble stray needing housing
  #this information is verified before proceding
    def foster_select_pet(foster_id)
      choices = Animal.all.map do |a|
        "\t#{a.id} - #{a.name}"
      end
      puts choices
      pet_id = gets.chomp
      puts Rainbow("Thank you #{Foster.find(foster_id).name} family.").white.background(0).bright
      puts Rainbow("It looks like you want to foster #{Animal.find(pet_id).name}.").white.background(0).bright
      puts Rainbow("Is this correct?").white.background(0).bright
      puts "\t1. Yes"
      puts "\t2. No\n"
      puts Rainbow("\n\t0. Exit").red
      response = gets.chomp
      case response
      when"1"
        assign_pet_to_home(foster_id, pet_id)
      when '2'
        select_foster_id
      when '0'
        puts "Goodbye"
      else
        select_pet
      end
    end
  #If the Foster Family verifies that they want that pet, the stray is assigned to them
  #If not,they are again asked about their foster family status or sent to the Goodbye method
    def assign_pet_to_home(f_id, p_id)
      clear_term
      Animal.find(p_id).update(foster_id: f_id)
      puts Rainbow("#{Animal.find(p_id).name} now lives with the #{Foster.find(f_id).name}.").white.background(0).bright
    end

  #--------- Shelter methods
  #this app allows multiple shelters to coordinate avaialble placements for strays
  #by sharing data between all area animal shelters and all registered foster homes
  #Users are able to deterimine the best placement from all available other_options

  #Users are asked to identify which shelter they are affiliated with by name
  #and they are welcomed to the application space

    def shelter_create
      clear_term
      #Shelter Users are asked to selected their ID if already registered
      puts Rainbow("Please enter the name of your shelter below:").white.background(0).bright
      Shelter.create(name: gets.chomp)
      puts Rainbow("Welcome #{Shelter.last.name}.").white.background(0).bright
      shelter_select_id
    end

    def shelter_select_id
      #If shelter is not already in the system, they can register here
      #and are assigned a shelter # ID
      #If they do not want to register - they are given option
      #to select an avaialble stray for placement at their shelter
      #or to view a list of the Foster homes currently fostering an animal for them
      curr_shelters = Shelter.all.map do |s| s.id
      end

      puts Rainbow("Please select your shelter ID from the list below by entering your shelter's ID.").white.background(0).bright
      puts Rainbow("If you do not see your shelter listed and would like to be entered into our systems, enter 'N' for New.").white.background(0).bright

      choices = Shelter.all.map do |s|
        "\t#{s.id} - #{s.name}"
      end

      puts "\n"
      puts choices
      puts "\tN - New shelter\n\n"
      puts Rainbow("\n\t0. Exit").red

      answer = gets.chomp
      if curr_shelters.include?(answer.to_i)
        shelter_options(answer)
      elsif answer == "0"
        puts "Goodbye"
      elsif answer.downcase == "n"
        shelter_create
      else
        puts "Pleae enter a valid ID."
        shelter_select_id
      end
    end

    def shelter_options(s_id)
      clear_term
      puts Rainbow("Hello #{Shelter.find(s_id).name}.").white.background(0).bright
      puts Rainbow("How may we help you?").white.background(0).bright
      puts Rainbow("You may select an animal for your shelter or view a list of foster homes currently fostering your shelter's animals.").white.background(0).bright
      puts Rainbow("Please select from the options below:").white.background(0).bright
      puts "\n\t1. Select an animal for your shelter"
      puts "\t2. View a list of homes fostering your shelter's animals"
      puts Rainbow("\n\t0. Exit").red
      choice = gets.chomp

      if choice == "1"
        select_pet(s_id)
      elsif choice == "2"
        shelters_show_list_of_foster_homes(s_id)
      elsif choice == "0"
        puts "Goodbye"
      else
        shelter_options(s_id)
      end
    end
# If this option is selected, A list of all the shelter's animals
#currently in Foster care is provided, sorted by foster family

  def shelters_show_list_of_foster_homes(s_id)
    clear_term
    #show all Animals at a Shelter, where some animals are with a Foster
    if Shelter.find(s_id).animals == []
      puts Rainbow("Your shelter is empty.").white.background(0).bright
      puts Rainbow("Would you like to return to the shelter menu?").white.background(0).bright

      puts "\n\t1. Return to the shelter menu"
      puts Rainbow("\n\t0. Exit").red
      choice = gets.chomp
          if choice == "1"
            shelter_options(s_id)
          elsif choice == "0"
            puts "Goodbye"
          else shelters_show_list_of_foster_homes(s_id)
          end
    else
      avail_anim = []
      unassaigned_an = []
      puts Rainbow("The following animals are associated with your shelter with the name of the foster home if applicable.").white.background(0).bright
      puts Rainbow("Please select an animal to reassign the foster home, remove the foster home, or remove the animal from this system.").white.background(0).bright
      Animal.where(shelter_id: s_id).select do |a|
        if a.foster == nil
          puts "\t#{a.id} - #{a.name} - available to foster"
          unassaigned_an << a.id
        else
          puts "\t#{a.id} - #{a.name} - #{a.foster.name}"
          avail_anim << a.id
        end
      end
      puts Rainbow("\n\t0. Exit").red
      choice = gets.chomp
      if choice == "0"
        puts "Goodbye"
      elsif avail_anim.include?(choice.to_i)
        shelter_reassign_or_remove(s_id, choice)
      elsif unassaigned_an.include?(choice.to_i)
        shelter_initial_assign_to_foster(s_id, choice)
      else
        shelters_show_list_of_foster_homes(s_id)
      end
    end
  end

  def shelter_initial_assign_to_foster(s_id, a_id)
    clear_term
    curr_foster = Foster.all.map {|f| f.id}

    puts "#{Animal.find(a_id).name} does not have a foster."
    puts "Please select from the fosters below."
    choices = Foster.all.map { |f| "\t#{f.id} - #{f.name}" }
    puts ""
    puts choices
    puts "\n\t0 - Exit"

    response = gets.chomp
    if response == "0"
      puts "Goodbye"
    elsif curr_foster.include?(response.to_i)
      Animal.find(a_id).update(foster_id: response.to_i)
      puts "#{Animal.find(a_id).name} now lives with the #{Animal.find(a_id).foster.name}."
    else
      shelter_initial_assign_to_foster(s_id, a_id)
    end
  end

  def shelter_reassign_or_remove(s_id, a_id)
    clear_term
    puts Rainbow("Please select from the following options for #{Animal.find(a_id).name}.").white.background(0).bright
    puts "\n\t1. Reassign to a foster home or remove from a foster home."
    puts "\t2. Remove the animal from this system"
    puts Rainbow("\n\t0. Exit").red
    choice = gets.chomp
    case choice
    when "1"
      shelter_reassign_to_foster(s_id, a_id)
    when "2"
      animal_destroy(a_id)
    when "0"
      puts "Goodbye"
    else
      shelter_reassign_or_remove(s_id, a_id)
    end
  end

  def shelter_reassign_to_foster(s_id, a_id)
    clear_term
    puts "#{Animal.find(a_id).name} is currently with the #{Animal.find(a_id).foster.name}."
    puts "Which foster family would you like to resassign this animal to?"
    puts "If none, select R to remove from foster home.\n"

    avail_fosters = []

    Foster.all.select do |f|
      f.id != Animal.find(a_id).foster_id
    end.each do |f|
      avail_fosters << f.id
      puts "\t#{f.id} - #{f.name}"
    end
    puts "\tR - Remove"
    puts "\n\t0 - Exit"
    response = gets.chomp
    if response == "0"
      puts "Goodbye."
    elsif response.downcase == "r"
      puts "#{Animal.find(a_id).name} is no longer assigned to #{Animal.find(a_id).foster.name}."
      Animal.find(a_id).update(foster_id: nil)
    elsif avail_fosters.include?(response.to_i)
      Animal.find(a_id).update(foster_id: response)
      puts "#{Animal.find(a_id).name} has been reassigned to #{Animal.find(a_id).foster.name}."
    else
      shelter_reassign_to_foster(s_id, a_id)
    end
  end

  def shelter_remove_foster_from_animal(s_id, a_id)
    clear_term

  end
# this method iterates through all avaialble stray animals and sorts them by Shelter ID
# This method verifies the Shelter
# Method asks if they are willing to shelter a named stray animal,
#the animal is identified by Animal ID and Name to verify
# if the information is not verified, the User is
#asked again to verify their shelter status or sent to the goodby method

    def select_pet(s_id)
      clear_term
      current_animals = Animal.all.map do |a|
        a.id
      end
      puts Rainbow("Please enter the number of the animal you wish to associate with your facility.").white.background(0).bright
      puts Rainbow("You may select from the animals below:").white.background(0).bright
      puts ""
      choices = Animal.all.map do |a|
        "\t#{a.id} - #{a.name}"
      end
      puts ""
      puts choices
      puts Rainbow("\n\t0. Exit").red

      pet_id = gets.chomp
      if pet_id == "0"
        puts "Goodbye"
      elsif current_animals.include?(pet_id.to_i)
        puts Rainbow("\n#{Shelter.find(s_id).name} is a warm welcoming place, even to animals like #{Animal.find(pet_id).name} Are you sure you would like to add #{Animal.find(pet_id).name} to your animals?").white.background(0).bright
        puts "\n\t1. Yes"
        puts "\t2. No"
          if gets.chomp == "1"
            assign_pet_to_shelter(s_id, pet_id)
          elsif gets.chomp == "2"
            shelter_select_id
          else select_pet(s_id)
          end
        else
          select_pet(s_id)
      end
    end
# If the shelter agress to accept the particular animal - the placement is made
# And a unique shelter ID is assigned to this placement
    def assign_pet_to_shelter(s_id, p_id)
      clear_term
      Animal.find(p_id).update(shelter_id: s_id)
      puts ""
      puts Rainbow("Thank you.").white.background(0).bright
      puts Rainbow("#{Animal.find(p_id).name} is now under #{Shelter.find(s_id).name}'s watchful eyes.").white.background(0).bright
    end
    ######______________######______check with John and Aubree about process???????
#If the shelter is not able to accept the stray, they can ask for a
#alist of foster families currently associated with their shelter


    # def show_fosters_to_shelters
    #
    # end


end # end of class
