class CriarRotas < ActiveRecord::Migration
  def self.up
    create_table :rotas do |t|
      t.date :data_chegada
      t.references :navio
      t.references :porto
    end
  end

  def self.down
    drop_table :rotas
  end
end

