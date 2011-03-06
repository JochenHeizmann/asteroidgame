
Strict

Import mojo
Import spaceobject
Import invalidaterect

Class Asteroid Extends SpaceObject
	Global list:List<Asteroid>
	Global image:Image[3]

	Const LARGE:Int  = 0
	Const MEDIUM:Int = 1
	Const SMALL:Int  = 2

	Const MAX_OBJECTS:Int = 25
	
	Field size:Int

	Method New()
		If Not image[SMALL] Then image[SMALL] = LoadImage("asteroidgame/asteroid3.png", 1, Image.MidHandle)
		If Not image[MEDIUM] Then image[MEDIUM] = LoadImage("asteroidgame/asteroid1.png", 1, Image.MidHandle)
		If Not image[LARGE] Then image[LARGE] = LoadImage("asteroidgame/asteroid2.png", 1, Image.MidHandle)
	End Method

	Function Spawn:Void(x:Float, y:Float, size:Int)
		Local asteroid:Asteroid = New Asteroid
		If Not list Then list = New List<Asteroid>

		If list.Count() < MAX_OBJECTS
			Local speed:Float = 0	
		
			Select size
				Case LARGE		
					speed = 0.25 + Rnd(0, 0.25)
		
				Case MEDIUM
					speed = .5 + Rnd(0, .5)
		
				Case SMALL	
					speed = .75 + Rnd(0, .75)
			End
		
			asteroid.x = x
			asteroid.y = y
			asteroid.rotation = Rnd(0, 360)
			asteroid.size = size
		
			asteroid.dx = Cos(asteroid.rotation) * speed
			asteroid.dy = Sin(asteroid.rotation) * speed

			list.AddLast(asteroid)
		End
	End
	
	Method Render:Void()
		Local scale:Float = 1
		Select size
			Case LARGE		
				rotation += 0.2
				InvalidateRect.Add(x-50,y-50, 100, 100)
	
			Case MEDIUM
				rotation += 0.5
				InvalidateRect.Add(x-20,y-20, 40, 40)
		
			Case SMALL	
				rotation += 1.2
				InvalidateRect.Add(x-20,y-20, 40, 40)
		End
		InvalidateRect.Draw(image[size], x, y, rotation, scale, scale, 0)
	End
	
	Method Update:Void()
		x += dx
		y += dy
		
		If x > DeviceWidth()+50 Then x = -50
		If x < -50 Then x = DeviceWidth()+50
		If y > DeviceHeight()+50 Then y = -50
		If y < -50 Then y = DeviceHeight()+50
	End

	Function UpdateAll:Void()
		If Not list Then Return 
		
		For Local asteroid:Asteroid = Eachin list
			asteroid.Update()
		Next
	End

	Function RenderAll:Void()
		If Not list Then Return 
		
		For Local asteroid:Asteroid = Eachin list
			asteroid.Render()
		Next
	End

	Method Destroy:Void() 
		list.Remove( Self )
	End	
End

