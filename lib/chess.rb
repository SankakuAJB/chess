require_relative 'pieces.rb'

class Chess
	attr_accessor :board, :game_over, :turn
	include Pieces

	def initialize
		@board = Hash.new
		@game_over = false
		@turn = "white"
	end

	def create_board
		1.upto(8) do |x|
			1.upto(8) do |y|
				board["#{x}, #{y}"] = Pieces::Space.new
			end
		end
	end

	def create_pieces
		#create pawns
		1.upto(8) do |x|
			board["#{x}, 2"] = Pieces::Pawn.new("white", "wP")
			board["#{x}, 7"] = Pieces::Pawn.new("black", "bP")
		end
		#create rooks
		board["1, 1"] = Pieces::Rook.new("white", "wR")
		board["8, 1"] = Pieces::Rook.new("white", "wR")
		board["1, 8"] = Pieces::Rook.new("black", "bR")
		board["8, 8"] = Pieces::Rook.new("black", "bR")
		#create knights
		board["2, 1"] = Pieces::Knight.new("white", "wK")
		board["7, 1"] = Pieces::Knight.new("white", "wK")
		board["2, 8"] = Pieces::Knight.new("black", "bK")
		board["7, 8"] = Pieces::Knight.new("black", "bK")
		#create bishops
		board["3, 1"] = Pieces::Bishop.new("white", "wB")
		board["6, 1"] = Pieces::Bishop.new("white", "wB")
		board["3, 8"] = Pieces::Bishop.new("black", "bB")
		board["6, 8"] = Pieces::Bishop.new("black", "bB")
		#create kings
		board["5, 1"] = Pieces::King.new("white", "WK")
		board["5, 8"] = Pieces::King.new("black", "BK")
		#create queens
		board["4, 1"] = Pieces::Queen.new("white", "wQ")
		board["4, 8"] = Pieces::Queen.new("black", "bQ")
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
		puts "#{turn} please pick a piece to move (x than y co-ordinate)"
		arr << gets.chomp.to_i
		arr << gets.chomp.to_i
		return arr
	end

	def pick_move
		arr = []
		puts "#{turn} please pick where you'd like to move selected piece"
		arr << gets.chomp.to_i
		arr << gets.chomp.to_i
		return arr
	end

	def move_valid(piece, move)
		if piece.any? {|value| value >8} || piece.any? {|value| value <1} || move.any? {|value| value >8} || move.any? {|value| value <1}
			return false
		end

		x = piece[0]
		y = piece[1]
		a = move[0]
		b = move[1]
		possibilities = []
		selected = board.fetch("#{x}, #{y}")

		if selected.instance_of? Space
			return
		elsif selected.instance_of? Pawn
			possibilities = pawn_moves(piece, move)
		elsif (selected.instance_of? Knight) || (selected.instance_of? King)
			possibilities = knight_king_moves(piece, move)
		else
			possibilities = rbq_moves(piece, move)	
		end	

		if selected.instance_of? King
			if (check_rbq(move) == true) || (check_knight(move) == true) || (check_pawn(move) == true) || (check_king(move) == true)
				puts "Can't make that move, would put you in check."
				return false
			end
		end

		if possibilities.include? move
			selected.first_move = false if selected.first_move == true
			board["#{a}, #{b}"] = board.fetch("#{x}, #{y}")
			board["#{x}, #{y}"] = Pieces::Space.new
			return true
		end

	end

	def check_king(move)
		options = [ [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1] ]
		possibilities = Array.new

		options.each do |arr|
			pos = []
			pos << (move[0] + arr[0])
			pos << (move[1] + arr[1])
			if (board.fetch("#{pos[0]}, #{pos[1]}").colour != turn) && (board.fetch("#{pos[0]}, #{pos[1]}").instance_of? King)
				possibilities << [pos[0], pos[1]]
			end

		end

		if possibilities.empty?
			return false
		else
			return true
		end
	end

	def check_pawn(move)
		if turn == "white"
			options = [ [-1, 1], [1, 1] ]
		else
			options = [ [-1, -1], [1, -1] ]
		end
		possibilities = Array.new

		options.each do |arr|
			pos = []
			pos << (move[0] + arr[0])
			pos << (move[1] + arr[1])
			if (board.fetch("#{pos[0]}, #{pos[1]}").colour != turn) && (board.fetch("#{pos[0]}, #{pos[1]}").instance_of? Pawn)
				possibilities << [pos[0], pos[1]]
			end

		end

		if possibilities.empty?
			return false
		else
			return true
		end
	end

	def check_rbq(move)
		options = [ [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1] ]
		possibilities = Array.new

		options.each do |arr|
			spot = nil
			pos = []
			pos << (move[0] + arr[0])
			pos << (move[1] + arr[1])

			until (pos.any? {|value| value < 1}) || (pos.any? {|value| value > 8}) || (spot.kind_of? Piece)
				spot = board.fetch("#{pos[0]}, #{pos[1]}")
				if ((spot.instance_of? Bishop) || (spot.instance_of? Rook) || (spot.instance_of? Queen)) && (spot.colour != turn)
					possibilities << [pos[0], pos[1]]
				end
				pos[0] += arr[0]
				pos[1] += arr[1]
			end
		end

		if possibilities.empty?
			return false
		else
			return true
		end
	end

	def check_knight(move)
		options = [ [2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2] ]
		possibilities = Array.new

		options.each do |arr|
			pos = []
			pos << (move[0] + arr[0])
			pos << (move[1] + arr[1])

			if (pos.all? {|value| value >= 1}) && (pos.all? {|value| value <= 8})
				if (board.fetch("#{pos[0]}, #{pos[1]}").colour != turn) && (board.fetch("#{pos[0]}, #{pos[1]}").instance_of? Knight)
					possibilities << [pos[0], pos[1]]
				end
			end
		end

		if possibilities.empty?
			return false
		else
			return true
		end
	end

	def knight_king_moves(piece, move)
		x = piece[0]
		y = piece[1]
		possibilities = Array.new
		selected = board.fetch("#{x}, #{y}")

		selected.options.each do |arr|
			pos = []
			pos << (x + arr[0])
			pos << (y + arr[1])

			if (pos.all? {|value| value >= 1}) && (pos.all? {|value| value <= 8})
				if (board.fetch("#{pos[0]}, #{pos[1]}").colour != turn)
					possibilities << [pos[0], pos[1]]
				end
			end

		end

		possibilities
	end

	def pawn_moves(piece, move)
		x = piece[0]
		y = piece[1]
		possibilities = Array.new
		selected = board.fetch("#{x}, #{y}")
		if turn == "white"
			if selected.first_move == true 
				possibilities = [ [x,y+1], [x,y+2] ]
			else
				possibilities = [[x,y+1]]
			end 
		end
		if turn == "black"
			if selected.first_move == true 
				possibilities = [ [x,y-1], [x,y-2] ]
			else
				possibilities = [[x,y-1]]
			end 
		end

		pawn_attacks(piece).each {|arr| possibilities << arr}

		possibilities.each do |arr|
			if board.fetch("#{arr[0]}, #{arr[1]}")

			end
		end
		puts ""
		puts move.join(", ")
		puts possibilities.join(", ")
		possibilities
	end

	def pawn_attacks(piece)
		x = piece[0]
		y = piece[1]
		possibilities = Array.new

		if turn == "white"
			options = [ [-1, 1], [1, 1] ]
		else
			options = [ [-1, -1], [1, -1] ]
		end

		options.each do |arr|
			pos = []
			pos << (x + arr[0])
			pos << (y + arr[1])

			if (pos.all? {|value| value >= 1}) && (pos.all? {|value| value <= 8})
				if (board.fetch("#{pos[0]}, #{pos[1]}").kind_of? Piece) && (board.fetch("#{pos[0]}, #{pos[1]}").colour != turn)
					possibilities << [pos[0], pos[1]]
				end
			end
		end

		possibilities
	end

	def rbq_moves(piece, move)
		x = piece[0]
		y = piece[1]
		possibilities = Array.new
		selected = board.fetch("#{x}, #{y}")
		selected.options.each do |arr|
			print arr
			puts ""
			puts ""
			pos = []
			spot = nil
			pos[0] = piece[0]
			pos[1] = piece[1]
			pos[0] += arr[0]
			pos[1] += arr[1]
			until (pos.any? {|value| value < 1}) || (pos.any? {|value| value > 8}) || (spot.kind_of? Piece)
				spot = board.fetch("#{pos[0]}, #{pos[1]}")
				if (spot.instance_of? Pieces::Space) || (spot.colour != turn)
					possibilities << [pos[0], pos[1]]
					puts "#{pos[0]}, #{pos[1]}"
				end
				pos[0] += arr[0]
				pos[1] += arr[1]
			end
		end
		puts ""
		puts move.join(", ")
		puts possibilities.join(", ")
		possibilities	
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