#encoding: utf-8
require './spec/spec_helper'

describe "Embarcar carga" do
  before do
    agente = Agente.create! nome: "Derp"
    porto = Porto.create! nome: "Porto destino da carga"
    @carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
                            porto: porto, agente: agente
      
    porto1 = Porto.create! nome: "Porto qualquer"
    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.rotas.create porto: porto1, data_chegada: Date.tomorrow + 3.days
  end

  it "deve ser possivel se não esceder a capacidade do navio" do 
    @navio.capacidade = 0
      
    @carga.embarcar @navio
    Navio.find_by_nome(@navio.nome).cargas.should_not include @carga

    @navio.capacidade = 100

    @carga.embarcar @navio
    Navio.find_by_nome(@navio.nome).cargas.should include @carga
  end
  
end