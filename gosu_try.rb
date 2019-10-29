require 'gosu'
require_relative 'assets_loader'
require_relative 'eye_candy'

################################### CLASSES ################################

################################### GAME MAIN ################################

class GameWindow < Gosu::Window
  attr_writer :bestes_y, :title_y , :gaming, :board
  def initialize
    super 700, 700
    @player = Eye_candy.new 0, 360
    
    @key , @board = load_metadata
    @xs, @os, img = load_audiovisual

    @background  = img[:background]
    @title       = img[:title]
    @bestes      = img[:bestes]
    @back_board  = img[:back_board]
    @cursor      = img[:cursor]
    @cursor_down = img[:cursor_down]

    @intro_1      = Gosu::Song.new('intro_1.mp3')
    @intro      = Gosu::Song.new('intro.mp3')
    @enter = Gosu::Sample.new('enter_game.mp3')
    @empty_choose = Gosu::Sample.new('choose.mp3')
    @choose = Gosu::Sample.new('coin.mp3')
    @comp_choose = Gosu::Sample.new('comp_choose.mp3')

    @intro_1.volume = 0.3
    @intro_1.play(true)
    @intro.volume = 0.2
    
    @title_y = 0
    @bestes_x = 700
    @gaming = false
    
  end
  
  def draw_board
    
    @board.each do |coord|
      #puts 'coord[0]: ' + coord[1][0].to_s
      #puts 'coord[1]: ' + coord[1][1].to_s
      #puts 'coord[2]: ' + coord[1][2].to_s
      if coord[1][0] == true
        @xs[rand(0..2)].draw(coord[1][1], coord[1][2], 10)
      end
      if coord[1][0] == 'o'
        @os[rand(0..2)].draw(coord[1][1], coord[1][2], 10)
      end
    end
  end

  def user_click
    case mouse_x
    when 208..350
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:a1] = [true,208,117] unless @board[:a1][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:b1] = [true,208,280] unless @board[:b1][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:c1] = [true,208,431] unless @board[:c1][0] == 'o'
        end
      end
      
    when 378..540
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:a2] = [true,378,117] unless @board[:a2][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:b2] = [true,378,280] unless @board[:b2][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:c2] = [true,378,431] unless @board[:c2][0] == 'o'
        end
      end
    when 561..699
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:a3] = [true,561,117] unless @board[:a3][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:b3] = [true,561,280] unless @board[:b3][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @choose.play(volume = 0.3)
          @board[:c3] = [true,561,431] unless @board[:c3][0] == 'o'
        end
      end
    else
      if Gosu::button_down? @key[:m_left]
        @empty_choose.play(volume = 0.3)
      end
    end
    
  end
  def comp_click
    case mouse_x
    when 208..350
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:a1] = ['o',208,117] unless @board[:a1][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:b1] = ['o',208,280] unless @board[:b1][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:c1] = ['o',208,431] unless @board[:c1][0] == true
        end
      end
      
    when 378..540
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:a2] = ['o',378,117] unless @board[:a2][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:b2] = ['o',378,280] unless @board[:b2][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:c2] = ['o',378,431] unless @board[:c2][0] == true
        end
      end
    when 561..699
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:a3] = ['o',561,117] unless @board[:a3][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:b3] = ['o',561,280] unless @board[:b3][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @comp_choose.play(volume = 0.3)
          @board[:c3] = ['o',561,431] unless @board[:c3][0] == true
        end
      end
    else
      if Gosu::button_down? @key[:m_right]
        @empty_choose.play(volume = 0.3)
      end
    end
  end

  def update
    if @gaming == false
      
      if Gosu::button_down? @key[:kb_left] or Gosu::button_down? @key[:gp_left] then
        @player.move :left
      end
      if Gosu::button_down? @key[:kb_right] or Gosu::button_down? @key[:gp_right] then
        @player.move :right
      end
      if Gosu::button_down? @key[:space]
        @enter.play
        @gaming = true
      end
      @title_y += 2
      if @title_y > 70
        @title_y = 70
      end
      @bestes_x -= 5
      if @bestes_x < -400
        @bestes_x = 700
      end
    end

    if @gaming == true
      
      puts 'x: ' + self.mouse_x.to_s
      puts 'y: ' +self.mouse_y.to_s
      
      @intro.play(true)
      user_click
      comp_click
      
    end
  end

  def draw
    if @gaming == false
      
      @background.draw(0, 0, 0)
      @title.draw(50, @title_y, 1)
      @bestes.draw( @bestes_x,250, 1)
      @player.draw
    end
    if @gaming == true
      @back_board.draw(0, 0, 0)
      @intro_1.stop
      draw_board
      if Gosu::button_down? @key[:m_left]
        @cursor_down.draw self.mouse_x, self.mouse_y, 0
        

      elsif Gosu::button_down? @key[:m_right]
        @cursor_down.draw self.mouse_x, self.mouse_y, 0
        
      else
        @cursor.draw self.mouse_x, self.mouse_y, 0

      end
      

      #puts 'x : '+self.mouse_x().to_s
      #puts 'y : '+self.mouse_y().to_s
    end
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
