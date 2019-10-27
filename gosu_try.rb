require 'gosu'

 class GameWindow < Gosu::Window
   def initialize(width=320, height=240, fullscreen=false)
     super
       self.caption = 'Hello'
        @message = Gosu::Image.from_text(
                              self, 'Hello, World!', Gosu.default_font_name, 30)
   end

  def draw
    @message.draw(100, 10, 10)
  end
 end

 window = GameWindow.new
 window.show
