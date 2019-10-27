require 'ruby2d'
set ({title: 'Tic-Tac-Toe',
    width: 700,
    height: 700,
    fps_cap: 60 })

intro = Music.new('intro.mp3')

class Title
  attr_accessor :title, :best
  def initialize
    @title_one = 0
    @bestes = 1000
  end
  def draw
    @title = Image.new('title.png',x:47,y:@title_one)
    @best = Image.new('bestes.png',x:15,y:@bestes)
    @back = Image.new('back.png',z:-1,width: 700,height: 700,)
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
game_started = false

title = Title.new
intro.volume = 10
intro.play
update do
  clear
  
  square = nil
  title.move
  title.draw
  if game_started
    title.remove
  end
end


on :mouse_down do |event|
  puts event.x, event.y
  if game_started
    title = nil
    if a1.contains?(event.x, event.y)
      puts 'Click on square'
    end
      
  else
    table = Image.new("background.png", x:35, y: 35)
    
    game_started = true
  end
end
show
