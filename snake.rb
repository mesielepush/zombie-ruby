require 'ruby2d'

set background: 'navy'
set fps_cap: 10
GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE
class Snake
  attr_writer :direction
  attr_accessor :head
  def initialize
    @positions = [[2,0],[2,1],[2,2],[2,3]]
    @direction = 'down'
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE-1, color: 'white')
    end
  end

  def move
    @positions.shift
    case @direction
    when 'down'
      @positions.push(rim(head[0],head[1]+1))
    when 'up'
      @positions.push(rim(head[0],head[1]-1))
    when 'left'
      @positions.push(rim(head[0]-1,head[1]))
    when 'right'
      @positions.push(rim(head[0]+1,head[1]))
    end
  end

  def could_i?(where)
    case @direction
    when 'up'
      true unless where == 'down'
    when 'down'
      true unless where == 'up'
    when 'left'
      true unless where == 'right'
    when 'right'
      true unless where == 'left'
    end
  end

  def rim(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end

end

class Game
  def initialize
    @score = 0
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end

  def draw
    Square.new(x: @ball_x * GRID_SIZE, y: @ball_y * GRID_SIZE, size: GRID_SIZE, color: 'red')
    Text.new("Score: #{@score}", color: 'white', x: 10, y: 10, size:25)
  end

  def is_hit?(x_hit,y_hit)
    @ball_x == x_hit and @ball_y == y_hit
  end
  def record_hit
    @score += 1
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end

end


snake = Snake.new
game = Game.new
update do
  clear
  snake.move
  snake.draw
  game.draw
  if game.is_hit?(snake.head[0],snake.head[1])
    game.record_hit
  end
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.could_i?(event.key)
      snake.direction = event.key
    end
  end
end
show