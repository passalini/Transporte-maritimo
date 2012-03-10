require './spec/spec_helper'
require './domain/navio'
require './domain/porto'

describe Navio do
  it 'criar um navio' do
  	porto1 = Porto.create! nome: "Porto1"
  	porto2 = Porto.create! nome: "Porto2"

    Navio.create! nome: 'Navio1', capacidade: '550', portos: [porto1,porto2]

    navio = Navio.find_by_nome 'Navio1'
    navio.should_not be_nil
    navio.nome.should == 'Navio1'
    navio.capacidade.should == 550
    navio.portos.should include porto1
  end
end

