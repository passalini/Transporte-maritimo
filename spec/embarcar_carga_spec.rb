#encoding: utf-8
require './spec/spec_helper'

describe "Embarcar carga" do
	before do
		agente = Agente.create! nome: "Derp"
		porto = Porto.create! nome: "Porto destino da carga"
		@carga = Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
 												  porto: porto, agente: agente
		
		porto1 = Porto.create! nome: "Porto qualquer"
    @navio = Navio.create! nome: 'Navio1', capacidade: '550'
    @navio.rotas.create porto: porto1, data_chegada: Date.tomorrow + 3.days

    @supervisor = Supervisor.new
	end

	it "deve ser possivel se não esceder a capacidade do navio" do 
		@navio.capacidade = 0
		
		@supervisor.embarcar(@carga,@navio)
		@navio.carga_embarcadas.should_not include CargaEmbarcada.find_by_numero(@carga.numero)
	end
	
end