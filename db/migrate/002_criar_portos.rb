class CriarPortos < ActiveRecord::Migration
  def self.up
    create_table :portos do |t|
      t.string :nome
    end
  end

  def self.down
    drop_table :portos
  end
end

