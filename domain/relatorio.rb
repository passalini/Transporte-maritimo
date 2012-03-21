require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Relatorio
  def self.cargas_embarcadas
    cargas_embarcadas = []
    cargas = Carga.embarcadas
    cargas.each do |carga| 
      cargas_embarcadas << {num_carga: carga.numero, navio: carga.navio.nome, 
                            porto_destino: carga.porto_destino, data_max_desembarque: carga.data_max_desembarque, 
                            data_chegada_navio: carga.navio.data_de_chegada(carga.porto_origem, carga.porto_destino)} 
    end
    cargas_embarcadas
  end

  def self.cargas_nao_embarcadas
    cargas_nao_embarcadas = []
    cargas = Carga.nao_embarcadas
    cargas.each do |carga| 
      cargas_nao_embarcadas << {num_carga: carga.numero, porto: carga.porto_destino.nome, 
                                cod_agente: carga.agente.id, data_max_desembarque: carga.data_max_desembarque}
    end
    cargas_nao_embarcadas
  end

  def self.navios
    navios = [] 
    Navio.all.each do |navio|
      navios.push ({nome: navio.nome, capacidade: navio.capacidade, portos: navio.portos_e_data_de_chegada}) unless navio.em_manutencao?
    end
    navios
  end

  def self.navios_em_manutencao
    manutencao = []
    Navio.all.each do |navio|
      manutencao.push navio if navio.em_manutencao?
    end
    manutencao
  end

  def self.cargas_que_nao_tem_como_embarcar
    todos_os_portos_destino = []
    Navio.all.map{|navio| todos_os_portos_destino.concat navio.portos_destino}
    cargas = Carga.nao_embarcadas

    cargas.delete_if{|carga| todos_os_portos_destino.include? carga.porto_destino }
  end

  def self.portos
    portos_navios = []
    Porto.all.map { |porto| portos_navios << {porto => porto.navios} }
    portos_navios
  end
end