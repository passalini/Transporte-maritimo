require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Relatorio
  def self.cargas_embarcadas
    Carga.all.map {|carga| {carga: carga, navio: carga.navio, 
                            data_chegada_navio: carga.navio.data_de_chegada(carga.porto_origem, carga.porto_destino)}  }
  end

  def self.cargas_nao_embarcadas
    Carga.nao_embarcadas #realmente nao precisava um servico para isso, mas como antes precisava, acabei deixando
  end

  def self.navios
    Navio.all.map {|navio| {navio: navio , portos: navio.portos_e_data_de_chegada} unless navio.em_manutencao?}
  end

  def self.navios_em_manutencao
    Navio.all.select{|navio| navio.em_manutencao?}
  end

  def self.cargas_que_nao_tem_como_embarcar
    todos_os_portos_destino = []
    Navio.all.map{|navio| todos_os_portos_destino.concat navio.portos_destino}
    Carga.nao_embarcadas.delete_if{|carga| todos_os_portos_destino.include? carga.porto_destino }
  end

  def self.portos
    Porto.all.map { |porto| {porto => porto.navios} }
  end

  def self.portos_agentes_sem_carga
    Porto.all.map { |porto| {porto => porto.agentes.delete_if{|agente| not agente.cargas.empty?} } }.delete_if{|porto| porto.values.first.empty?}
  end
end