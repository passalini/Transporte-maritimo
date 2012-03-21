#encoding: utf-8
require './spec/spec_helper'

describe Agente do
  it { should_not have_valid(:nome).when(nil) }
  it { should_not have_valid(:porto).when(nil) }

  it "pode ter nenhuma ou muitas cargas" do 
    agente = Factory.create :agente
    carga = Factory.create :carga

    agente.cargas << carga
    Agente.first.cargas.should include carga
  end
end