require 'player'
describe Player do
	let(:player){Player.new}
	let(:board){double :board} 
	it "can have a name" do 
		player.name = "Stephen"
		expect(player.name).to eq "Stephen"
	end

	it "can have a board" do 
		player.board = board
		expect(player.board).to eq board
	end

	it "can haz board?" do
		player.board = board
		expect(player).to have_board
	end

end