
# -------shelters

s1 = Shelter.create(name: "Pets for the Taking")
s2 = Shelter.create(name: "ASPCA")
s3 = Shelter.create(name: "Animal Control")

# -------animals

a1 = Animal.create(name: "Fluffy", species: "cat")
a2 = Animal.create(name: "Rover", species: "dog")
a3 = Animal.create(name: "Rex", species: "dog")
a4 = Animal.create(name: "Polly", species: "bird")
a5 = Animal.create(name: "Muffins", species: "cat")
a6 = Animal.create(name: "Killer", species: "bird")
a7 = Animal.create(name: "Fluffy", species: "bird")

# -------fosters

f1 = Foster.create(name: "Smiths")
f2 = Foster.create(name: "Jones")
f3 = Foster.create(name: "Greens")
