class AlterarViagem < ActiveRecord::Migration
  def self.up
    change_table :viagens do |t|
      t.timestamps
    end
  end

  def self.down
    remove_column :viagens, :created_at, :updated_at
  end
end