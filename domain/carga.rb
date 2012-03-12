require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Carga < ActiveRecord::Base
	belongs_to :porto
	belongs_to :agente

	def embarcar (navio)
		if self.peso <= navio.capacidade
			navio.cargas << self
		end
	end
end