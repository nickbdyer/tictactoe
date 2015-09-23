#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/user_interface'
require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/engine'


begin
  TicTacToe::Engine.new(TicTacToe::Game.new(TicTacToe::Board.new(3)), TicTacToe::User_Interface.new).start
#rescue NoMethodError
rescue Interrupt
  puts "Exiting..."
end
