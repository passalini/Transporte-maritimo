#encoding: utf-8
require './spec/spec_helper'

describe Porto do
  it { should_not have_valid(:nome).when(nil) }

  it "pode ter nenhuma ou muitos agentes" do 
    porto = Factory.create :porto
    agente = porto.agentes.build(nome: "Agente")
    # agente2 = Factory.create :agente

    Porto.first.agentes.should include agente #and agente2
  end
end