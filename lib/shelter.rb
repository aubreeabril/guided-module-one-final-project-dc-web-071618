class Shelter < ActiveRecord::Base
  has_many :animals
  has_many :fosters, through: :animals
end
