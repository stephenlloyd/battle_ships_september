require 'cell'

describe Cell do
	let(:cell){Cell.new}
	let(:content){double :content}
	it "can have content" do
		cell.content = :water
		expect(cell.content).to eq :water
	end

	it "can shoot it's content" do
		cell.content = content
		expect(content).to receive(:hit!)
		cell.shoot
	end
end