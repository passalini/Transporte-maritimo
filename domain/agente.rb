require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Agente < ActiveRecord::Base
	belongs_to :porto

  validates_presence_of :nome, :porto
	
end