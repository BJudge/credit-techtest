require 'enumerator'
# exit the program
# colour individual cell - L method
# how does the user input their commands - https://stackoverflow.com/questions/9853853/creating-interactive-ruby-console-application
#should these be class methods or instance methods 
# minus 1 for all coordinated in order to find correct index

class Canvas
    def I (m, n)
        # @canvas = Array.new(m) { Array.new(n , "O")}
        @canvas= m.times.map { Array.new(n, "O")}
    end
    def S  
        @canvas.each do |el| puts el.join().tr('"', '') end
    end

    def L(x,y,colour)
        @canvas[x-1][y-1] = colour
    end

    def V(x, y1, y2, colour)
        column_range = (y1..y2)
        if (y2-1 > @canvas.length) 
            puts "Not Enough Columns"
        else
            column_range.select { |element|
                @canvas[element-1][x-1] = colour
            }
        end
    end

    def H(x1, x2, y, colour)
        row_range = (x1..x2)
        if (x2-1 > @canvas[0].length)
            puts "Not Enough Rows"
        else
            row_range.select { |element|
                @canvas[y-1][element-1] = colour
            }
        end
    end

    def W(f)
        multiple = (f/100.0)
        
    end

    def C()
        @canvas.each do |el| 
            el.fill("O")
        end
    end
    def ?()
    end

    def X()
        exit
    end

end

new_canvas = Canvas.new()
new_canvas.I(2,2)
# new_canvas.V(2,2,4,"B")
# new_canvas.H(1,4,3,"Q")
new_canvas.W(350)
new_canvas.S()

# p ARGV # this takes the arguments and puts them into an array.
