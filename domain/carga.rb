require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Carga < ActiveRecord::Base
  belongs_to :porto_origem, class_name: "Porto"
  belongs_to :porto_destino, class_name: "Porto"
  belongs_to :agente

	def embarcar (navio)
		if self.peso <= navio.capacidade and navio.portos_destino.include? self.porto_destino and navio.portos_origem.include? self.porto_origem
			navio.cargas << self if navio.data_de_chegada(self.porto_destino) <= self.data_max_desembarque
		end
	end
end