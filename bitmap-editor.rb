require 'enumerator'
# exit the program
# how does the user input their commands - https://stackoverflow.com/questions/9853853/creating-interactive-ruby-console-application
#should these be class methods or instance methods 

class Canvas
    def I (m, n)
        # @canvas = Array.new(m) { Array.new(n , "O")}
        @canvas= m.times.map { Array.new(n, "O")}
    end

    def S  
        @canvas.each do |el| puts el.join().tr('"', '') end
    end

    def L(x,y,colour)
        if (y > @canvas.length)
          return  puts "Not enough rows"
        end
        if (x > @canvas[0].length)
            return  puts "Not enough columns"
          end
        @canvas[y-1][x-1] = colour
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
            puts "Not Enough Columns"
        else
            row_range.select { |element|
                @canvas[y-1][element-1] = colour
            }
        end
    end

    def W(f)
        # a 3x3 canvas scaled by 250% would result in a 7.5 X 7.5 canvas - this is not possible so scalling rounds up (ceil)
        multiple = (f/100.0)
        new_x = (@canvas.length * multiple).ceil()
        new_y = (@canvas[0].length * multiple).ceil()
       
        
    end

    def F(x, y, c)
        # Conways Game of Life?
        # 
        colour = find_colour([x,y])
        region = find_region([[x,y]], [[x,y]], colour)
        p region
        region.each { |el|
            x = el[0]
            y = el[1]
            puts "from function F x#{x}: y#{y}" 
            L(x,y,c)
        }

    end

    def C()
        @canvas.each do |el| 
            el.fill("O")
        end
    end
    def manual()
        puts "Hello from ?"
    end
    

    def X()
        exit
    end

    # private 
     def find_region(new_additions, r, z)
        if (new_additions.length == 0) 
            return r
        else
            neighbours_added = []
            new_additions.each { |el|
                candidates = find_neighbours(el)
                candidates.each { |candidate|
                    if (!r.include?(candidate))
                        if(z == find_colour(candidate))
                            r.push(candidate)
                            neighbours_added.push(candidate)
                        end
                    end
                }
            }
            return find_region(neighbours_added, r, z)
        end

     end

     def find_neighbours(coordinates)
            # coordinates is an arry of two elements 
            x = coordinates[0]
            y = coordinates[1]

            return [[x+1, y],[x-1,y],[x,y+1],[x, y-1]]
     end

     def find_colour(coordinates)
        x = coordinates[0]
        y = coordinates[1]
        return @canvas[y-1][x-1]
     end

end




















new_canvas = Canvas.new()
new_canvas.I(10,10)
new_canvas.L(5, 5,"W")
new_canvas.L(5, 6,"W")

# new_canvas.V(3,2,8,"B")
# new_canvas.H(1,4,3,"W")
new_canvas.S()
new_canvas.F(5,5,"G")
puts ""
new_canvas.S()
p new_canvas.find_region([[5,5]],[[5,5]], "W")
# new_canvas.W(350)
# new_canvas.?()
# p ARGV # this takes the arguments and puts them into an array.
# argument = gets.chomp
# array_argument = argument.to_a
# puts array_argument