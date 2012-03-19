#encoding: utf-8
require './spec/spec_helper'

describe "Embarcar carga" do
  before do
    agente = Agente.create! nome: "Derp"
    @porto1 = Porto.create! nome: "Porto origem da carga"
    @porto2 = Porto.create! nome: "Porto destino da carga"
    @porto3 = Porto.create! nome: "Porto qualquer"
    @carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
                            porto_origem: @porto1 , porto_destino: @porto2, agente: agente
      
    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.viagens.create porto_origem: @porto1, porto_destino: @porto2, data_chegada: Date.tomorrow + 3.days
  end

  it "deve ser possivel se não exceder a capacidade do navio" do 
    @navio.capacidade = 0
      
    @carga.embarcar @navio
    Navio.find_by_nome(@navio.nome).cargas.should_not include @carga

    @navio.capacidade = 100

    @carga.embarcar @navio
    Navio.find_by_nome(@navio.nome).cargas.should include @carga
  end

  it "deve ser possivel se o navio passar pelo porto destino da carga e antes da data_max_desembarque" do 
    navio2 = Navio.create! nome: 'Navio2', capacidade: '550'
    navio2.viagens.create! porto_origem: @porto2, porto_destino: @porto1, data_chegada: Date.tomorrow + 3.days

    @carga.embarcar(navio2)
    Navio.find_by_nome(navio2.nome).cargas.should_not include @carga

    navio2.viagens.create! porto_origem: @porto1, porto_destino: @porto2, data_chegada: Date.tomorrow + 20.days
    @carga.embarcar(navio2)
    
    Navio.find_by_nome(navio2.nome).cargas.should_not include @carga

    navio2.viagens.find_by_porto_destino_id(@porto2.id).update_attributes(data_chegada: Date.today + 2.days)
    @carga.embarcar(navio2)

    Navio.find_by_nome(navio2.nome).cargas.should include @carga
  end

  it "carga deve estar no mesmo porto q navio" do 
    @carga.update_attributes(porto_origem: @porto3, porto_destino: @porto2)
    @carga.embarcar @navio

    Navio.find_by_nome(@navio.nome).cargas.should_not include @carga

    @navio.viagens.create! porto_origem: @porto2, porto_destino: @porto3, data_chegada: Date.tomorrow + 10.days
    @navio.viagens.create! porto_origem: @porto3, porto_destino: @porto1, data_chegada: Date.tomorrow + 10.days
    @carga.embarcar @navio

    Navio.find_by_nome(@navio.nome).cargas.should_not include @carga

    @navio.viagens.create! porto_origem: @porto1, porto_destino: @porto2, data_chegada: Date.tomorrow + 30.days
    @carga.embarcar @navio

    Navio.find_by_nome(@navio.nome).cargas.should include @carga
  end
  
end