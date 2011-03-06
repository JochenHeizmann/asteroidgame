Strict

Import spaceobject
Import invalidaterect
Import mojo
Import bullet

Class Ship Extends SpaceObject
	Global image:Image

	Const acc:Float = 0.08
	Const fric:Float = 0.015
	Const maxSpeed:Float = 3.0
		
	Const turnAcc:Float = 1.26
	Const turnFric:Float = 0.18	
	Const turnMax:Float = 4

	Field turnSpeed:Float

	Method New()
		x = DeviceWidth() / 2
		y = DeviceHeight() / 2 + DeviceHeight() / 4
	End
	
	Function Init:Void()
		If Not image Then image = LoadImage("asteroidgame/ship.png", 1, Image.MidHandle)
	End
	
	Method Render:Void()
		InvalidateRect.Draw(image, x, y, -rotation, 1, 1, 0)
	End

	Method Update:Void()	
		If KeyDown(KEY_X)
			Bullet.Spawn(x, y, rotation, dx, dy)
		End
		
		If KeyDown(KEY_UP)
			dx += Cos(rotation) * acc
			dy += Sin(rotation) * acc	
		End
		
		If KeyDown(KEY_DOWN)
			dx -= Cos(rotation) * acc
			dy -= Sin(rotation) * acc
		End
		 		
		Local speedVectorLength:Float = Sqrt(dx * dx + dy * dy)
		
		If speedVectorLength > 0
			dx -= (dx / speedVectorLength) * fric
			dy -= (dy / speedVectorLength) * fric
		End
		
		If speedVectorLength > maxSpeed
			dx += (dx / speedVectorLength) * (maxSpeed - speedVectorLength)
			dy += (dy / speedVectorLength) * (maxSpeed - speedVectorLength)
		Endif
		
		x += dx
		y += dy
				
		If KeyDown(KEY_LEFT) Then turnSpeed -= turnAcc
		If KeyDown(KEY_RIGHT) Then turnSpeed += turnAcc
		
		If turnSpeed >  turnMax Then turnSpeed =  turnMax
		If turnSpeed < -turnMax Then turnSpeed = -turnMax
				
		rotation += turnSpeed
		
		If rotation > 360 Then rotation -= 360
		If rotation < 0 Then rotation += 360
		
		If turnSpeed >  turnFric Then turnSpeed -= turnFric
		If turnSpeed < -turnFric Then turnSpeed += turnFric
		
		If turnSpeed < turnFric And turnSpeed > -turnFric Then turnSpeed = 0
		
		If x > DeviceWidth() Then x -= DeviceWidth()
		If y > DeviceHeight() Then y -= DeviceHeight()
		If x < 0 Then x += DeviceWidth()
		If y < 0 Then y += DeviceHeight()
	End
End

