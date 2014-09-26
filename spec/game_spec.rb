require 'game'
describe Game do
	let(:game){Game.new}
	let(:board){double :board, floating_ships?: true, ships_count: 1}
	let(:board2){double :board, ships_count: 1}
	let(:player1){double :player, board: board, has_board?: true }
	let(:player2){double :player, board: board2, has_board?: true } 

	it "can have players added" do 
		game.add_player(player1)
		expect(game.player1).to eq player1
	end

	it "can have a second player added" do
		game.add_player(player1)
		game.add_player(player2)
		expect(game.player2).to eq player2
	end

	it "knows when there are two players" do 
		game.send(:add_player, player1)
		game.send(:add_player,player2)
		expect(game.send(:has_two_players?)).to eq true
	end

	it "knows when it doesn't have two players" do
		game.send(:add_player, player1)
		expect(game.send(:has_two_players?)).to eq false
	end

	it "knows whos turn it is" do 
		game.add_player(player1)
		expect(game.send(:turn)).to eq(player1)
	end

context "has two players with boards" do

	before do
		game.add_player(player1)
		game.add_player(player2) 
	end

	it "switchs turns when player1 has a go" do
		allow(player2).to receive(:receive_shot)
		allow(board2).to receive(:floating_ships?).and_return(true)
		game.shoots(:A1)
		expect(game.send(:turn)).to eq player2
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

	it "raises there is a winner if there is a winner" do 
		allow(board2).to receive(:floating_ships?).and_return(false)
		allow(player2).to receive(:receive_shot).with(:A1)
		expect{game.shoots(:A1)}.to raise_error "There is a winner you cannot shoot"
	end

	it "can have an opponent" do 
		expect(game.opponent).to eq player2
	end

	it "can switch turns" do 
		game.send(:switch_turns)
		expect(game.send(:turn)).to eq player2
	end

	it "knows if there is a winner" do
		allow(board2).to receive(:floating_ships?).and_return(false)
		expect(game.winner).to eq player1 
	end

	it "knows a game is not ready" do
		expect(game.ready?).to eq false
	end

	it "expects to ask a ship count from players 1s board" do 
		expect(board).to receive(:ships_count).and_return 5
		game.ready?
	end

	it "expects to ask if player 1 has a board" do 
		expect(player1).to receive(:has_board?).and_return true
		game.ready?
	end

	it "expects to ask a ship count from player 2s board" do 
		allow(board).to receive(:ships_count).and_return 5
		expect(board2).to receive(:ships_count).and_return 5
		game.ready?
	end

	it "expects to ask player2 if they have a board" do 
		expect(player2).to receive(:has_board?).and_return true
		game.ready?
	end

	it "knows when a game is ready" do 
		allow(board).to receive(:ships_count).and_return 5
		allow(player1).to receive(:has_board?).and_return true
		allow(board2).to receive(:ships_count).and_return 5
		allow(player2).to receive(:has_board?).and_return true
		expect(game.ready?).to eq true
	end

end

end