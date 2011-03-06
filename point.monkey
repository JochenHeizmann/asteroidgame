
Strict

Class Point
	Field x:Float
	Field y:Float
	
	Method New(x:Float, y:Float)
		Self.x = x
		Self.y = y
	End
	
	Method Rotate:Void(r:Float)
		Local ox:Float = x, oy:Float = y
		x = Cos(r) * ox - Sin(r) * oy
		y = Sin(r) * ox + Cos(r) * oy
	End Method
End
