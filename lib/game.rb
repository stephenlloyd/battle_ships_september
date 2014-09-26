class Game
	attr_accessor :player1, :player2
	attr_writer :turn

	def initialize
		player1, player2 = nil, nil
	end

	def add_player(player)
		self.player1 ? self.player2 = player : self.player1 = player unless has_two_players?
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
		raise "There is a winner" if winner
		switch_turns 
	end

	def switch_turns
		turn == player1 ? self.turn = player2 : self.turn = player1
	end

	def winner
		turn unless opponent.board.floating_ships?
	end

	#todo
	# def ready?
	# 	if has_two_players?
	# 	if both_players_have_boards?
	# 	if both_players_boards_have_five_ships_placed?
	# end

end