require 'gosu'

class GameWindow < Gosu::Window
  def initialize(width=320, height=240, fullscreen=false)
    super
    self.caption = 'Hello Movement'
    @x = @y = 10
    @draws = 0
    @buttons_down = 0
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @x -= 1 if button_down?(Gosu::KbLeft)
    @x += 1 if button_down?(Gosu::KbRight)
    @y -= 1 if button_down?(Gosu::KbUp)
    @y += 1 if button_down?(Gosu::KbDown)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

  def button_up(id)
    @buttons_down -= 1
  end

  def needs_redraw?
    @draws == 0 || @buttons_down > 0
  end

  def draw
    @draws += 1
    

    @font.draw_text(info, @x, @y, 1, 1.0, 1.0, Gosu::Color::WHITE)

    
  end

  private

  def info
    "[x:#{@x};y:#{@y};draws:#{@draws}]"
  end
end

window = GameWindow.new
window.show