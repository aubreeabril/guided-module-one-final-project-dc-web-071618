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
  puts "Do you have a stray pet that needs to be housed? Y or N"

  answer = gets.chomp.downcase
  #returns Y or N

  if answer == "y"
    species?
  elsif answer == "n"
    puts "Thanks. Call 911 for Emergencies"
  else
    stray?
  end
end

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
    puts "Thank you for registering a #{species}, #{animal_name} says woof, meow or chirp "
  
  end


end # end of class
