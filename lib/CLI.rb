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


# Greet Users so they know they are in the correct application
  def greet
    puts "Welcome, you are in the right place to get help with Stray Pet Placement."
    stray?
  end
  # Clarify that user is looking for Stray pet placement or something else
  def stray?
    puts "Do you have a stray pet that needs to be placed into care?"
    puts "\t1. Yes"
    puts "\t2. No\n\n"
    puts "\t0. Exit"
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
  puts "Are you a shelter or a family looking to foster?\n"
  puts "\t1. Shelter"
  puts "\t2. Foster\n\n"
  puts "\t0. Exit"
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
    array =["1", "2", "3"]
    puts "What kind of animal is this?"
    puts "\t1. Cat"
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
      puts "Everyone needs a name!\nPlease give this stray animal a name."
      name = gets.chomp
      puts "Thank you for registering the #{species}, #{name}.\nIs this accurate?"
      puts "\t1. Yes"
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
    a1 = Animal.create(name: name, species: species)
    puts "#{a1.name} has been assigned a stray animal tracking id of #{a1.id}."
    puts "Please use the name #{a1.name} and id of #{a1.id} when inquiring about this stray. "
  end
  #---------- Foster methods
  #Foster care providers are an important of the shelter system.
  #First we identify if the Foster family is already registered in the system
  #after providing their name, they can locate their id

    def create_foster
      puts "Please enter your name."
      Foster.create(name: gets.chomp)
      puts "Welcome #{Foster.last.name}."
      select_foster_id
    end
  # the next step has the Foster family enter their ID if they are registered or
  # provides them the opportunity to register as a Foster care family
  def select_foster_id
    curr_fosters = Foster.all.map do |f|
      f.id
    end

    puts "Please select your foster ID."
    choices = Foster.all.map do |f|
      "\t#{f.id} - #{f.name}"
    end

    puts choices
    puts "\n\tN - New foster home"
    puts "\t0 - Exit"

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
    puts "Hello #{Foster.find(f_id).name}.\nHow may we help you?"
    puts "\t1. Select an animal to foster."
    puts "\t2. New method listing current pets?\n\n"
    puts "\t0. Exit"
    choice = gets.chomp.downcase
    case choice
    when "1"
      foster_select_pet(f_id)
    when "2"
      puts "Another method to show shelters and current pets?"
    when "0"
      puts "Goodbye"
    else
      foster_options(f_id)
    end
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
      puts "Thank you #{Foster.find(foster_id).name} family. \nYou want to foster #{Animal.find(pet_id).name}. \nIs this correct?"
      puts "\t1. Yes"
      puts "\t2. No\n\n"
      puts "\t0. Exit"
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
      Animal.find(p_id).update(foster_id: f_id)
      puts "#{Animal.find(p_id).name} now lives with the #{Foster.find(f_id).name}."
    end

  #--------- Shelter methods
  #this app allows multiple shelters to coordinate avaialble placements for strays
  #by sharing data between all area animal shelters and all registered foster homes
  #Users are able to deterimine the best placement from all available other_options

  #Users are asked to identify which shelter they are affiliated with by name
  #and they are welcomed to the application space

    def shelter_create
      #Shelter Users are asked to selected their ID if already registered
      puts "Please enter the name of your shelter below:"
      Shelter.create(name: gets.chomp)
      puts "Welcome #{Shelter.last.name}."
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

      puts "Please select your shelter ID from the list below by entering your shelter's ID. \n If you do not see your shelter listed and would like to be entered into our systems, enter 'N' for New."

      choices = Shelter.all.map do |s|
        "\t#{s.id} - #{s.name}"
      end

      puts "\n"
      puts choices
      puts "\tN - New shelter\n\n"
      puts "\t0. Exit"

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
      puts "Hello #{Shelter.find(s_id).name}. \nHow may we help you? \nYou may select an animal for your shelter or view a list of foster homes currently fostering your shelter's animals. \nPlease select from the options below:"
      puts "\n\t1. Select an animal for your shelter"
      puts "\t2. View a list of homes fostering your shelter's animals"
      puts "\n\t0. Exit"
      choice = gets.chomp

      if choice == "1"
        select_pet(s_id)
      elsif choice == "2"
        shelters_show_list_of_foster_homes_by_shelter(s_id)
      elsif choice == "0"
        puts "Goodbye"
      else
        shelter_options(s_id)
      end
    end
# If this option is selected, A list of all the shelter's animals
#currently in Foster care is provided, sorted by foster family
  def shelters_show_list_of_foster_homes_by_shelter(s_id)
    puts "The following animals associated with your shelter are being fostered by the indicated families:\n"

    Animal.where(shelter_id: s_id).map {|p| puts "\t#{p.name} - #{p.foster.name}"}

    puts "Would you like to continue using our system or have you completed your tasks?\nPlease select from the options below:"
    puts "\n\t 1. Return to the shelter menu"
    puts "\n\t 0. Exit"
    choice = gets.chomp

    if choice == "1"
      shelter_options(s_id)
    elsif choice == "0"
      puts "Goodbye"
    else shelters_show_list_of_foster_homes_by_shelter(s_id)
    end
  end

# this method iterates through all avaialble stray animals and sorts them by Shelter ID
# This method verifies the Shelter
# Method asks if they are willing to shelter a named stray animal,
#the animal is identified by Animal ID and Name to verify
# if the information is not verified, the User is
#asked again to verify their shelter status or sent to the goodby method

    def select_pet(s_id)
      current_animals = Animal.all.map do |a|
        a.id
      end
      puts "Please enter the number of the animal you wish to associate with your facility. You may select from the animals below:\n"
      choices = Animal.all.map do |a|
        "\t#{a.id} - #{a.name}"
      end
      puts ""
      puts choices
      puts "\n\t 0. Exit"

      pet_id = gets.chomp
      if pet_id == "0"
        puts "Goodbye"
      elsif current_animals.include?(pet_id.to_i)
        puts "\n#{Shelter.find(s_id).name} is a warm welcoming place, even to animals like #{Animal.find(pet_id).name}. Are you sure you would like to add #{Animal.find(pet_id).name} to your animals?\n"
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
      Animal.find(p_id).update(shelter_id: s_id)
      puts "\nThank you. \n#{Animal.find(p_id).name} is now under #{Shelter.find(s_id).name}'s watchful eyes."
    end
    ######______________######______check with John and Aubree about process???????
#If the shelter is not able to accept the stray, they can ask for a
#alist of foster families currently associated with their shelter
    def show_fosters_to_shelters

    end
end # end of class
