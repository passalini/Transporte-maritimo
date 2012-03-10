class CriarNavios < ActiveRecord::Migration
  def self.up
    create_table :navios do |t|
      t.string :nome
      t.integer :capacidade
    end
  end

  def self.down
    drop_table :navios
  end
end

