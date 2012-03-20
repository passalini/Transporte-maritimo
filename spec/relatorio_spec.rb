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
      relatorio_cargas_embarcas = [{num_carga: @carga.numero, navio: @carga.navio.nome, porto_destino: @carga.porto_destino, data_max_desembarque: @carga.data_max_desembarque, data_chegada_navio: @carga.navio.data_de_chegada(@carga.porto_origem, @carga.porto_destino)} ]
      
      Relatorio.cargas_embarcadas.should == relatorio_cargas_embarcas

      5.times do |i|
        carga = Factory.create(:carga, peso: 10, porto_origem: @navio.portos_origem.first, porto_destino: @navio.portos_destino[i]).embarcar(@navio).last
        relatorio_cargas_embarcas << {num_carga: carga.numero, navio: carga.navio.nome, 
                                      porto_destino: carga.porto_destino, data_max_desembarque: carga.data_max_desembarque, 
                                      data_chegada_navio: @navio.viagens.find_by_porto_destino_id(@navio.portos_destino[i].id).data_chegada}
      end
        
      Relatorio.cargas_embarcadas.should == relatorio_cargas_embarcas
    end

    it "não embarcadas, informando: número da carga, porto destino, data máxima para desembarque e código do agente receptor" do 
      Relatorio.cargas_nao_embarcadas.should include ({ num_carga: @carga.numero, porto: @carga.porto_destino.nome,
                                                        cod_agente: @carga.agente.id, data_max_desembarque: @carga.data_max_desembarque})
      
      @carga.embarcar @navio

      Relatorio.cargas_nao_embarcadas.should_not include ({ num_carga: @carga.numero, porto: @carga.porto_destino.nome,
                                                            cod_agente: @carga.agente.id, data_max_desembarque: @carga.data_max_desembarque})

      cargas_nao_embarcadas = []
      5.times{cargas_nao_embarcadas << Factory.create(:carga)}
      cargas_nao_embarcadas.map!{|carga| { num_carga: carga.numero, porto: carga.porto_destino.nome,
                                           cod_agente: carga.agente.id, data_max_desembarque: carga.data_max_desembarque} }

      Relatorio.cargas_nao_embarcadas.should == cargas_nao_embarcadas
    end

  end
end