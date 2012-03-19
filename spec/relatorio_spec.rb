#encoding: utf-8
require './spec/spec_helper'

describe "Relatorio" do
  before do
    @navio = Factory.create :navio
    Factory.create :viagem, navio: @navio
    4.times{|i| Factory.create :viagem, navio: @navio, porto_origem: Porto.all.last}
    @carga = Factory.create :carga, porto_origem: Porto.all.first, porto_destino: Porto.all.last
  end

  context "Navios" do 
    it "deve informar nome, capacidade máxima, relação de portos(nome) de sua rota, com a data de chegada em cada porto destino." do
      Navio.relatorio.should == [{nome: "Navio 1", capacidade: 1000, portos: @navio.portos_data}]

      navio2 = Factory.create :navio
      Factory.create :viagem, navio: navio2
      4.times{|i| Factory.create :viagem, navio: navio2, porto_origem: Porto.all.last}
      
      Navio.relatorio.should == [{nome: "Navio 1", capacidade: 1000, portos: @navio.portos_data},
                                 {nome: "Navio 2", capacidade: 1000, portos: navio2.portos_data}]
    end
  end
end