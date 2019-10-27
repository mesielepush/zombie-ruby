require 'gosu'
################################### CLASSES ################################
class Animation
  def initialize(frames, time_in_secs)
    @frames = frames
    @time = time_in_secs * 1000    
  end

  def start
    @frames[Gosu::milliseconds / @time % @frames.size]
  end

  def stop
    @frames[0]
  end
end

class Eye_candy
  def initialize(x, y)
    @frames = Gosu::Image.load_tiles 'mario2.png', 46, 143
    @x, @y = x, y
    @move = {:left => Animation.new(@frames, 0.05),
             :right => Animation.new(@frames, 0.05)}
    @movements = {:left => -2.0, :right => 2.0}
    @moving = false
    @facing = :left
  end

  def draw
    if @moving
      @move[@facing].start.draw @x, @y, 1
    else
      @move[@facing].stop.draw @x, @y, 1
    end
  end

  def move(direction)
    @x += @movements[direction]
    @x %= 640
    
    @facing = direction
    @moving = true if @moving != true
  end

  def stop_move
    @moving = false if @moving != false
  end
end

################################### GAME MAIN ################################

class GameWindow < Gosu::Window
  attr_writer :bestes_y, :title_y
  def initialize
    super 700, 700
    @player = Eye_candy.new 0, 440

    @key = {kb_left: Gosu::KbLeft,
            kb_right: Gosu::KbRight,
            gp_left: Gosu::GpLeft,
            gp_right: Gosu::GpRight,
            enter: Gosu::KB_RETURN
            }
    @background = Gosu::Image.new("back.png")
    @title = Gosu::Image.new("title.png")
    @bestes = Gosu::Image.new("bestes.png")
    @title_y = 0
    @bestes_x = 700
  end

  def update
    if Gosu::button_down? @key[:kb_left] or Gosu::button_down? @key[:gp_left] then
      @player.move :left
    end
    if Gosu::button_down? @key[:kb_right] or Gosu::button_down? @key[:gp_right] then
      @player.move :right
    end
    puts Gosu::button_down? @key[:enter]
    @title_y += 2
    if @title_y > 70
      @title_y = 70
    end
    @bestes_x -= 5
    if @bestes_x < -400
      @bestes_x = 700
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @title.draw(50, @title_y, 1)
    @bestes.draw( @bestes_x,250, 1)
    @player.draw

  end

  def button_up(id)
    if id == @key[:kb_left] or id == @key[:gp_left] then
      @player.stop_move
    end
    if id == @key[:kb_right] or id == @key[:gp_right] then
      @player.stop_move
    end
  end
end

GameWindow.new.show
