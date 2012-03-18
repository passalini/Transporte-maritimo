require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Carga < ActiveRecord::Base
  belongs_to :porto_origem, class_name: "Porto"
  belongs_to :porto_destino, class_name: "Porto"
  belongs_to :agente

	def embarcar (navio)
		if self.peso <= navio.capacidade and navio.portos.include? self.porto_destino
			navio.cargas << self if navio.viagens.find_by_porto_destino_id(self.porto_destino.id).data_chegada <= self.data_max_desembarque
		end
	end
end