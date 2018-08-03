require 'rspec'
require 'pry'
require_relative "spec_helper"


describe "Animal" do

  describe "#new" do
    it "it should create a new animal" do
      new_animal = Animal.new(name: "Bilbo", species: "dog")
      expect(new_animal.name).to eq("Bilbo")

  #
  # let(:animal) {Animal.new("Bilbo", "Dog")}
  # describe 'a new animal innitializes without a Foster ID' do
  #   it 'accepts a name and species' do
  #     expect(animal.foster_id).to eq(nil)
    end
  end
end
#     let (:Animal_species?) {Animal_species.new}
#    it "raises an error if wrong species is choosen" do
#        expect Animal.species. == [dog, cat, bird]
#    end
# test 2


# # test 3
#    end
# # test 4
#    it "has a Shelter ID number" do
#        expect(id_s).to be > 0
#    end
# # test 5
#
#    it "divides shelter_census/total_shelter_capacity to get a daily count" do
#        expect(calculator.divide(10, 5)).to eq 2
#    end
# # test 6
#    it "raises an error when dividing by zero" do
#       expect(total_capacity).to be > 0
#     end
#   # test 7
#     it "raises an error when stray animal is not named "do
#       expect (Animal.name).to be "string"
#     end
#   # test 8
#   it "raises an error when     "do
#       expect
#   end
#   # test 9
#   it "raises an error when     "do
#       expect
#   end
#   # test 10
#   it "raises an error when     "do
#       expect
#   end
#   # test 11
#   it "raises an error when     "do
#       expect
#   end
#   # test 12
#   it "raises an error when     "do
#       expect
#   end
#   # test 13
#   it "raises an error when     "do
#       expect
#   end
#   # test 14
#   it "raises an error when     "do
#       expect
#   end
#   # test 15
#   it "raises an error when     "do
#       expect
#   end
