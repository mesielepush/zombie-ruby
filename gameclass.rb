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
    @turn = ['player']
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
  
  def is_my_turn?
    true if @turn.last == 'player'
  end
  
  def is_his_turn?
    true if @turn.last == 'computer'
  end

  def place_play(coord)
    if Gosu::button_down? @key[:m_left] and is_my_turn?
      @sounds[:choose].play(volume = 0.3)
      @board[coord] = [true,@square_coord[coord][0].first,@square_coord[coord][1].first] unless @board[coord][0] == 'o'
      @turn.push('computer')
    elsif Gosu::button_down? @key[:m_right] and is_his_turn?
      @sounds[:comp_choose].play(volume = 0.3)
      @board[coord] = ['o',@square_coord[coord][0].first,@square_coord[coord][1].first] unless @board[coord][0] == true
      @turn.push('player')
    else
      @sounds[:empty_choose].play(volume = 0.3)
    end
  end

  def check_click
    @square_coord.each do |key,value|
      if value[0].include? mouse_x and value[1].include? mouse_y
        place_play(key)
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
      check_click
      
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
