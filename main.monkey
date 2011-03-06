
Strict

Import mojo
Import monkey

Import point
Import spaceobject
Import bullet
Import invalidaterect
Import soundplayer
Import asteroid
Import explosion
Import ship

Class MyGame Extends App
	Field bg : Image
	Field ship : Ship
	
	Global score : Int

	Method OnCreate:Void()
		SetUpdateRate(60)
		bg = LoadImage("asteroidgame/bg.png")
		SoundPlayer.Init()

		InitNewGame()
		
		InvalidateRect.Clear()
		InvalidateRect.Add(0,0,DeviceWidth(), DeviceHeight())
	End
	
	Method InitNewGame:Void()
		Bullet.Init()
		Explosion.Init()
		Ship.Init()
		
		score = 0

		Asteroid.list = Null
		For Local i:Int = 0 To 2
			Asteroid.Spawn(Rnd(0,DeviceWidth()), Rnd(0,DeviceHeight()), Asteroid.LARGE)
		End
	End
	
	Method OnUpdate:Void()
		If ship
			ship.Update()
		Else
			If (KeyHit(KEY_X))
				InitNewGame()
				ship = New Ship()
			End
		End If
		Bullet.UpdateAll()
		Asteroid.UpdateAll()
		If ship Then DoCollision()
		Explosion.UpdateAll()
	End
	
	Method OnRender:Void()
		RenderBG()
		Asteroid.RenderAll()
		Bullet.RenderAll()
		If ship 
			ship.Render()
			DrawText("Score: " + score, 0,0)
			InvalidateRect.Add(0,0, 100, 25)
		Else
			DrawText("G A M E    O V E R - Y O U R    S C O R E: " + score, 0, 0)
			DrawText("Press X to Start new Game", 0, 25)
			DrawText("Instructions: Arrow Keys to move, X to fire!", 0, 50)
			InvalidateRect.Add(0,0, 370, 75)
		End 
		Explosion.RenderAll()
	End
	
	Method RenderBG:Void()
		For Local i := Eachin InvalidateRect.list
			SetScissor(i.x,i.y,i.w,i.h)
			Local x:Int = 0, y:Int = 0
			While (x < DeviceWidth())
				While (y < DeviceHeight())
					DrawImage(bg,x,y)
					y += 480
				Wend
				x += 640
				y = 0
			Wend
		End
		SetScissor(0,0,DeviceWidth(),DeviceHeight())
		InvalidateRect.Clear()
	End 	
	
	Method OnLoading:Void()
		Cls
		DrawText("Loading...", 0, 0)
	End Method
	
	Method DoCollision:Void()
		Local radius:Float
		For Local a:=Eachin Asteroid.list
			radius = a.image[a.size].Width()
			'Aseteroid / Ship
			If (Distance(ship.x, ship.y, a.x, a.y) < radius)
				Explosion.Spawn(a.x, a.y, 1)
				Explosion.Spawn(ship.x, ship.y, 0.75)
				ship = Null
				Return
			End
			For Local b:=Eachin Bullet.list
				
				'Bullet / Asteroid		
				If (Distance(b.x, b.y, a.x, a.y) < radius)
					Select a.size
						Case Asteroid.LARGE	
							Explosion.Spawn(a.x, a.y, 1.0)
							Asteroid.Spawn(a.x+Rnd(-10,10), a.y+Rnd(-10,10), Asteroid.MEDIUM)
							Asteroid.Spawn(a.x+Rnd(-10,10), a.y+Rnd(-10,10), Asteroid.MEDIUM)
							Asteroid.Spawn(a.x+Rnd(-10,10), a.y+Rnd(-10,10), Asteroid.MEDIUM)
							
						Case Asteroid.MEDIUM
							Explosion.Spawn(a.x, a.y, .5)
							Asteroid.Spawn(a.x+Rnd(-5,5), a.y+Rnd(-5,5), Asteroid.SMALL)
							Asteroid.Spawn(a.x+Rnd(-5,5), a.y+Rnd(-5,5), Asteroid.SMALL)
					
						Case Asteroid.SMALL
							Explosion.Spawn(a.x, a.y, .5)
							Asteroid.Spawn(Rnd(0,DeviceWidth()), 0-Rnd(0, 30), Asteroid.LARGE)
							score += 100
					End
					b.Destroy()
					a.Destroy()
				End
			End
		End
	End
End

Function Main:Void()
	New MyGame
End