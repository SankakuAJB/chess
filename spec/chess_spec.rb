require "./lib/chess.rb"
require "spec_helper"

describe Chess do 
	let(:game) {Chess.new}

	describe "#create_board" do

		it "should have 64 keys/cells"
			expect(game.board.length).to eq(64)
		end

		it "should return ' ' for all values on creation"
		 expect(game.board.each_value).to all eq(" ")
		end

	end

	describe "#move_piece"

		it "should move a piece on the board" do

		end
	
		it "should return false for values outside the board" do

		end

	end

	describe "#move_valid"

		it "returns an array of possible moves (x, y)" do

		end





end