require 'yaml'
require 'sinatra'
require 'sinatra/json'
require_relative './lib/game_options.rb'

configure do
  if GameOptions.shared_instance.nil?
    data = YAML.load_file(File.join(__dir__, 'data/monsters.yml'))
    GameOptions.shared_instance = GameOptions.new(data)
  end
end

get '/' do
  json GameOptions.shared_instance.random_monsters(2), content_type: 'application/json;charset=utf-8'
end
