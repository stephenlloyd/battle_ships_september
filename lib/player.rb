class Player
	attr_accessor :name, :board

	def has_board?
		!@board.nil?
	end

	def receive_shot(coordinate)
		board.shoot_at(coordinate)
	end
end