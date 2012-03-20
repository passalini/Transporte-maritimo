require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Carga < ActiveRecord::Base
  belongs_to :porto_origem, class_name: "Porto"
  belongs_to :porto_destino, class_name: "Porto"
  belongs_to :agente
  belongs_to :navio

  validates_presence_of :numero, :peso, :data_max_desembarque, :porto_destino, :porto_origem, :agente

  def self.embarcadas
    cargas_embarcadas = []
    
    self.all.each do |carga|
      cargas_embarcadas << {carga: carga, data_chegada_navio: carga.navio.data_de_chegada(carga.porto_origem, carga.porto_destino)} if carga.embarcada?  
    end

    return cargas_embarcadas    
  end

  def embarcar (navio)
    if self.peso <= navio.capacidade and navio.viaja_entre?(self.porto_origem, self.porto_destino)
      navio.cargas << self if navio.data_de_chegada(self.porto_origem, self.porto_destino) <= self.data_max_desembarque
    end
  end

  def embarcada?
    not self.navio.nil?
  end
end