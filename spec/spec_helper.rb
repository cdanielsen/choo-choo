require 'pg'
require 'rspec'
require 'line'
require 'station'

DB = PG.connect({:dbname => 'trains_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
  end
end
