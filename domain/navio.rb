require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Navio < ActiveRecord::Base
	has_many :viagens
	has_many :portos, :through => :viagens, :source => :porto_destino
	has_many :cargas
end

