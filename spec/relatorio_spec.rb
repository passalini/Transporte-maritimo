#encoding: utf-8
require './spec/spec_helper'

describe Relatorio do
  before do
    FactoryGirl.reload
    @navio = Factory.create :navio
    Factory.create :viagem, navio: @navio
    4.times{|i| Factory.create :viagem, navio: @navio, porto_origem: Porto.all.last}
    @carga = Factory.create :carga, porto_origem: Porto.all.first, porto_destino: Porto.all.last
  end

  context "Navios" do 
    it "deve informar nome, capacidade máxima, relação de portos(nome) de sua rota, com a data de chegada em cada porto destino." do
      Relatorio.navios.should == [{nome: "Navio 1", capacidade: 1000, portos: @navio.portos_e_data_de_chegada}]

      navio2 = Factory.create :navio
      Factory.create :viagem, navio: navio2
      4.times{|i| Factory.create :viagem, navio: navio2, porto_origem: Porto.all.last}
      
      Relatorio.navios.should == [{nome: "Navio 1", capacidade: 1000, portos: @navio.portos_e_data_de_chegada},
                                 {nome: "Navio 2", capacidade: 1000, portos: navio2.portos_e_data_de_chegada}]
    end

    it "deve informar quais estão em manutenção" do 
      navio_em_manutencao = Factory.create :navio #sem viagens agendadas ou apartir do dia corrente 
      
      Relatorio.navios_em_manutencao.should include navio_em_manutencao
      Relatorio.navios_em_manutencao.should_not include @navio
    end
  end

  context "Cargas" do 
    it "para embarcadas, informar: número, porto destino, navio, data máxima para desembarque e data na qual o navio vai chegar no porto" do
      @carga.embarcar @navio
      relatorio_cargas_embarcas = [{carga: @carga, data_chegada_navio: @navio.viagens.last.data_chegada}]
      
      Relatorio.cargas_embarcadas.should == relatorio_cargas_embarcas

      5.times do |i|
        carga = Factory.create(:carga, peso: 10, porto_origem: @navio.portos_origem.first, porto_destino: @navio.portos_destino[i]).embarcar(@navio).last
        relatorio_cargas_embarcas << {carga: carga, data_chegada_navio: @navio.viagens.find_by_porto_destino_id(@navio.portos_destino[i].id).data_chegada}
      end
      
      Relatorio.cargas_embarcadas.should == relatorio_cargas_embarcas
    end

    it "cargas não embarcadas, informando: número da carga, porto destino, data máxima para desembarqu e código do agente receptor" do 
      @carga.embarcar @navio
      cargas_nao_embarcadas = []
      5.times{cargas_nao_embarcadas << Factory.create(:carga)}

      Relatorio.cargas_nao_embarcadas.should_not include @carga
      Relatorio.cargas_nao_embarcadas.should == cargas_nao_embarcadas
    end
  end
end