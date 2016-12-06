require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

Dir["lib/concerns/*.rb"].each {|f| require f}
Dir["lib/models/*.rb"].each {|f| require f}
Dir["lib/data_fetchers/*.rb"].each {|f| require f}
Dir["lib/runners/*.rb"].each {|f| require f}

require "rest-client"
require "open-uri"
require "json"
require "pry"
require "pp"
