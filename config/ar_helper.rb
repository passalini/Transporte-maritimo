require 'active_record'
require 'yaml'
require 'active_support/all'

ActiveSupport::Inflector.inflections do |inflect|
inflect.plural /m$/i, 'ns'
inflect.singular /ns$/i, 'm'
# inflect.plural /el$/i, 'eis'
# inflect.singular /eis$/i, 'el'
end

ActiveRecord::Base.establish_connection(YAML::load(
  File.open(File.join(File.dirname(__FILE__), 'database.yml'))))

