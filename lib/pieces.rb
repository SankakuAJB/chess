module Pieces

	class Piece
		attr_accessor :first_move
		attr_reader :symbol, :colour, :options

		def initialize(colour, symbol)
			@colour = colour
		end

	end

	class Pawn < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = true
			@symbol = symbol
		end

	end

	class Rook < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = true
			@symbol = symbol
			@options = [ [0, 1], [1, 0], [-1, 0], [0, -1] ]
		end

	end

	class Knight < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = false
			@symbol = symbol
			@options = [ [2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2] ]
		end

	end

	class Bishop < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = false
			@symbol = symbol
			@options = [ [1, 1], [1, -1], [-1, -1], [-1, 1] ]
		end
		
	end

	class Queen < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = false
			@symbol = symbol
			@options = [ [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1] ]
		end
		
	end

	class King < Piece

		def initialize(colour, symbol)
			super(colour, symbol)
			@first_move = true
			@symbol = symbol
			@options = [ [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1] ]
		end

	end

	class Space
		attr_reader :symbol, :colour

		def initialize
			@symbol = "  "
			@colour = "none"
		end

	end

end