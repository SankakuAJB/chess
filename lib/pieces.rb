module Pieces

	class Piece

		attr_accessor :x, :y
		attr_reader :symbol, :colour

		def initialize(colour, x, y, symbol)
			@colour = colour
			@x, @y = x, y
		end

	end

	class Pawn < Piece

		attr_accessor :first_move

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@first_move = true
			@symbol = symbol
		end

		def possible_moves(arr)
			x = arr[0]
			y = arr[1]
				
			if self.colour == "white"
				if @first_move == true 
					possibilities = [ [x, y+1], [x, y+2] ]
				else
					possibilities = [x, y+1]
				end 
			end

			if self.colour == "black"
				if @first_move == true 
					possibilities = [ [x, y-1], [x, y-2] ]
				else
					possibilities = [x, y-1]
				end 
			end
			
			return possibilities
		end

	end

	class Rook < Piece

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@first_move = true
			@symbol = symbol
		end

		def possible_moves(arr)
			x = arr[0]
			y = arr[1]
			options = [ [1, 0], [0, 1] ]
			possiblities = []

			options.each do |opt|
				position = arr
				until position.any? {|value| value <1} || position.any? {|value| value >8} || board["#{position[0]}, #{position[1]}"].instance_of? Piece 

				end

			end

		end

	end

	class Knight < Piece

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@symbol = symbol
		end
		
		def possible_moves(arr)
			x = arr[0]
			y = arr[1]

		end

	end

	class Bishop < Piece

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@symbol = symbol
		end
		
		def possible_moves(arr)
			x = arr[0]
			y = arr[1]

		end

	end

	class Queen < Piece

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@symbol = symbol
		end
		
		def possible_moves(arr)
			x = arr[0]
			y = arr[1]

		end

	end

	class King < Piece

		def initialize(colour, x, y, symbol)
			super(colour, x, y, symbol)
			@first_move = true
			@symbol = symbol
		end
		
		def possible_moves(arr)
			x = arr[0]
			y = arr[1]

		end

	end

	class Space
		attr_reader :symbol

		def initialize
			@symbol = "  "
		end

	end

end