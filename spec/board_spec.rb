require 'board'

describe Board do
	let(:water) {double :water}
	let(:cell){double :cell, content: water, :content= => nil, hit?:nil}
	let(:second_cell){double :second_cell, :content= => nil,content: nil, hit?: nil}
	let(:third_cell){double :second_cell, :content= => nil, hit?: nil}
	let(:cell_class){double :cell_class, :new => cell}
	let(:ship){double :ship, size: 2, sunk?: false, floating?: true }
	let(:second_ship){double :ship, size: 2, sunk?: false }
	let(:board){Board.new(cell_class)}

	it "can have a grid of 100 places" do
		expect(board.grid.count).to eq 100
	end

	it "should have coordiantes" do
		expect(board.grid[:A1].content).to eq water
	end

	it "can place a ship" do
		board.grid[:A2] = second_cell
		expect(cell).to receive(:content=).with(ship)
		board.place(ship,:A1)
	end

	it "places a ship in all it's positions" do 
		board.grid[:A2] = second_cell
		allow(cell).to receive(:content=).with(ship)
		expect(second_cell).to receive(:content=).with(ship)
		board.place(ship, :A1)
	end

	it "can place a ship verticall" do 
		board.grid[:B1] = second_cell
		expect(second_cell).to receive(:content=).with(ship)
		board.place(ship, :A1, :vertically)
	end

	it "knows if there are still floating ships" do
		allow(board).to receive(:ships).and_return [ship]
		expect(board.floating_ships?).to eq true
	end

	it "knows when there are no floating ships" do 
		sunk_ship = double :ship, size: 1, sunk?: true, floating?: false
		allow(board).to receive(:ships).and_return [sunk_ship]
		expect(board.floating_ships?).to eq false
	end

	it "passes a shot onto a ship" do
		expect(cell).to receive(:shoot)
		board.shoot_at(:A1)
	end

	it 'has a list of all the ships' do
		board.grid[:A1] = second_cell
		allow(second_cell).to receive(:content).and_return ship
		expect(board.ships).to eq [ship]
	end

	it "cannot shoot at a cell which has been hit already" do
		allow(cell).to receive(:hit?).and_return true
		expect{board.shoot_at(:A1)}.to raise_error "You cannot hit the same square twice"
	end

	it "won't let you place ship outside of the grid" do
		expect{board.place(ship, :K1)}.to raise_error "You cannot place a ship outside of the grid"
	end

	it "knows how many ships are on the grid" do
		board.grid[:A1],board.grid[:A2] = second_cell, second_cell
		board.grid[:B1] = third_cell
		allow(second_cell).to receive(:content).and_return ship
		allow(third_cell).to receive(:content).and_return second_ship
		expect(board.ships_count).to eq 2
	end

	it "won't let you place a ship on top of another ship" do
		board.grid[:A1] = second_cell
		allow(second_cell).to receive(:content).and_return ship
		expect{board.place(ship,:A1)}.to raise_error "You cannot place a ship on another ship"
	end

end