require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Navio < ActiveRecord::Base
	has_many :viagens
	has_many :portos_destino, :through => :viagens, :source => :porto_destino
	has_many :portos_origem, :through => :viagens, :source => :porto_origem

	has_many :cargas

	def self.relatorio
   saida = []
   navio = self.all.first
   saida.push ({nome: navio.nome, capacidade: navio.capacidade, portos: navio.portos_data})
  end

  def portos_data
    [self.portos_origem.first].concat self.viagens.map{|viagem| {viagem.porto_destino => viagem.data_chegada}}
  end

  def data_de_chegada(porto_origem, porto_destino)
		if viaja_entre?(porto_origem, porto_destino)
      viagem_entre(porto_origem, porto_destino).first.data_chegada
    else
      nil
    end 
	end

	def viagem_entre(porto_origem, porto_destino)
    viagem_com_porto_origem = self.viagens.find_by_porto_origem_id(porto_origem.id)

    if not viagem_com_porto_origem.nil?
      return self.viagens.find_all{|viagem| viagem.created_at >= viagem_com_porto_origem.created_at}.select{|i| i.porto_destino == porto_destino}
    end
    return []
  end

  def viaja_entre?(porto_origem, porto_destino)
		not viagem_entre(porto_origem, porto_destino).empty?
  end
end

