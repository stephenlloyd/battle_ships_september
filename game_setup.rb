require './lib/water'
require './lib/ship'
require './lib/player'
require './lib/game'
require './lib/cell'
require './lib/board'

game = Game.new
player1 = Player.new
player2 = Player.new
fleet1 = [Ship.aircraft_carrier, Ship.battleship, Ship.destroyer, Ship.submarine, Ship.patrol_boat ]
fleet2 = [Ship.aircraft_carrier, Ship.battleship, Ship.destroyer, Ship.submarine, Ship.patrol_boat ]
board1 = Board.new(Cell)
board2 = Board.new(Cell)
game.add_player(player1)
game.add_player(player2)
player1.board = board1
player2.board = board2

fleet1.each_with_index do |ship, index| 
	coord = ("A" + (index + 1).to_s).to_sym
	board1.place(ship, coord, :vertically)
end

fleet2.each_with_index do |ship, index| 
	coord = ("A" + (index + 1).to_s).to_sym
	board2.place(ship, coord, :vertically)
end



