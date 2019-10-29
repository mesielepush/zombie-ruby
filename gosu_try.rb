require 'gosu'
require_relative 'assets_loader'
require_relative 'eye_candy'


class GameWindow < Gosu::Window
  attr_writer :bestes_y, :title_y , :gaming, :board
  def initialize
    super 700, 700
    @mario = Eye_candy.new 0, 360
    @key, @board, @square_coord = load_metadata
    @xs, @os, @img, @sounds = load_audiovisual
    #sound_console    
    @sounds[:intro_cover].volume = 0.3
    @sounds[:intro_cover].play(true)
    @sounds[:intro].volume = 0.2
    #Cover Initial parameters
    @title_y = 0
    @bestes_x = 700
    @gaming = false
    
  end
  
  def draw_board
    @board.each do |coord|
      if coord[1][0] == true
        @xs[rand(0..2)].draw(coord[1][1], coord[1][2], 10)
      end
      if coord[1][0] == 'o'
        @os[rand(0..2)].draw(coord[1][1], coord[1][2], 10)
      end
    end
  end

  def user_click

    def place_play(coord)
      if Gosu::button_down? @key[:m_left]
        @sounds[:choose].play(volume = 0.3)
        @board[coord] = [true,208,117] unless @board[coord][0] == 'o'
      end
    end
    
    case mouse_x
    
    when 208..350
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:a1] = [true,208,117] unless @board[:a1][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:b1] = [true,208,280] unless @board[:b1][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:c1] = [true,208,431] unless @board[:c1][0] == 'o'
        end
      end
      
    when 378..540
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:a2] = [true,378,117] unless @board[:a2][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:b2] = [true,378,280] unless @board[:b2][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:c2] = [true,378,431] unless @board[:c2][0] == 'o'
        end
      end
    when 561..699
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:a3] = [true,561,117] unless @board[:a3][0] == 'o'
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:b3] = [true,561,280] unless @board[:b3][0] == 'o'
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_left]
          @sounds[:choose].play(volume = 0.3)
          @board[:c3] = [true,561,431] unless @board[:c3][0] == 'o'
        end
      end
    else
      if Gosu::button_down? @key[:m_left]
        @sounds[:empty_choose].play(volume = 0.3)
      end
    end
    
  end
  def comp_click
    case mouse_x
    when 208..350
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:a1] = ['o',208,117] unless @board[:a1][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:b1] = ['o',208,280] unless @board[:b1][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:c1] = ['o',208,431] unless @board[:c1][0] == true
        end
      end
      
    when 378..540
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:a2] = ['o',378,117] unless @board[:a2][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:b2] = ['o',378,280] unless @board[:b2][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:c2] = ['o',378,431] unless @board[:c2][0] == true
        end
      end
    when 561..699
      if mouse_y > 117 and mouse_y <  275
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:a3] = ['o',561,117] unless @board[:a3][0] == true
        end
      end
      if mouse_y > 280 and mouse_y < 421
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:b3] = ['o',561,280] unless @board[:b3][0] == true
        end
      end
      if mouse_y > 431 and mouse_y < 575
        if Gosu::button_down? @key[:m_right]
          @sounds[:comp_choose].play(volume = 0.3)
          @board[:c3] = ['o',561,431] unless @board[:c3][0] == true
        end
      end
    else
      if Gosu::button_down? @key[:m_right]
        @sounds[:empty_choose].play(volume = 0.3)
      end
    end
  end

  def update
    if @gaming == false
      
      if Gosu::button_down? @key[:kb_left] or Gosu::button_down? @key[:gp_left] then
        @mario.move :left
      end
      if Gosu::button_down? @key[:kb_right] or Gosu::button_down? @key[:gp_right] then
        @mario.move :right
      end
      if Gosu::button_down? @key[:space]
        @sounds[:enter].play
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
      
      @sounds[:intro].play(true)
      user_click
      comp_click
      
    end
  end

  def draw
    if @gaming == false
      
      @img[:background].draw(0, 0, 0)
      @img[:title].draw(50, @title_y, 1)
      @img[:bestes].draw( @bestes_x,250, 1)
      @mario.draw
    end
    if @gaming == true
      @img[:back_board].draw(0, 0, 0)
      @sounds[:intro_cover].stop
      draw_board
      if Gosu::button_down? @key[:m_left]
        @img[:cursor_down].draw self.mouse_x, self.mouse_y, 0
        

      elsif Gosu::button_down? @key[:m_right]
        @img[:cursor_down].draw self.mouse_x, self.mouse_y, 0
        
      else
        @img[:cursor].draw self.mouse_x, self.mouse_y, 0

      end
      

      #puts 'x : '+self.mouse_x().to_s
      #puts 'y : '+self.mouse_y().to_s
    end
  end

  def button_up(id)
    if id == @key[:kb_left] or id == @key[:gp_left] then
      @mario.stop_move
      
    end
    if id == @key[:kb_right] or id == @key[:gp_right] then
      @mario.stop_move
    end
  end
end

GameWindow.new.show
