#encoding: utf-8
require './spec/spec_helper'

describe Viagen do

  context "Criação" do 

    it { should_not have_valid(:navio).when(nil) }

    it "em uma nova viagem, porto origem deve ser o porto destino da anterior" do
      porto1 = Porto.create!
      porto2 = Porto.create!
      porto3 = Porto.create!
      navio = Navio.create!

      navio.viagens.create! porto_origem: porto1, porto_destino: porto2, data_chegada: Date.tomorrow + 3.days
      expect{navio.viagens.create! porto_origem: porto1, 
                                   porto_destino: porto3, 
                                   data_chegada: Date.tomorrow + 3.days}.to raise_error(RuntimeError)

      navio.viagens.create! porto_origem: porto2, porto_destino: porto3, data_chegada: Date.tomorrow + 3.days
      navio.viagens.size.should == 2
    end
  end
end