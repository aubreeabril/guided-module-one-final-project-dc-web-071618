
# -------shelters

s1 = Shelter.create(name: "Pets for the Taking", capacity: 4)
s2 = Shelter.create(name: "ASPCA", capacity: 5)
s3 = Shelter.create(name: "Animal Control", capacity: 5)

# -------animals

a1 = Animal.create(name: "Fluffy", species: "cat")
a2 = Animal.create(name: "Rover", species: "dog")
a3 = Animal.create(name: "Rex", species: "dog")
a4 = Animal.create(name: "Polly", species: "bird")
a5 = Animal.create(name: "Muffins", species: "cat")
a6 = Animal.create(name: "Killer", species: "bird")
a7 = Animal.create(name: "Fluffy", species: "bird")

# -------fosters

f1 = Foster.create(name: "Smiths", capacity: 2)
f2 = Foster.create(name: "Jones", capacity: 2)
f3 = Foster.create(name: "Greens", capacity: 2)
