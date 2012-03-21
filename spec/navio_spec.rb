require './spec/spec_helper'

describe Navio do
  before do
    @porto1 = Porto.create! nome: "Porto1"
    @porto2 = Porto.create! nome: "Porto2"
    @porto3 = Porto.create! nome: "Porto3"

    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.viagens.create porto_origem: @porto1, porto_destino: @porto2, data_chegada: Date.today
  end

  it "deve fazer viagens de um porto origem para um destino com a data de chegada no mesmo" do 
    navio = Navio.find_by_nome 'Navio1'

    navio.viagens.find_by_porto_destino_id(@porto2.id).data_chegada.should == Date.today
  end

  it "pode ou nao ter cargas embarcadas" do 
    agente = @porto2.agentes.create nome: "Derp"
    carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
                               porto_origem: @porto1, porto_destino: @porto2, agente: agente
    @navio.cargas << carga

    navio = Navio.find_by_id(@navio.id)
    navio.cargas.should include carga
  end

  it "deve retornar o tempo de viagem entre dois portos" do 
    @navio.viagens.create porto_origem: @porto2, porto_destino: @porto3, data_chegada: Date.today + 5.days

    @navio.data_de_chegada(@porto1, @porto2).should == Date.today
    @navio.data_de_chegada(@porto1, @porto3).should == Date.today + 5.days
  end
end

