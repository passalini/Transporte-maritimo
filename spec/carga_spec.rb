require './spec/spec_helper'

describe Carga do
	it "criar/aceitar uma carga para transporte" do
		agente = Agente.create! nome: "Derp"
		porto = Porto.create! nome: "Porto Qualquer"
		Carga.create! numero: 001, peso: 100, data_max_desembarque: Date.today + 15.days,
															 porto: porto, agente: agente

		carga = Carga.find_by_numero 001
		carga.should_not be_nil
		carga.porto == porto
		carga.agente == agente
	end
end