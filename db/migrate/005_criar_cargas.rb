class CriarCargas < ActiveRecord::Migration
  def self.up
    create_table :cargas do |t|
      t.integer :numero
      t.integer :peso
      t.date :data_max_desembarque
      t.references :porto
      t.references :agente
    end
  end

  def self.down
    drop_table :cargas
  end
end