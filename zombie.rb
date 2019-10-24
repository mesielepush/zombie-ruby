require 'ruby2d'
set title: 'Tic-Tac-Toe'
set background: 'navy'
Image.new("home.jpg")

message = Text.new('Click to begin')
game_started = false
square = nil


on :mouse_down do |event|
  puts event.x, event.y
  if game_started
    if square.contains?(event.x, event.y)
      puts 'Click on square'
    end
    
  else
    message.remove

    square = Image.new("circle.jpg")
    game_started = true
  end
end
show