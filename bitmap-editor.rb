#!/usr/bin/ruby
require './canvas.rb'

new_canvas = Canvas.new()
while true do 
    input = gets.chomp
    list = input.split
    new_canvas.command_reader(list)
end
