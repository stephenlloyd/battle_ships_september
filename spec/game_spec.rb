require 'game'
describe Game do
	let(:game){Game.new}
	let(:board){double :board, floating_ships?: true}
	let(:board2){double :board}
	let(:player1){double :player, board: board }
	let(:player2){double :player, board: board2 } 

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
		allow(player2).to receive(:receive_shot)
		allow(board2).to receive(:floating_ships?).and_return(true)
		game.shoots(:A1)
		expect(game.turn).to eq player2
	end

	it "receives a shot" do 
		allow(board2).to receive(:floating_ships?).and_return(true)
		expect(player2).to receive(:receive_shot).with(:A1)
		game.shoots(:A1)
	end 


	it "trys to switch turns if there is a shot" do
		allow(board2).to receive(:floating_ships?).and_return(true)
		allow(player2).to receive(:receive_shot).with(:A1)
		expect(game).to receive(:switch_turns)
		game.shoots(:A1)
	end

	it "doesn't switch turns if there is a winner" do 
		allow(board2).to receive(:floating_ships?).and_return(false)
		allow(player2).to receive(:receive_shot).with(:A1)
		game.shoots(:A1)
		expect(game.turn).to eq player1
	end

	it "can have an opponent" do 
		expect(game.opponent).to eq player2
	end

	it "can switch turns" do 
		game.switch_turns
		expect(game.turn).to eq player2
	end

	it "knows if there is a winner" do
		allow(board2).to receive(:floating_ships?).and_return(false)
		expect(game.winner).to eq player1 
	end

end

end