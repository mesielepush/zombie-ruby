require 'ruby2d'

set background: 'green'

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

    square = Square.new(
                        x: 100, y: 200,
                        size: 125,
                        color: 'purple'
                      )
    game_started = true
  end
end
show