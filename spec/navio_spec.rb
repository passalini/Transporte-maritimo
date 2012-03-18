require './spec/spec_helper'

describe Navio do
  before do
    @porto1 = Porto.create! nome: "Porto1"
    @porto2 = Porto.create! nome: "Porto2"

    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.viagens.create porto_origem: @porto1, porto_destino: @porto2, data_chegada: Date.tomorrow
  end

  it 'criar um navio' do
    navio = Navio.find_by_nome 'Navio1'

    navio.should_not be_nil
    navio.nome.should == 'Navio1'
    navio.capacidade.should == 550
    navio.portos.should include @porto2
  end

  it "deve fazer viagens de um porto origem para um destino com a data de chegada no mesmo" do 
    navio = Navio.find_by_nome 'Navio1'

    navio.viagens.find_by_porto_destino_id(@porto2.id).data_chegada.should == Date.tomorrow
  end

  it "pode ou nao ter cargas embarcadas" do 
    agente = Agente.create! nome: "Derp"
    carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
                               porto: @porto2, agente: agente
    @navio.cargas << carga

    navio = Navio.find_by_id(@navio.id)
    navio.cargas.should include carga
  end
end

