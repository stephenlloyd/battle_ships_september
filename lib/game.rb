class Game
	attr_accessor :player1, :player2
	attr_writer :turn

	def initialize
		player1, player2 = nil, nil
	end

	def add_player(player)
		self.player1 ? self.player2 = player : self.player1 = player unless has_two_players?
	end

	def opponent
		current_player == player1 ? player2 : player1
	end

	def shoots(coord)
		opponent.receive_shot(coord)
		raise "There is a winner you cannot shoot" if winner
		switch_turns 
	end

	def winner
		current_player unless opponent.board.floating_ships?
	end

	def ready?
		has_two_players? and both_players_have_boards? and both_players_have_five_ships?
	end

	def turn 
		@turn ||= player1
	end

	alias :current_player :turn

private 

	def both_players_have_five_ships?
		(player1.board.ships_count == 5) and (player2.board.ships_count == 5) 
	end

	def both_players_have_boards?
		player1.has_board? and player2.has_board? 
	end

	def switch_turns
		turn == player1 ? self.turn = player2 : self.turn = player1
	end

	def has_two_players?
		!player2.nil?
	end
end