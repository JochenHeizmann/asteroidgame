
Strict

Import mojo
Import point
Import helpers

Class InvalidateRect
	Global list : List<InvalidateRect>
	Field x:Int, y:Int, w:Int, h:Int
	
	Function Clear:Void()
		list = New List<InvalidateRect>
	End
	
	Function Add:Void(x:Int,y:Int,w:Int,h:Int)
		Local i:InvalidateRect = New InvalidateRect
		i.x = x
		i.y = y
		i.w = w
		i.h = h

		list.AddLast(i)
	End
	
	Function Draw:Void(i:Image, x:Float, y:Float, r:Float, sx:Float, sy:Float, frame:Int)
		Local p:Point[4]
		p[0] = New Point(-i.HandleX(), -i.HandleY())
		p[1] = New Point(p[0].x + i.Width(), p[0].y + i.Height())
		p[2] = New Point(p[0].x, p[1].y)
		p[3] = New Point(p[1].x, p[0].y)
		
		For Local i:Int = 0 To 3
			p[i].Rotate(-r)
		End
	
		Local dx:Float = 0, dy:Float = 0
		For Local i:Int = 0 To 3
			Local td:Float = Distance(0,0, p[i].x, 0)
			If Abs(td) > dx Then dx = Abs(td)
			
			td = Distance(0,0,0,p[i].y)
			If Abs(td) > dy Then dy = Abs(td)
		Next
		dx += 2
		dy += 2

		Add(-dx + x,-dy + y, dx*2, dy*2)
		DrawImage(i, x, y, r, sx, sy, frame)		
	End Function
End
