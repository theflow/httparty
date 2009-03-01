# example for using the simple_oauth authorization (also called 2-legged OAuth)
# should also work with the Netflix API

dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'httparty')
require 'pp'
config = YAML::load(File.read(File.join(ENV['HOME'], '.qype')))

class Qype
  include HTTParty
  base_uri 'http://api.qype.com/v1'

  def initialize(api_key, api_secret)
    self.class.default_options[:simple_oauth] = {:key => api_key, :secret => api_secret, :method => 'HMAC-SHA1'}
  end

  # fetch a specific place by its id
  def single_place(place_id)
    self.class.get("/places/#{place_id}")
  end

  # search for places in a location
  def search(search_term, location)
    self.class.get('/places', :query => {:show => search_term, :in => location})
  end
end

qype = Qype.new(config['api_key'], config['api_secret'])
pp qype.single_place(42)
pp qype.search('sushi', 'London')
