class Cell
	attr_accessor :content

	def shoot
		content.hit!
	end
end