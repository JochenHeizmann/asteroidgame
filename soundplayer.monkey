Strict

Import mojo

Class SoundPlayer
	Global soundLaser : Sound
	Global soundXplode : Sound
	Global soundCh:Int
	
	Function Init:Void()
		SoundPlayer.soundLaser = LoadSound("asteroidgame/laszer.mp3")
		SoundPlayer.soundXplode = LoadSound("asteroidgame/xplode.mp3")
	End

	Function PlayFx:Void(s:Sound)
		soundCh += 1
		If (soundCh > 8) Then soundCh = 0
		StopChannel(soundCh)
		PlaySound(s, soundCh)
	End
End

