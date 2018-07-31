# add CLI
class CommandLine

attr_accessor :species, :name

@@species="Stray_animal"
@@name="Something_different"

def greet
  puts "Welcome to the Stray Pet Placement application"
  stray?
end

def stray?
  puts "Do you have a stray pet that needs to be housed? Y or N or X?"

  answer = gets.chomp.downcase
  #returns Y or N
  if answer == "y"
    species?
  elsif answer == "n"
    other_options
  elsif answer == 'x'
    puts "Goodbye"
  else
    stray?
  end
end

def other_options
  puts "Are you looking to foster(F) or are you a shelter(S)?" ## exit method someday
  answer = gets.chomp.downcase
  if answer == "f"
    select_foster_id
  elsif answer == "s"
    select_shelter_id
  elsif answer == 'x'
    puts "Goodbye"
  else
    stray?
  end
end

# ----------- Animal methods

def species?
  array =["cat", "dog", "bird"]
  puts "What kind of animal is this? Cat, Dog or Bird??"
  species_answer = gets.chomp.downcase
    if array.include?(species_answer)
      name?(species_answer)
    else
      species?
    end

  end

  def name?(species)
    puts "Please give this stray animal a name."
    animal_name = gets.chomp
    puts "Thank you for registering a #{species}, #{animal_name}. Is this accurate? Y or N?"
    if gets.chomp.downcase == "y"
      create(animal_name, species)
    else
      stray?
    end
  end

  def create(name, species)
    a1 = Animal.create(name: name, species: species)
    puts "#{a1.name} has been assigned #{a1.id}."
  end

#---------- Foster methods
  def create_foster
    puts "Please enter your name."
    Foster.create(name: gets.chomp)
    puts "Welcome #{Foster.last.name}."
    select_foster_id
  end

  def select_foster_id
    puts "Please select your foster ID or select N if you are a new foster home."
    choices = Foster.all.map do |f|
      "#{f.id} - #{f.name}"
    end
    puts choices
    response = gets.chomp
      if response.downcase == "n"
        create_foster
      else
      foster_select_pet(response)
    end
  end

  def foster_select_pet(foster_id)
    choices = Animal.all.map do |a|
      "#{a.id} - #{a.name}"
    end
    puts choices
    pet_id = gets.chomp
    puts "We think you're the #{Foster.find(foster_id).name} and you want to foster #{Animal.find(pet_id).name}. Is this correct? Y or N?"
    if gets.chomp.downcase == "y"
      assign_pet_to_home(foster_id, pet_id)
    elsif gets.chomp.downcase == 'n'
      select_foster_id
    elsif gets.chomp.downcase == 'x'
      puts "Goodbye"
    else
      select_pet
    end
  end

  def assign_pet_to_home(f_id, p_id)
    Animal.find(p_id).update(foster_id: f_id)
    puts "#{Animal.find(p_id).name} now lives with the #{Foster.find(f_id).name}."
  end

#--------- Shelter methods
  def create_shelter
    puts "What is the name of your shelter?"
    Shelter.create(name: gets.chomp)
    puts "Welcome #{Shelter.last.name}."
    select_shelter_id
  end

  def select_shelter_id
    puts "Please select your shelter ID. If you are new to our system select N."
    choices = Shelter.all.map do |s|
      "#{s.id} - #{s.name}"
    end
    puts choices
    response = gets.chomp

    if response.downcase == "n"
      create_shelter
    else
      shelter_options(response)
    end
  end

  def shelter_options(s_id)
    puts "Hello #{Shelter.find(s_id).name}. How may we help you?  You may select an animal for your shelter(S) or view a list of foster homes currently fostering your animals(F))"
    choice = gets.chomp.downcase
    #TO DO: repalce if/elsif with case statements
    if choice == "s"
      select_pet(s_id)
    elsif choice == "f"
      show_list_of_foster_homes_by_shelter(s_id)
    elsif choice == "x"
      puts "Goodbye"
    else shelter_options(s_id)
    end
  end

  def show_list_of_foster_homes_by_shelter(s_id)
    puts "The following animals associated with your shelter are being fostered by the indicated families:"
    Animal.where(shelter_id: s_id).map {|p| puts "#{p.name} - #{p.foster.name}"}
  end

  def select_pet(s_id)
    choices = Animal.all.map do |a|
      "#{a.id} - #{a.name}"
    end
    puts choices
    pet_id = gets.chomp
    puts "We think you're at #{Shelter.find(s_id).name} and you want to institutionalize #{Animal.find(pet_id).name}. Is this correct? Y or N?"
    if gets.chomp.downcase == "y"
      assign_pet_to_shelter(s_id, pet_id)
    elsif gets.chomp.downcase == 'n'
      select_shelter_id
    elsif gets.chomp.downcase == 'x'
      puts "Goodbye"
    else
      select_pet
    end
  end

  def assign_pet_to_shelter(s_id, p_id)
    Animal.find(p_id).update(shelter_id: s_id)
    puts "#{Animal.find(p_id).name} is at #{Shelter.find(s_id).name}."
  end

  def show_fosters_to_shelters

  end
end # end of class
