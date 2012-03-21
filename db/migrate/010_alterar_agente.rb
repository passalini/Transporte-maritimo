class AlterarAgente < ActiveRecord::Migration
  def self.up
    change_table :agentes do |t|
      t.references :porto
    end
  end

  def self.down
    remove_column :agentes, :porto_id
  end
end