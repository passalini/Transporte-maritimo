require './spec/spec_helper'

describe Navio do
  before do
    @porto1 = Porto.create! nome: "Porto1"
    @porto2 = Porto.create! nome: "Porto2"

    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.rotas.create porto: @porto1, data_chegada: Date.tomorrow
    @navio.rotas.create porto: @porto2, data_chegada: Date.today + 5.days
  end

  it 'criar um navio' do
    navio = Navio.find_by_nome 'Navio1'

    navio.should_not be_nil
    navio.nome.should == 'Navio1'
    navio.capacidade.should == 550
    navio.portos.should include @porto1 and @porto2
  end

  it "deve conter um porto e data de chegada no mesmo" do 
    navio = Navio.find_by_nome 'Navio1'

    navio.rotas.find_by_porto_id(@porto1.id).data_chegada.should == Date.tomorrow
    navio.rotas.find_by_porto_id(@porto2.id).data_chegada.should == Date.today + 5.days
  end

  it "pode ou nao ter cargas embarcadas" do 
    agente = Agente.create! nome: "Derp"
    carga = CargaEmbarcada.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
                               porto: @porto1, agente: agente
    @navio.carga_embarcadas << carga

    navio = Navio.find_by_id(@navio.id)
    navio.carga_embarcadas.should include carga
  end
end

