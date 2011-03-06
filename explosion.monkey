
Strict

Import mojo
Import invalidaterect
Import soundplayer
		
Class Explosion
	Global list:List<Explosion>
	Global img:Image
	
	Field frame:Int
	Field x:Float, y:Float
	Field scale:Float
	
	Method New()
		scale = 1
	End
	
	Function Init:Void()
		If (Not img) Then img = LoadImage("asteroidgame/explosion.png", 32, Image.MidHandle)
		If (Not list) Then list = New List<Explosion>
	End

	Method Update:Void()
		frame += 1
		If frame >= 32 Then Destroy()
	End
	
	Method Render:Void()
		InvalidateRect.Draw(img, x, y, 0, scale, scale, frame Mod 32)
	End

	Function UpdateAll:Void()
		For Local e:Explosion = Eachin list
			e.Update()
		Next
	End

	Function RenderAll:Void()
		For Local e:Explosion = Eachin list
			e.Render()
		Next
	End
		
	Function Spawn:Void(x:Float, y:Float, scale:Float)
		Local e:Explosion = New Explosion()
		e.x = x
		e.y = y
		e.scale = scale
		list.AddLast(e) 
		SoundPlayer.PlayFx(SoundPlayer.soundXplode)
	End

	Method Destroy:Void() 
		list.Remove( Self )
	End
End

