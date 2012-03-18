require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Carga < ActiveRecord::Base
	belongs_to :porto
	belongs_to :agente

	def embarcar (navio)
		if self.peso <= navio.capacidade and navio.portos.include? self.porto
			navio.cargas << self if navio.viagens.find_by_porto_destino_id(self.porto.id).data_chegada <= self.data_max_desembarque
		end
	end
end