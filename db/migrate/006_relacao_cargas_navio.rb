class RelacaoCargasNavio < ActiveRecord::Migration
  def self.up
    change_table :cargas do |t|
      t.references :navio
    end
  end

  def self.down
    remove_column :cargas, :navio_id
  end
end