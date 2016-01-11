class Pieces

	attr_accessor :x, :y
	attr_reader :symbol

	def initialize(colour, x, y, symbol)
		@colour = colour
		@x, @y = x, y
	end

end

class Pawn < Pieces

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
		
	end


end

class Rook < Pieces

	def initialize(colour, x, y, symbol)
		super(colour, x, y, symbol)
		@first_move = true
		@symbol = symbol
	end

end

class Knight < Pieces

	def initialize(colour, x, y, symbol)
		super(colour, x, y, symbol)
		@symbol = symbol
	end
	
end

class Bishop < Pieces

	def initialize(colour, x, y, symbol)
		super(colour, x, y, symbol)
		@symbol = symbol
	end
	
end

class Queen < Pieces

	def initialize(colour, x, y, symbol)
		super(colour, x, y, symbol)
		@symbol = symbol
	end
	
end

class King < Pieces

	def initialize(colour, x, y, symbol)
		super(colour, x, y, symbol)
		@first_move = true
		@symbol = symbol
	end
	
end

class Space
	attr_accessor :x, :y
	attr_reader :symbol

	def initialize(x, y)
		@x = x
		@y = y
		@symbol = "  "
	end

end
