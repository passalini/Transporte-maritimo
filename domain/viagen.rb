require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Viagen < ActiveRecord::Base
	belongs_to :navio
  belongs_to :porto_origem, class_name: "Porto"
	belongs_to :porto_destino, class_name: "Porto"

end