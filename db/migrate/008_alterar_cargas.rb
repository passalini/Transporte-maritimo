class AlterarCargas < ActiveRecord::Migration
  def self.up
    remove_column :cargas, :porto_id

    change_table :cargas do |t|
      t.integer :porto_origem_id
      t.integer :porto_destino_id
    end
  end

  def self.down
    remove_column :cargas, :porto_origem_id, :porto_destino_id
    add_column :cargas, :porto_id
  end
end