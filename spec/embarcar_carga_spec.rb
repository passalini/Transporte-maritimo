#encoding: utf-8
require './spec/spec_helper'

describe "embarcar carga" do
	it "embarcar uma carga qualquer em um navio" do 
		agente = Agente.create! nome: "Derp"
		porto = Porto.create! nome: "Porto Qualquer"
		carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
															 porto: porto, agente: agente
		porto1 = Porto.create! nome: "Porto1"
	    navio = Navio.create! nome: 'Navio1', capacidade: '550'
	    navio.rotas.create porto: porto1, data_chegada: Date.tomorrow + 3.days

	    supervisor = Supervisor.new

	    supervisor.embarcar(carga,navio)

	    navio.carga_embarcadas.should include CargaEmbarcada.find_by_numero(carga.numero)
	end
end