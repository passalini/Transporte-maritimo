require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Porto < ActiveRecord::Base
	has_many :navios, :through => :rotas
end