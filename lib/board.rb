class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
			[*"A".."J"].each do |l|
				[*1..10].each {|n| @grid["#{l}#{n}".to_sym] = content.new}
			end
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		ship.size.times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def put_on_grid_if_possible(coords, ship)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def floating_ships?
		!ships.any?(&:sunk?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
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
	# won't let you place a ship over or next to another ship

end

