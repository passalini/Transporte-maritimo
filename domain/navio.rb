require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Navio < ActiveRecord::Base
	has_many :viagens
  has_many :portos_destino, :through => :viagens, :source => :porto_destino
	has_many :portos_origem, :through => :viagens, :source => :porto_origem

	has_many :cargas

  def data_de_chegada(porto)
    self.viagens.find_by_porto_destino_id(porto.id).data_chegada 
  end

end

