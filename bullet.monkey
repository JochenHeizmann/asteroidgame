
Strict

Import mojo
Import spaceobject
Import soundplayer
Import invalidaterect

Class Bullet Extends SpaceObject
	Global img:Image
	Global list:List<Bullet>
	Const SPEED:Float = 6.0
	
	Const COOLDOWN:Int = 15
	Global cdown:Int = 0
	
	Function Init:Void()
		If (Not img) Then img = LoadImage("asteroidgame/bullet.png", 1, Image.MidHandle)
		If (Not list) Then list = New List<Bullet>
	End
	
	Function Spawn:Void(x:Float, y:Float, r:Float, speedx:Float, speedy:Float)
		If cdown>COOLDOWN
			Local s:Bullet = New Bullet
			s.x = x
			s.y = y
			s.dx = Cos(r) * SPEED + speedx
			s.dy = Sin(r) * SPEED + speedy
			s.rotation = -r
			list.AddLast(s)
			cdown = 0
			
			SoundPlayer.PlayFx(SoundPlayer.soundLaser)
		End
	End
	
	Method Update:Void()
		x += dx
		y += dy
		If (x < -20 Or x > DeviceWidth()+20 Or y < -20 Or y > DeviceHeight()+20) Then Destroy()
	End
	
	Method Render:Void()
		InvalidateRect.Draw(img, x, y, rotation, 1, 1, 0)
	End
	
	Function UpdateAll:Void()
		cdown += 1
		For Local b:=Eachin list
			b.Update()
		Next
	End
	
	Function RenderAll:Void()
		For Local b:=Eachin list
			b.Render()
		Next
	End 
	
	Method Destroy:Void() 
		list.Remove( Self )
	End
End

