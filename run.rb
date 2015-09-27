#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/user_interface'
require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/engine'

length = ARGV[0].to_i || 3

begin
  TicTacToe::Engine.new(TicTacToe::Game.new(TicTacToe::Board.new({ :length => length })), 
                        TicTacToe::User_Interface.new).start
#rescue NoMethodError
rescue Interrupt
  puts "Exiting..."
end
