Strict

Import mojo

Class SoundPlayer
	Global soundLaser : Sound
	Global soundXplode : Sound
	Global soundCh:Int
	
	Function Init:Void()
		SoundPlayer.soundLaser = LoadSound("asteroidgame/laszer.wav")
		SoundPlayer.soundXplode = LoadSound("asteroidgame/xplode.wav")
	End

	Function PlayFx:Void(s:Sound)
		soundCh += 1
		If (soundCh > 8) Then soundCh = 0
		StopChannel(soundCh)
		PlaySound(s, soundCh)
	End
End

