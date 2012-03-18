class CriarViagens < ActiveRecord::Migration
  def self.up
    create_table :viagens do |t|
      t.date :data_chegada
      t.references :navio
      t.integer :porto_origem_id
      t.integer :porto_destino_id
    end
  end

  def self.down
    drop_table :viagens
  end
end

