class Player
	attr_accessor :name, :board
	
	def has_board?
		!@board.nil?
	end

end