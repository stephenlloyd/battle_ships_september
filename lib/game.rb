class Game
	attr_accessor :player1, :player2

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
		player1
	end

	def opponent
	end

	def shoots(coord)
		opponent.receive_shot()
		switch_turns
	end



end