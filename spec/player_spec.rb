require 'player'
describe Player do
	let(:player){Player.new}
	let(:board){double :board}
	
	before do
		player.board = board
	end
	 
	it "can have a name" do 
		player.name = "Stephen"
		expect(player.name).to eq "Stephen"
	end

	it "can have a board" do
		expect(player.board).to eq board
	end

	it "knows it has a board" do
		expect(player).to have_board
	end

	it "can receive shots" do
		expect(board).to receive(:shoot_at).with(:A1)
		player.receive_shot(:A1)
	end

end
