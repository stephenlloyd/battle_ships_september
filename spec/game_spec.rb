require 'game'
describe Game do
	let(:game){Game.new}
	let(:player1){double :player  }
	let(:player2){double :player}

	it "can have players added" do 
		game.add_player(player1)
		expect(game.player1).to eq player1
	end

	it "can have a second player added" do
		game.add_player(player1)
		game.add_player(player2)
		expect(game.player2).to eq player2
	end

	it "is ready to begin when there are two players" do 
		game.add_player(player1)
		game.add_player(player2)
		expect(game.has_two_players?).to eq true
	end

	it "knows when it doesn't have two players" do
		game.add_player(player1)
		expect(game.has_two_players?).to eq false
	end

	it "knows whos turn it is" do 
		game.add_player(player1)
		expect(game.turn).to eq(player1)
	end

context "game is ready" do 
	before do
		game.add_player(player1)
		game.add_player(player2) 
	end

	it "switchs turns when player1 has a go" do
		game.shoots(:A1)
		expect(game.turn).to eq player2
	end

end

end