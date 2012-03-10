class CriarNaviosPortos < ActiveRecord::Migration
  def self.up
    create_table(:navios_portos, :id => false) do |t|
      t.references :navio
      t.references :porto
    end
  end

  def self.down
    drop_table :navios_portos
  end
end

