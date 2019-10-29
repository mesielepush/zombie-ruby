require 'ruby2d'
grid = 700
set ({title: 'Tic-Tac-Toe',
    width: grid,
    height: grid,
    fps_cap: 60 })

intro = Music.new('intro.mp3')

class Title
  attr_accessor :title, :best, :run, :eye_candy
  attr_writer :run
  def initialize
    @title_one = 0
    @bestes = 1000
    @run = 100
    @eye_candy = Sprite.new(
                        'mario.png',
                        clip_width: 46,
                        time: 50,
                        height: 300,
                        width: 100,
                        x: @run,
                        y:200,
                        z:1,
                        loop: true
                      )
    
    
  end
  def draw
    @back = Image.new('back.png',z:0,width: 700,height: 700)
    @title = Image.new('title.png',x:47,y:@title_one)
    @best = Image.new('bestes.png',x:15,y:@bestes)
    
  end

  def remove
    @title.remove
    @best.remove
    @back.remove
  end

  def move
    @title_one +=2
    
    if @title_one > 57
      @title_one = 57
    end
    @bestes -= 2
    if @bestes < 400
      @bestes = 400
    end
    
  end

end

class Board
  def initialize
    @back_wood = Image.new('background.png',x: 30, y:30)
    @board = Image.new('back_wood.png',z:-1)
  end

  def draw
    @back_wood.draw
    @board.draw
  end
end

game_started = false
title = Title.new
game = Board.new
intro.volume = 10
intro.play


update do
  title.eye_candy.play
  title.run += 10
  title.move
  title.draw
  
  if game_started
    title.remove
    game.draw

  end
end


on :mouse_down do |event|
  puts event.x, event.y
  if game_started
    table = Image.new("back1.png", x:35, y: 35)
  else
    game_started = true
  end
end

show
