#encoding: utf-8
require './spec/spec_helper'

describe Viagem do

  context "Criação" do 

    it { should_not have_valid(:navio).when(nil) }

    it "em uma nova viagem, porto origem deve ser o porto destino da anterior" do
      porto1 = Porto.create! nome: "Porto"
      porto2 = Porto.create! nome: "Porto"
      porto3 = Porto.create! nome: "Porto"
      navio = Navio.create!

      navio.viagens.create! porto_origem: porto1, porto_destino: porto2, data_chegada: Date.tomorrow + 3.days
      expect{navio.viagens.create! porto_origem: porto1, 
                                   porto_destino: porto3, 
                                   data_chegada: Date.tomorrow + 3.days}.to raise_error(RuntimeError)

      navio.viagens.create! porto_origem: porto2, porto_destino: porto3, data_chegada: Date.tomorrow + 4.days
      navio.viagens.create! porto_origem: porto3, porto_destino: porto2, data_chegada: Date.tomorrow + 5.days
      
      lambda {navio.viagens.create! porto_origem: porto2, porto_destino: porto1, data_chegada: Date.tomorrow + 5.days}.should_not raise_error
      navio.viagens.size.should == 4
    end
  end
end