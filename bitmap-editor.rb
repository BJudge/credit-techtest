#!/usr/bin/ruby
# how does the user input their commands - https://stackoverflow.com/questions/9853853/creating-interactive-ruby-console-application
 

class Canvas
    def I (m, n)
        # @canvas = Array.new(m) { Array.new(n , "O")}
        @canvas = new_grid(m,n)
        @number_of_rows = m 
        @number_of_columns = n 
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

    def W(factor)
        # a 3x3 canvas scaled by 250% would result in a 7.5 X 7.5 canvas - this is not possible so scalling rounds down (floor)
        multiple = (factor/100.0)
        new_rows_length = (@number_of_rows * multiple).floor
        new_columns_length = (@number_of_columns * multiple).floor
        diff_columns = (new_columns_length - @number_of_columns).abs
        diff_rows = (new_rows_length - @number_of_rows).abs
        if (factor == 100)
            p @canvas
        end
        if (factor > 100)
            new_canvas = []
            @canvas.each {|row|
                new_row = row.clone
                diff_columns.times {|i| new_row.unshift("O")} 
                new_canvas.push(new_row)
            }
            diff_rows.times{|i| new_canvas.push(Array.new(new_columns_length, "O"))} 
            puts new_canvas
        end
        if (factor < 100)
            new_canvas = []
            @canvas.each {|row|
                new_row = row.clone
                diff_columns.times {|i| new_row.shift()} 
                new_canvas.push(new_row)
            }
            diff_rows.times{|i| new_canvas.shift()} 
            puts new_canvas
        end
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
        puts "
        I M N       - Create a new M x N canvas with all pixels coloured white
        C           - Clears canvas 
        L X Y C     - Colours the pixel (X,Y) with colour C
        V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)
        H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)
        F X Y C     - Fill the region (X,Y) with the colour C
        W F         - Scales the canvas with the given factor F
        S           - Show the contents of the current canvas
        X           - Terminate the session
        ?           - Shows in program help"
    end
    

    def X()
        exit
    end

    private 

    def new_grid(m,n)
        m.times.map { Array.new(n, "O")}
    end

    def coord_validation()
        # do coordinate checks for all functions that take in an x and a y 
    end

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
            # check to see if neighbours are outside the grid
            neighbours = []
            if (x-1 > 0)
                neighbours.push([x-1,y])
            end
            if (x+1 <= @number_of_columns)
                neighbours.push([x+1,y])
            end
            if(y-1 > 0)
                neighbours.push([x,y-1])
            end
            if(y+1 <= @number_of_rows)
                neighbours.push([x,y+1])
            end

            return neighbours
    end

     def find_colour(coordinates)
        x = coordinates[0]
        y = coordinates[1]
        return @canvas[y-1][x-1]
     end

end



new_canvas = Canvas.new()
new_canvas.I(3,2)
new_canvas.manual()


