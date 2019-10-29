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
      @frames = Gosu::Image.load_tiles 'mario.png', 69, 211
      @x, @y = x, y
      @move = {:left => Animation.new(@frames[1..-1], 0.05),
               :right => Animation.new(@frames[1..-1], 0.05)}
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
      @x %= 710
      
      @facing = direction
      @moving = true if @moving != true
    end
  
    def stop_move
      @moving = false if @moving != false
    end
  end
  