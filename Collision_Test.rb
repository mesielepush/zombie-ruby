require 'gosu'
include Gosu

class GameWindow < Gosu::Window
  attr_reader :objects,:colliders
  def initialize
    super(1024, 768, false)
    self.caption = "Collision Test"
    Gosu::enable_undocumented_retrofication #circles are not blurry
    
    $ball=Image.new(self,'Ball.png') #ball image for balls
    $window=self #making a global window reference for convenience
    
    @objects=[] #array for objects
    @objects << Ball.new(200,200,120,false)
    @objects << (@ball=Ball.new(500,600,40,false))
    @objects << Ball.new(400,200,80,true)
    @objects << Box.new(500,500,100,100,0,false)
    @objects << (@box=Box.new(800,500,70,150,0,false))
    @objects << Box.new(900,100,200,20,0,true)
    
    @time=0 #a counter
    
    puts '-'*16,"WSAD - Move ball
Up/Down/Left/Right - Move box
Space - Rotate box
    
Objects are red when colliding" #some help
  end

  def update
    @time+=1
    @objects.each{|obj| obj.update}
    
    @box.move(0,0,1) #one of boxes is rotating
    @ball.set(500+offset_x(@time,64)) #one of balls is moving
  end

  def draw
    @objects.each{|obj| obj.draw}
  end

  def button_down(id)
  end
end

class Ball #class for ball objects
  attr_reader :col
  def initialize(x,y,r,c)
    @x,@y,@r,@c=x,y,r,c
    @col=Collision_Ball.new(@x,@y,r)
  end
  
  def update
    if @c #if ball is controllable
      @x+=2 if $window.button_down?(KbD) #move object if key is pressed
      @x-=2 if $window.button_down?(KbA) #move object if key is pressed
      @y+=2 if $window.button_down?(KbS) #move object if key is pressed
      @y-=2 if $window.button_down?(KbW) #move object if key is pressed
      
      @col.set(@x,@y) #set position of collider ; it must be in the center of object
    end
  end
  
  def draw
    color=($window.objects.find{|obj| obj.col.collides?(@col)} ? 0xffff0000 : 0xffffffff) #object is red when colliding
    #to check collisions, we check if any of other colliders interests with the object's colider.
    scale=(@r/32.0) #scale image to collider radius
    $ball.draw_rot(@x,@y,1,0,0.5,0.5,scale,scale,color) #collision ball x,y should be in center of object
  end
  
  def set(x=@x,y=@y)
    @x=x
    @y=y
    @col.set(x,y)
  end
end

class Box #class for box objects
  attr_reader :col
  def initialize(x,y,w,h,a,c)
    @x,@y,@w,@h,@a,@c=x,y,w,h,a,c
    @col=Collision_Box.new(@x,@y,w,h,a) #attach a collider
  end
  
  def update
    if @c #if box is controllable
      @x+=2 if $window.button_down?(KbRight) #move object if key is pressed
      @x-=2 if $window.button_down?(KbLeft) #move object if key is pressed
      @y+=2 if $window.button_down?(KbDown) #move object if key is pressed
      @y-=2 if $window.button_down?(KbUp) #move object if key is pressed
      
      @col.set(@x,@y) #set position of collider ; it must be in the center of object
      @col.move(0,0,3) if $window.button_down?(KbSpace) #rotate when Space is pressed ; note that this method rotates the collider and box object is drawn using vectors of collider ; it's of course not required to draw your object from vectors
    end
  end
  
  def draw
    color=($window.objects.find{|obj| obj.col.collides?(@col)} ? 0xffff0000 : 0xffffffff) #object is red when colliding
    #to check collisions, we check if any of other colliders interests with the object's colider
    $window.draw_quad(@col.vectors[0].x,@col.vectors[0].y,color,@col.vectors[1].x,@col.vectors[1].y,color,@col.vectors[2].x,@col.vectors[2].y,color,@col.vectors[3].x,@col.vectors[3].y,color,1) #draw quad basing on vectors ; when using your own position, remember to place collison box x,y in the center
  end
  
  def move(x=0,y=0,a=0)
    @x+=x
    @y+=y
    @a-=a
    @col.move(x,y,a)
  end
end

#Below are collision classes. Don't even try to understand them

class Vector
  attr_reader :x,:y
  def initialize(x,y)
    @x,@y=x.to_f,y.to_f
  end
end

class Collision_Box
  attr_reader :x,:y,:w,:h,:a,:vectors
  def initialize(x,y,w,h,a)
    @x,@y,@w,@h,@a=x,y,w,h,a
    set_vectors
  end
    
  def collides?(col)
    return if col==self
    
    if col.class==Collision_Box
      4.times{|i|
        axis=Vector.new(@vectors[1].x-@vectors[0].x, @vectors[1].y-@vectors[0].y) if i==0
        axis=Vector.new(@vectors[1].x-@vectors[2].x, @vectors[1].y-@vectors[2].y) if i==1
        axis=Vector.new(col.vectors[0].x-col.vectors[3].x, col.vectors[0].y-col.vectors[3].y) if i==2
        axis=Vector.new(col.vectors[0].x-col.vectors[1].x, col.vectors[0].y-col.vectors[1].y) if i==3
        
        values1=[]
        values2=[]
        4.times{|p|
        values1 << ((@vectors[p].x * axis.x + @vectors[p].y * axis.y) / (axis.x ** 2 + axis.y ** 2))* axis.x ** 2 + ((@vectors[p].x * axis.x + @vectors[p].y * axis.y) / (axis.x ** 2 + axis.y ** 2)) * axis.y ** 2
        values2 << ((col.vectors[p].x * axis.x + col.vectors[p].y * axis.y) / (axis.x ** 2 + axis.y ** 2))* axis.x ** 2 + ((col.vectors[p].x * axis.x + col.vectors[p].y * axis.y) / (axis.x ** 2 + axis.y ** 2))* axis.y ** 2
        }
        
        return if not values2.min<=values1.max && values2.max>=values1.min
      }
      true
    elsif col.class== Collision_Ball
      a=Math::PI*(@a/180.0)
      x = Math.cos(a) * (col.x - @x) - Math.sin(a) * (col.y - @y) + @x
      y = Math.sin(a) * (col.x - @x) + Math.cos(a) * (col.y - @y) + @y
      
      if x < @x - @w/2
        cx = @x - @w/2
      elsif x > @x + @w/2
        cx = @x + @w/2
      else
        cx = x
      end
      
      if y < @y - @h/2
        cy = @y - @h/2
      elsif y > @y + @h/2
        cy = @y + @h/2
      else
        cy = y
      end
      
      distance(x,y,cx,cy)<col.r
    end
  end
  
  def set(x,y,a=@a)
    @x,@y,@a=x,y,a
    set_vectors
  end
  
  def move(x=0,y=0,a=0)
    @x+=x
    @y+=y
    @a-=a
    set_vectors
  end
  
  def set_vectors
    d=Math.sqrt(@w**2+@h**2)/2
    a=Math::PI*(angle(0,0,@w,@h)/180.0)
    a1=Math::PI*(@a/180.0)
    @vectors=[Vector.new(@x+Math.sin(a1-a)*d,@y+Math.cos(a1-a)*d),
    Vector.new(@x+Math.sin(a1+a)*d,@y+Math.cos(a1+a)*d),
    Vector.new(@x+Math.sin(a1+Math::PI-a)*d,@y+Math.cos(a1+Math::PI-a)*d),
    Vector.new(@x+Math.sin(a1+Math::PI+a)*d,@y+Math.cos(a1+Math::PI+a)*d)]
  end
end

class Collision_Ball
  attr_reader :x,:y,:r
  def initialize(x,y,r)
    @x,@y,@r=x,y,r
  end
  
  def collides?(col)
    return if col==self
    if col.class==Collision_Box
      a=Math::PI*(col.a/180.0)
      x = Math.cos(a) * (@x - col.x) - Math.sin(a) * (@y - col.y) + col.x
      y = Math.sin(a) * (@x - col.x) + Math.cos(a) * (@y - col.y) + col.y
      
      if x < col.x - col.w/2
        cx = col.x - col.w/2
      elsif x > col.x + col.w/2
        cx = col.x + col.w/2
      else
        cx = x
      end
      
      if y < col.y - col.h/2
        cy = col.y - col.h/2
      elsif y > col.y + col.h/2
        cy = col.y + col.h/2
      else
        cy = y
      end
      
      distance(x,y,cx,cy)<@r
    elsif col.class== Collision_Ball
      distance(@x,@y,col.x,col.y)<@r+col.r
    end
  end
  
  def set(x,y)
    @x,@y=x,y
  end
  
  def move(x=0,y=0)
    @x+=x
    @y+=y
  end
end

GameWindow.new.show