class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
		[*"A".."J"].each do |letter|
			[*1..10].each {|number| @grid["#{letter}#{number}".to_sym] = content.new}
		end
	end

	def place(ship, coord, orientation = :horizontally)
		ship.size.times do
			grid[coord].content = ship
			coord = next_coord(coord, orientation) 
		end
	end

	def next_coord(coord, orientation)
		return coord.to_s.reverse.next.reverse.to_sym if orientation == :vertically
		coord.next
	end

	def floating_ships?
		ships.any?{|ship|!ship.sunk?}
	end

	def shoot_at(coordinate)
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|cell.content.respond_to?(:sunk?) }.map(&:content)
	end
end

