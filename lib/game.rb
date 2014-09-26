class Game
	attr_accessor :player1, :player2
	attr_writer :turn

	def initialize
		player1 = nil
		player2 = nil
	end

	def add_player(player)
		self.player1 ? self.player2 = player : self.player1 = player
	end

	def has_two_players?
		!player2.nil?
	end

	def turn 
		@turn ||= player1
	end

	def opponent
		turn == player1 ? player2 : player1
	end

	def shoots(coord)
		opponent.receive_shot(coord)
		switch_turns unless winner
	end

	def switch_turns
		turn == player1 ? self.turn = player2 : self.turn = player1
	end

	def winner
		turn if !opponent.board.floating_ships?
	end

end