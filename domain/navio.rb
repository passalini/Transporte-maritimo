require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Navio < ActiveRecord::Base
	has_many :rotas
	has_many :portos, :through => :rotas
	has_many :carga_embarcadas
end

