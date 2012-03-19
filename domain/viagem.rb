require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Viagem < ActiveRecord::Base
	belongs_to :navio
  belongs_to :porto_origem, class_name: "Porto"
	belongs_to :porto_destino, class_name: "Porto"
  
  before_create :validar_viagem

  validates_presence_of :navio, :porto_origem, :porto_destino
  
  protected

  def validar_viagem
    if  Navio.find(navio_id).portos_origem.empty?
      true
    else
      raise "Porto de origem deve ser o mesmo que o porto destino da viagem anterior" unless Viagem.all.find_all{|i| i.navio_id == navio_id}.sort_by{|i| i[:created_at]}.last.porto_destino == porto_origem
    end
  end
end