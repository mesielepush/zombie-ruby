require 'gosu'
require_relative 'assets_loader'
require_relative 'eye_candy'


class GameWindow < Gosu::Window
  attr_writer :bestes_y, :title_y , :gaming, :board, :main, :end_game_screen
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
    @main = false
    @end_game_screen = false
    @turn = ['player']
    @win = false
    @winner = nil
    @winning_screen_alpha = 0.0 
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

  def who_won?
    result = winning_combo(@board)
    @winner, @combo = result[0], result[1]
    return @winner, @combo
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
      if Gosu::button_down? @key[:m_right] || @key[:m_left]
        @sounds[:empty_choose].play(volume = 0.3)
      end
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
        @main = true
        @gaming = nil
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

    if @main == true
      @sounds[:intro].play(true)
      check_click
      @win = who_won?
      if @win[0] != false
        @end_game_screen = true 
        @main = false
      end
    end

    if @end_game_screen == true
      @sounds[:win].play(false)
      @sounds[:intro].stop
      
    end 
  end

  def draw
    if @gaming == false
      @img[:background].draw(0, 0, 0)
      @img[:title].draw(50, @title_y, 1)
      @img[:bestes].draw( @bestes_x,250, 1)
      @mario.draw
    end
    if @main
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
    if @end_game_screen
      
      @img[:back_board].draw(0, 0, 0)
      @winning_screen_alpha += 5
      puts @winning_screen_alpha
      if @winning_screen_alpha > 500
        @winning_screen_alpha = 500
      end
      draw_quad(0,0, Gosu::Color.rgba(0,0,0,@winning_screen_alpha), 700, 0,
                Gosu::Color.rgba(0,0,0,@winning_screen_alpha),
                0, 700, Gosu::Color.rgba(0,0,0,@winning_screen_alpha),
                700,700, Gosu::Color.rgba(0,0,0,@winning_screen_alpha), 0)
      @img[:vertical_o].draw(395, 130, 0)
      
      
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
