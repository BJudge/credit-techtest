require './canvas.rb'

RSpec.describe 'Canvas Class' do
    # before {@new_canvas = Canvas.new()}
    
    it 'prints the canvas to the screen' do 
        new_canvas = Canvas.new()
        new_canvas.I(6, 5)
        result = new_canvas.S()
        expect(result).to match_array [["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"]]
    end
   
    it 'places W in specific location' do
        new_grid = Canvas.new()
        new_grid.I(6,5)
        new_grid.L(2,3, 'W')
        result = new_grid.S()
        # the below line is targeting indexes, whereas the I function is targeting human readbale rows and columns
        expect(result[2][1]).to eq('W')
    end
    it 'create a vertical line' do
        new_grid = Canvas.new()
        new_grid.I(6,5)
        new_grid.V(2,3,4,"W")
        result = new_grid.S()
        expect(result).to match_array [["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","W","O","O","O","O"],["O","W","O","O","O","O"],["O","O","O","O","O","O"]]
    end

    it 'create a horizontal line' do
        new_grid = Canvas.new()
        new_grid.I(6,5)
        new_grid.H(3,4,2,"Z")
        result = new_grid.S()
        expect(result).to match_array [["O","O","O","O","O","O"],["O","O","Z","Z","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"]]
    end

    it 'clears/resets the cavas back to all O\'s' do 
        new_grid = Canvas.new()
        new_grid.I(6,5)
        new_grid.H(3,4,2,"Z")
        new_grid.V(2,3,4,"W")
        new_grid.C()
        result = new_grid.S()
        expect(result).to match_array [["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"],["O","O","O","O","O","O"]]
    end

    it 'fills a region with I' do 
        new_grid = Canvas.new()
        new_grid.I(6,5)
        new_grid.F(3,3,"I")
        result = new_grid.S()
        expect(result).to match_array [["I","I","I","I","I","I"],["I","I","I","I","I","I"],["I","I","I","I","I","I"],["I","I","I","I","I","I"],["I","I","I","I","I","I"]]
    end

    it 'scales the canvas' do 
        new_grid = Canvas.new()
        new_grid.I(1,1)
        new_grid.L(1,1,"A")
        result = new_grid.W(200)
        expect(result).to match_array [["O","A"],["O","O"]]
    end
end