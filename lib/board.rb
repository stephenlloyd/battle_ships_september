class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each {|n| @grid["#{l}#{n}".to_sym] = content.new}
		end
	end

	def place(ship, coord, orientation = :horizontally)
		ship.size.times do
			grid[coord].content = ship
			coord = next_coord(coord, orientation) 
		end
	end

	def floating_ships?
		!ships.any?(&:sunk?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content)
	end

private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : coord.next
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?) 
	end

	# todo
	# won't let you place a ship outside of the grid
	# won't let you place a ship over or next to another ship
	
end

