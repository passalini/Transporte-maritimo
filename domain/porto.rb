require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'ar_helper')

class Porto < ActiveRecord::Base
	has_and_belongs_to_many :navios
end