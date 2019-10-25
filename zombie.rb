require 'ruby2d'
set ({title: 'Tic-Tac-Toe',
    width: 700,
    height: 700,
    fps_cap: 60 })

class Title
  def initialize
    @ranges = 0
  end
  def draw
    title = Image.new('title.png',x:47,y:@ranges)
  end
  def move
    @ranges +=2
    if @ranges > 230
      @ranges = 230
    end
  end

end

title = Title.new


update do
  clear
  back = Image.new('back.png')
  message = Image.new('begin.png',x: 225, y: 525)
  
  square = nil
  title.move
  title.draw
end
game_started = false

on :mouse_down do |event|
  puts event.x, event.y
  if game_started
    title = nil
    if a1.contains?(event.x, event.y)
      puts 'Click on square'
    end
      
  else
    table = Image.new("background.png", x:35, y: 35)
    o_sprite = Sprite.new(
                      'o.png',
                      x: 115,
                      y: 470,
                      z: 5,
                      clip_width:100,
                      time:120,
                      loop: true)
    x_sprite = Sprite.new(
                        'x.png',
                        x: 505,
                        y: 470,
                        z: 5,
                        clip_width:100,
                        time:120,
                        loop: true)
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
      x: 97, y: 250,
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
      x: 459, y: 300,
      size: 150,
      color: 'green',
      z: 10)
    game_started = true
  end
end
show