require_relative 'pieces.rb'

class Chess
	attr_accessor :board, :game_over, :turn

	def initialize
		@board = Hash.new
		@game_over = false
		@turn = "white"
	end

	def create_board
		1.upto(8) do |x|
			1.upto(8) do |y|
				board["#{x}, #{y}"] = Space.new(x, y)
			end
		end
	end

	def create_pieces
		#create pawns
		1.upto(8) do |x|
			board["#{x}, 2"] = Pawn.new("white", x, 2, "wP")
			board["#{x}, 7"] = Pawn.new("black", x, 7, "bP")
		end
		#create rooks
		board["1, 1"] = Rook.new("white", 1, 1, "wR")
		board["8, 1"] = Rook.new("white", 8, 1, "wR")
		board["1, 8"] = Rook.new("black", 1, 8, "bR")
		board["8, 8"] = Rook.new("black", 8, 8, "bR")
		#create knights
		board["2, 1"] = Knight.new("white", 1, 1, "wK")
		board["7, 1"] = Knight.new("white", 8, 1, "wK")
		board["2, 8"] = Knight.new("black", 1, 8, "bK")
		board["7, 8"] = Knight.new("black", 8, 8, "bK")
		#create bishops
		board["3, 1"] = Bishop.new("white", 1, 1, "wB")
		board["6, 1"] = Bishop.new("white", 8, 1, "wB")
		board["3, 8"] = Bishop.new("black", 1, 8, "bB")
		board["6, 8"] = Bishop.new("black", 8, 8, "bB")
		#create kings
		board["5, 1"] = King.new("white", 1, 1, "WK")
		board["5, 8"] = King.new("black", 1, 8, "BK")
		#create queens
		board["4, 1"] = Queen.new("white", 1, 1, "wQ")
		board["4, 8"] = Queen.new("black", 1, 8, "bQ")
	end

	def show_board
		puts "  -----------------------------------------"
		8.downto(1) do |y|
			puts "#{y} | " + board["1, #{y}"].symbol + " | " + board["2, #{y}"].symbol + " | " + board["3, #{y}"].symbol + " | " + board["4, #{y}"].symbol + " | " + board["5, #{y}"].symbol + " | " + board["6, #{y}"].symbol + " | " + board["7, #{y}"].symbol + " | " + board["8, #{y}"].symbol + " |"
			puts "  -----------------------------------------"
		end
		puts "  |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |"
	end

	def pick_piece
		arr = []
		puts "please pick a piece to move (x than y co-ordinate)"
		arr << gets.chomp.to_i
		arr << gets.chomp.to_i
		return arr
	end

	def pick_move
		arr = []
		puts "please pick where you'd like to move selected piece"
		arr << gets.chomp.to_i
		arr << gets.chomp.to_i
		return arr
	end

	def move_valid(piece, move)
		x = piece[0]
		y = piece[1]

		if board["#{x}, {y}"].possible_moves(piece).include? move

		end

	end


	def start
		create_board
		create_pieces
		until game_over == true
			show_board
			if move_valid(pick_piece, pick_move) == true
				@turn = (@turn == "white" ? "black" : "white")
			end
		end

	end


end

game = Chess.new
game.start