require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Rota < ActiveRecord::Base
	belongs_to :navio
	belongs_to :porto

	validates_presence_of :porto, :data_chegada
end