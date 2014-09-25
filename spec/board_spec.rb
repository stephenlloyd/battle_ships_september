require 'board'

describe Board do
	let(:water) {double :water}
	let(:cell){double :cell, content: water, :content= => nil}
	let(:second_cell){double :second_cell, :content= => nil}
	let(:cell_class){double :cell_class, :new => cell}
	let(:ship){double :ship, size: 2, sunk?: false }
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
		sunk_ship = double :ship, size: 1, sunk?: true
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



end