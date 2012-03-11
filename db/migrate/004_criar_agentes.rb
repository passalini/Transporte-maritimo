class CriarAgentes < ActiveRecord::Migration
  def self.up
    create_table :agentes do |t|
      t.string :nome
    end
  end

  def self.down
    drop_table :agentes
  end
end