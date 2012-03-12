require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Supervisor
	def embarcar (carga, navio)
		if carga.peso <= navio.capacidade
			atributos_de_carga = carga.instance_values["attributes"] 
			atributos_de_carga["navio_id"] = navio.id
			carga.destroy
			navio.carga_embarcadas << CargaEmbarcada.create!(atributos_de_carga) 
		end
	end
end