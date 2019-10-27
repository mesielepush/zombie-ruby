require 'ruby2d'

grid = 700
set ({title: 'Tic-Tac-Toe',
    width: grid,
    height: grid,
    fps_cap: 60 })

coin = Sprite.new(
  'coin.png',
  clip_width: 100,
  time: 100,
  x:0,
  y:0,
  z:1,
  loop: true
)
coin.play

update do
  puts 'popo'
   
end

show