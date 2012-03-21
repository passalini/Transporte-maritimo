#encoding: utf-8
require './spec/spec_helper'

describe Porto do
  it { should_not have_valid(:nome).when(nil) }

  it "pode ter nenhuma ou muitos agentes" do 
    porto = Factory.create :porto
    agente = porto.agentes.create(nome: "Agente")
    agente2 = porto.agentes.create(nome: "Agente 2")

    Porto.first.agentes.should include agente and agente2
  end
end