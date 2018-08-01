
class AddCapacityToFosters < ActiveRecord::Migration

  def change
    add_column :fosters, :capacity, :integer
  end
end
