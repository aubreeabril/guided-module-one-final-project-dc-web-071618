
# -------shelters

s1 = Shelter.create(name: "Pets for the Taking", capacity: 4)
s2 = Shelter.create(name: "ASPCA", capacity: 5)
s3 = Shelter.create(name: "Animal Control", capacity: 11)
s4 = Shelter.create(name: "A New Hope for Wookies", capacity: 2)
s5 = Shelter.create(name: "Animal Farm", capacity: 15)
s6 = Shelter.create(name: "Washington Animal Rescue League", capacity: 10)


# -------animals

a1 = Animal.create(name: "Fluffy", species: "cat", shelter_id: "1")
a2 = Animal.create(name: "Rover", species: "dog", shelter_id: "1")
a3 = Animal.create(name: "Rex", species: "dog", shelter_id: "1")
a4 = Animal.create(name: "Polly", species: "bird", shelter_id: "2")
a5 = Animal.create(name: "Muffins", species: "cat", shelter_id: "2")
a6 = Animal.create(name: "Killer", species: "bird", shelter_id: "3")
a7 = Animal.create(name: "Gollum", species: "dog", shelter_id: "3")
a8 = Animal.create(name: "Dobby", species: "bird", shelter_id: "3")
a9 = Animal.create(name: "Frodo", species: "dog", shelter_id: "4")
a10 = Animal.create(name: "Pumba", species: "cat", shelter_id: "4")
a11 = Animal.create(name: "Dunkin Butterbeans", species: "bird", shelter_id: "4")
a12 = Animal.create(name: "Empress Tzu Tzu", species: "cat", shelter_id: "4")
a13 = Animal.create(name: "Farrah Pawcett", species: "bird", shelter_id: "4")
a14 = Animal.create(name: "Monsieur Le Colonel Moustache", species: "dog", shelter_id: "5")

# -------fosters

f1 = Foster.create(name: "Tereshkovas", capacity: 2)
f2 = Foster.create(name: "Bartons", capacity: 4)
f3 = Foster.create(name: "Curies", capacity: 2)
f7 = Foster.create(name: "Lovelaces", capacity: 1)
f4 = Foster.create(name: "Washingtons", capacity: 0)
f5 = Foster.create(name: "Jeffersons", capacity: 20)
f6 = Foster.create(name: "Franklins", capacity: 3)
f7 = Foster.create(name: "Humdingers", capacity: 5)
