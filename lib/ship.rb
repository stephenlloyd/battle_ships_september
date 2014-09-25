class Ship
	attr_reader :size
	attr_accessor :hits

	def initialize(size)
		@size = size
		@hits = 0
	end

	def hit!
		self.hits += 1
	end

	def sunk?
		hits == size
	end

end