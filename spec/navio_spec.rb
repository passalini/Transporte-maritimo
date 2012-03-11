require './spec/spec_helper'
require './domain/navio'
require './domain/porto'
require './domain/rota'

describe Navio do
  before do
    @porto1 = Porto.create! nome: "Porto1"
    @porto2 = Porto.create! nome: "Porto2"

    navio = Navio.create! nome: 'Navio1', capacidade: '550'
    navio.rotas.create porto: @porto1, data_chegada: Date.tomorrow
    navio.rotas.create porto: @porto2, data_chegada: Date.tomorrow
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

    navio.rotas.first.data_chegada.should == Date.tomorrow
    navio.rotas.first.porto.should == @porto1
  end
end

