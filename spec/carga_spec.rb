#encoding: utf-8
require './spec/spec_helper'

describe Carga do
  context "criação" do 
    it { should_not have_valid(:numero).when(nil) }
    it { should_not have_valid(:peso).when(nil) }
    it { should_not have_valid(:data_max_desembarque).when(nil) }
    it { should_not have_valid(:porto_origem).when(nil) }
    it { should_not have_valid(:porto_destino).when(nil) }
    it { should_not have_valid(:agente).when(nil) }
  end

  context "metodos de classe" do 
    it "deve retornar cargas não embarcadas" do
      5.times{Factory.create :carga}
      Carga.nao_embarcadas.should == Carga.all

      navio = Factory.create(:navio)
      viagem = Factory.create(:viagem, navio: navio)
      carga = Factory.create(:carga, porto_origem: viagem.porto_origem, porto_destino: viagem.porto_destino)
      Carga.nao_embarcadas.should include carga

      carga.embarcar navio
      Carga.nao_embarcadas.should_not include carga
    end

    it "deve retornar cargas embarcadas" do
      navio = Factory.create(:navio)
      viagem = Factory.create(:viagem, navio: navio)
      p carga = Factory.create(:carga, porto_origem: viagem.porto_origem, porto_destino: viagem.porto_destino)
      Carga.embarcadas.should_not include carga

      carga.embarcar navio
      Carga.embarcadas.should include carga

      5.times{Factory.create(:carga, porto_origem: viagem.porto_origem, porto_destino: viagem.porto_destino).embarcar(navio)}
      Carga.embarcadas.should == Carga.all
    end
  end
end