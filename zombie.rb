require 'ruby2d'
set ({title: 'Tic-Tac-Toe',
    background: 'back.png',
    width: 700,
    height: 700 })
o_sprite = Sprite.new(
                      'o.png',
                      x: 215,
                      y: 350,
                      clip_width:100,
                      time:100,
                      loop: true)
x_sprite = Sprite.new(
                        'x.png',
                        x: 405,
                        y: 350,
                        clip_width:100,
                        time:100,
                        loop: true)
o_sprite.play
x_sprite.play
title = Image.new('title.png',x:47,y:150)

message = Text.new('Click to begin',
                    x: 250, y: 600,
                    width:600,
                    size:40,
                    color: 'white')
game_started = false
square = nil


on :mouse_down do |event|
  puts event.x, event.y
  if game_started
    title = nil
    if square.contains?(event.x, event.y)
      puts 'Click on square'
    end
    
  else
    message.remove

    table = Image.new("background.png", x:35, y: 35)
    a1 = Square.new(
      x: 97, y: 100,
      size: 150,
      color: 'blue',
      z: 10)
    a2 = Square.new(
      x: 274, y: 100,
      size: 150,
      color: 'blue',
      z: 10)
    a3 = Square.new(
      x: 459, y: 100,
      size: 150,
      color: 'blue',
      z: 10)
    b1 = Square.new(
      x: 97, y: 200,
      size: 150,
      color: 'red',
      z: 10)
    b2 = Square.new(
      x: 274, y: 200,
      size: 150,
      color: 'red',
      z: 10)
    b3 = Square.new(
      x: 459, y: 200,
      size: 150,
      color: 'red',
      z: 10)
    c1 = Square.new(
      x: 97, y: 300,
      size: 150,
      color: 'green',
      z: 10)
    c2 = Square.new(
      x: 274, y: 300,
      size: 150,
      color: 'green',
      z: 10)
    c3 = Square.new(
      x: 497, y: 300,
      size: 150,
      color: 'green',
      z: 10)
    game_started = true
  end
end
show