
package{

	import flash.display.*;
	import flash.text.*;
	import flash.events.*;

	public class MonkeyGame extends Sprite{
	
		internal var bitmap:Bitmap;
		
		public function OnResize( e:Event ):void{
			bitmap.bitmapData=new BitmapData( stage.stageWidth,stage.stageHeight,false,0xff0000ff );
			bitmap.width=bitmap.bitmapData.width;
			bitmap.height=bitmap.bitmapData.height;
		}
		
		public function MonkeyGame(){
			addEventListener( Event.ADDED_TO_STAGE,MonkeyGameEx );
		}
		
		public function MonkeyGameEx( event:Event ):void{
			removeEventListener( Event.ADDED_TO_STAGE,MonkeyGameEx );

			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			bitmap=new Bitmap();
			
			bitmap.bitmapData=new BitmapData( 500,375,false,0xff0000ff );
			bitmap.width=bitmap.bitmapData.width;
			bitmap.height=bitmap.bitmapData.height;
		
			addChild( bitmap );
/*			
			stage.addEventListener( Event.RESIZE,OnResize );
			OnResize( null );
*/
			GameMain( bitmap );
		}
	}
}

//${BEGIN_CODE}

// Actionscript Monkey runtime.
//
// Placed into the public domain 24/02/2011.
// No warranty implied; use at your own risk.

//***** ActionScript Runtime *****

var err_info:String="";
var err_stack:Array=[];
var _console:TextField=null;

function push_err():void{
	err_stack.push( err_info );
}

function pop_err():void{
	err_info=err_stack.pop();
}

function stackTrace():String{
	var str:String="";
	push_err();
	err_stack.reverse();
	for( var i:int=0;i<err_stack.length;++i ){
		str+=err_stack[i]+"\n";
	}
	err_stack.reverse();
	pop_err();
	return str;
}

function getConsole():TextField{
	if( _console ) return _console;
	_console=new TextField();
	_console.x=0;
	_console.y=0;
	_console.width=bitmap.width;
	_console.height=bitmap.height;
	_console.background=false;
	_console.backgroundColor=0xff000000;
	_console.textColor=0xffffff00;
	bitmap.stage.addChild( _console );
	return _console;
}

function print( str:String ):void{
	var c:TextField=getConsole();
	c.appendText( str+"\n" );
//	trace( str );	//this causes a funky VerifyError in flash!
}

function alert( str:String ):void{
	var c:TextField=getConsole();
	c.appendText( str+"\n" );
}

function error( str:String ):void{
	throw str;
}

function dbg_object( obj:Object ):Object{
	if( obj ) return obj;
	error( "Null object access" );
	return obj;
}

function dbg_array( arr:Array,index:int ):Array{
	if( index>=0 && index<arr.length ) return arr;
	error( "Array index out of range" );
	return arr;
}

function new_bool_array( len:int ):Array{
	var arr:Array=new Array( len )
	for( var i:int=0;i<len;++i ) arr[i]=false;
	return arr;
}

function new_number_array( len:int ):Array{
	var arr:Array=new Array( len )
	for( var i:int=0;i<len;++i ) arr[i]=0;
	return arr;
}

function new_string_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]='';
	return arr;
}

function new_array_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]=[];
	return arr;
}

function new_object_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]=null;
	return arr;
}

function resize_number_array( arr:Array,len:int ):Array{
   var res:Array=new Array( len );
   var n:int=Math.min( arr.length,len );
   for( var i:int=0;i<n;++i ) res[i]=arr[i];
   for( var j:int=n;j<len;++j ) res[j]=0;
   return res;
}

function resize_string_array( arr:Array,len:int ):Array{
   var res:Array=new Array( len );
   var n:int=Math.min( arr.length,len );
   for( var i:int=0;i<n;++i ) res[i]=arr[i];
   for( var j:int=n;j<len;++j ) res[j]='';
   return res;
}

function resize_array_array( arr:Array,len:int ):Array{
   var res:Array=new Array( len );
   var n:int=Math.min( arr.length,len );
   for( var i:int=0;i<n;++i ) res[i]=arr[i];
   for( var j:int=n;j<len;++j ) res[j]=[];
   return res;
}

function resize_object_array( arr:Array,len:int ):Array{
   var res:Array=new Array( len );
   var n:int=Math.min( arr.length,len );
   for( var i:int=0;i<n;++i ) res[i]=arr[i];
   for( var j:int=n;j<len;++j ) res[j]=null;
   return res;
}

function string_join( sep:String,bits:Array ):String{
	if( bits.length==0 ) return '';
	var str:String=bits[0];
	for( var i:int=1;i<bits.length;++i ) str+=sep+bits[i];
	return str;
}

function string_trim( str:String ):String{
	var i:int=0,i2:int=str.length;
	while( i<i2 && str.charCodeAt(i)<=32 ) i+=1;
	while( i2>i && str.charCodeAt(i2-1)<=32 ) i2-=1;
	return str.slice( i,i2 );
}

function string_starts_with( str:String,sub:String ):Boolean{
	return sub.length<=str.length && str.slice(0,sub.length)==sub;
}

function string_ends_with( str:String,sub:String ):Boolean{
	return sub.length<=str.length && str.slice(str.length-sub.length,str.length)==sub;
}

// Flash mojo runtime.
//
// Copyright 2011 Mark Sibly, all rights reserved.
// No warranty implied; use at your own risk.

import flash.geom.*;
import flash.display.*;
import flash.utils.*;
import flash.net.*;
import flash.display.*;
import flash.text.*;
import flash.events.*;
import flash.media.*;
	
//${METADATA_BEGIN}
var META_DATA:String="[asteroidgame/asteroid1.png];type=image/png;width=30;height=27;\n[asteroidgame/asteroid2.png];type=image/png;width=85;height=85;\n[asteroidgame/asteroid3.png];type=image/png;width=25;height=23;\n[asteroidgame/bg.png];type=image/png;width=640;height=480;\n[asteroidgame/bullet.png];type=image/png;width=12;height=3;\n[asteroidgame/explosion.png];type=image/png;width=6144;height=192;\n[asteroidgame/laszer.mp3];type=audio/mpeg;\n[asteroidgame/laszer.wav];type=audio/x-wav;length=5926;hertz=44100;\n[asteroidgame/ship.png];type=image/png;width=24;height=28;\n[asteroidgame/xplode.mp3];type=audio/mpeg;\n[asteroidgame/xplode.wav];type=audio/x-wav;length=9648;hertz=8000;\n[mojo_font.png];type=image/png;width=448;height=52;\n";

//${METADATA_END}

internal var app:gxtkApp;
internal var bitmap:Bitmap;

internal var dead:int=0;

internal var KEY_LMB:int=1;
internal var KEY_TOUCH0:int=0x180;

function Die( ex:Object ):void{
	dead=1;
	alert( ex+"\n"+stackTrace() );
	throw ex;
}

function KeyToChar( key:int ):int{
	switch( key ){
	case 8:
	case 9:
	case 13:
	case 27:
		return key;
	case 33:
	case 34:
	case 35:
	case 36:
	case 37:
	case 38:
	case 39:
	case 40:
	case 45:
		return key | 0x10000;
	case 46:
		return 127;
	}
	return 0;
}

function GameMain( _bitmap:Bitmap ):void{

	bitmap=_bitmap;
	
	try{
		bb_Init();
		bb_Main();
	}catch( ex:Object ){
		Die( ex );
	}
	
	if( !app ) return;
	
	bitmap.stage.addEventListener( KeyboardEvent.KEY_DOWN,function( e:KeyboardEvent ):void{
		app.input.OnKeyDown( e.keyCode );
		if( e.charCode!=0 ){
			app.input.PutChar( e.charCode );
		}else{
			var chr:int=KeyToChar( e.keyCode );
			if( chr ) app.input.PutChar( chr );
		}
	} );
	
	bitmap.stage.addEventListener( KeyboardEvent.KEY_UP,function( e:KeyboardEvent ):void{
		app.input.OnKeyUp( e.keyCode );
	} );
	
	bitmap.stage.addEventListener( MouseEvent.MOUSE_DOWN,function( e:MouseEvent ):void{
		app.input.OnKeyDown( KEY_LMB );
	} );
	
	bitmap.stage.addEventListener( MouseEvent.MOUSE_UP,function( e:MouseEvent ):void{
		app.input.OnKeyUp( KEY_LMB );
	} );
	
	bitmap.stage.addEventListener( MouseEvent.MOUSE_MOVE,function( e:MouseEvent ):void{
		app.input.OnMouseMove( e.localX,e.localY );
	} );

	/*
	bitmap.addEventListener( FocusEvent.FOCUS_IN,function( e:FocusEvent ):void{
		app.InvokeOnResume();
	} );
	
	bitmap.addEventListener( FocusEvent.FOCUS_OUT,function( e:FocusEvent ):void{
		app.InvokeOnSuspend();
	} );
	*/
	
	app.InvokeOnCreate();
	app.InvokeOnRender();
}

class gxtkApp{

	internal var graphics:gxtkGraphics;
	internal var input:gxtkInput;
	internal var audio:gxtkAudio;

	internal var loading:int=0;
	internal var maxloading:int=0;
	internal var updateRate:int=0;
	internal var startMillis:Number=0;
	internal var dead:int=0;
	
	internal var suspended:int=0;
	
	function gxtkApp(){
		app=this;

		graphics=new gxtkGraphics;
		input=new gxtkInput;
		audio=new gxtkAudio;

		bitmap.stage.addEventListener( Event.ENTER_FRAME,OnEnterFrame );

		bitmap.stage.frameRate=10;
		
		startMillis=(new Date).getTime();
	}

	internal function IncLoading():void{

		++loading;

		if( loading>maxloading ) maxloading=loading;

		if( loading!=1 ) return;

		if( updateRate ) bitmap.stage.frameRate=10;
	}

	internal function DecLoading():void{

		--loading;

		if( loading ) return;

		maxloading=0;

		if( updateRate ) bitmap.stage.frameRate=updateRate;
	}

	internal function OnEnterFrame( e:Event ):void{
		InvokeOnUpdate();
		InvokeOnRender();
	}
	
	internal function InvokeOnCreate():int{
		if( dead ) return 0;
		
		try{
			OnCreate();
		}catch( ex:Object ){
			Die( ex );
		}
		return 0;
	}

	internal function InvokeOnUpdate():int{
		if( dead || suspended || !updateRate || loading ) return 0;
		
		try{
			input.BeginUpdate();
			OnUpdate();
			input.EndUpdate();
		}catch( ex:Object ){
			Die( ex );
		}
		return 0;
	}
	
	internal function InvokeOnSuspend():int{
		if( dead || suspended ) return 0;
		
		try{
			suspended=1;
			OnSuspend();
		}catch( ex:Object ){
			Die( ex );
		}
		return 0;
	}
	
	internal function InvokeOnResume():int{
		if( dead || !suspended ) return 0;
		
		try{
			OnResume();
			suspended=0;
		}catch( ex:Object ){
			Die( ex );
		}
		return 0;
	}

	internal function InvokeOnRender():int{
		if( dead || suspended ) return 0;
		
		try{
			graphics.BeginRender();
			if( loading ){
				OnLoading();
			}else{
				OnRender();
			}
			graphics.EndRender();
		}catch( ex:Object ){
			Die( ex );
		}
		return 0;
	}
	
	//***** GXTK API *****
	
	internal function GraphicsDevice():gxtkGraphics{
		return graphics;
	}

	internal function InputDevice():gxtkInput{
		return input;
	}

	internal function AudioDevice():gxtkAudio{
		return audio;
	}

	internal function GetMetaData( path:String,key:String ):String{
		var i:int=META_DATA.indexOf( "["+path+"]" );
		if( i==-1 ) return "";
		i+=path.length+2;

		var e:int=META_DATA.indexOf( "\n",i );
		if( e==-1 ) e=META_DATA.length;

		i=META_DATA.indexOf( ";"+key+"=",i )
		if( i==-1 || i>=e ) return "";
		i+=key.length+2;

		e=META_DATA.indexOf( ";",i );
		if( e==-1 ) return "";
	
		return META_DATA.slice( i,e );
	}
	
	internal function AppTitle():String{
		return bitmap.loaderInfo.url;
	}
	
	internal function LoadState():String{
		var file:SharedObject=SharedObject.getLocal( "gxtkapp" );
		var state:String=file.data.state;
		file.close();
		if( state ) return state;
		return "";
	}
	
	internal function SaveState( state:String ):int{
		var file:SharedObject=SharedObject.getLocal( "gxtkapp" );
		file.data.state=state;
		file.close();
		return 0;
	}
	
	internal function LoadString( path:String ):String{
		if( path=="" ) return "";
//${TEXTFILES_BEGIN}
		return "";

//${TEXTFILES_END}
	}

	internal function SetUpdateRate( hertz:int ):int{

		updateRate=hertz;
		
		if( loading ) return 0;

		if( updateRate ){
			bitmap.stage.frameRate=updateRate;
		}else{
			bitmap.stage.frameRate=10;
		}
		return 0;
	}
	
	internal function MilliSecs():int{
		return (new Date).getTime()-startMillis;
	}

	internal function Loading():int{
		return loading;
	}

	internal function OnCreate():int{
		return 0;
	}

	internal function OnUpdate():int{
		return 0;
	}
	
	internal function OnSuspend():int{
		return 0;
	}
	
	internal function OnResume():int{
		return 0;
	}
	
	internal function OnRender():int{
		return 0;
	}
	
	internal function OnLoading():int{
		return 0;
	}

}

class gxtkGraphics{
	internal var color:uint;
	internal var matrix:Matrix;
	internal var rectBMData:BitmapData;
	internal var alpha:ColorTransform;
	internal var blend:String;

	internal var shape:Shape;
	internal var graphics:Graphics;
	internal var bitmapData:BitmapData;
	
	internal var clipRect:Rectangle;

	function gxtkGraphics(){
		color=0xffffffff;
		rectBMData=new BitmapData( 1,1,false,color );
	}

	internal function BeginRender():void{
		bitmapData=bitmap.bitmapData;
	}

	internal function UseBitmap():void{
		if( graphics==null ) return;
		bitmapData.draw( shape,matrix,alpha,blend,clipRect,true );
		graphics.clear();
		graphics=null;
	}

	internal function UseGraphics():void{
		if( graphics!=null ) return;
		if( shape==null ) shape=new Shape;
		graphics=shape.graphics;
	}

	internal function FlushGraphics():void{
		if( graphics==null ) return;
		bitmapData.draw( shape,matrix,alpha,blend,clipRect,true );
		graphics.clear();
	}
	
	internal function EndRender():void{
		UseBitmap();
		bitmapData=null;
	}

	//***** GXTK API *****

	internal function Width():int{
		return bitmap.width;
	}

	internal function Height():int{
		return bitmap.height;
	}

	internal function LoadSurface( path:String ):gxtkSurface{
		var surface:gxtkSurface=new gxtkSurface;
		surface.Load( path );
		return surface;
	}
	
	internal function DestroySurface( surface:gxtkSurface ):int{
		return 0;
	}

	internal function SetAlpha( alpha:Number ):int{
		FlushGraphics();
		
		if( alpha!=1 ){
			this.alpha=new ColorTransform( 1.0,1.0,1.0,alpha );
		}else{
			this.alpha=null;
		}
		return 0;
	}
	
	internal function SetColor( r:Number,g:Number,b:Number ):int{
		FlushGraphics();
		
		color=0xff000000|(int(r)<<16)|(int(g)<<8)|int(b);
		rectBMData.setPixel( 0,0,color );
		return 0;
	}
	
	internal function SetBlend( blend:int ):int{
		switch( blend ){
		case 1:
			this.blend=BlendMode.ADD;
			break;
		default:
			this.blend=null;
		}
		return 0;
	}
	
	internal function SetScissor( x:int,y:int,w:int,h:int ):int{
		FlushGraphics();
		
		if( x!=0 || y!=0 || w!=bitmap.width || h!=bitmap.height ){
			clipRect=new Rectangle( x,y,w,h );
		}else{
			clipRect=null;
		}
		return 0;
	}

	internal function SetMatrix( ix:Number,iy:Number,jx:Number,jy:Number,tx:Number,ty:Number ):int{
		FlushGraphics();
		
		if( ix!=1 || iy!=0 || jx!=0 || jy!=1 || tx!=0 || ty!=0 ){
			matrix=new Matrix( ix,iy,jx,jy,tx,ty );
		}else{
			matrix=null;
		}
		return 0;
	}

	internal function Cls( r:Number,g:Number,b:Number ):int{
		UseBitmap();

		var clsColor:int=0xff000000|(int(r)<<16)|(int(g)<<8)|int(b);
		var rect:Rectangle=clipRect;
		if( !rect ) rect=new Rectangle( 0,0,bitmap.width,bitmap.height );
		bitmapData.fillRect( rect,clsColor );
		return 0;
	}

	internal function DrawRect( x:Number,y:Number,w:Number,h:Number ):int{
		UseBitmap();

		if( matrix ){
			var mat:Matrix=new Matrix( w,0,0,h,x,y );
			mat.concat( matrix );
			bitmapData.draw( rectBMData,mat,alpha,blend,clipRect,true );
		}else if( clipRect || alpha || blend ){
			var mat2:Matrix=new Matrix( w,0,0,h,x,y );
			bitmapData.draw( rectBMData,mat2,alpha,blend,clipRect,true );
		}else{
			bitmapData.fillRect( new Rectangle( x,y,w,h ),color );
		}
		return 0;
	}

	internal function DrawLine( x1:Number,y1:Number,x2:Number,y2:Number ):int{
		UseGraphics();
		
		graphics.lineStyle( 1,color );
		graphics.moveTo( x1,y1 );
		graphics.lineTo( x2,y2 );
		graphics.lineStyle();		
		
		if( alpha ) FlushGraphics();

		return 0;
 	}

	internal function DrawOval( x:Number,y:Number,w:Number,h:Number ):int{
		UseGraphics();

		graphics.beginFill( color & 0xffffff );	//why the mask?
		graphics.drawEllipse( x,y,w,h );
		graphics.endFill();
		
		if( alpha ) FlushGraphics();

		return 0;
	}

	internal function DrawSurface( surface:gxtkSurface,x:Number,y:Number ):int{
		UseBitmap();

		if( matrix ){
			if( x!=0 || y!=0 ){
				//have to translate matrix! TODO!
				return -1;
			}
			bitmapData.draw( surface.bitmap.bitmapData,matrix,alpha,blend,clipRect,true );
		}else if( clipRect || alpha || blend ){
			var mat:Matrix=new Matrix( 1,0,0,1,x,y );
			bitmapData.draw( surface.bitmap.bitmapData,mat,alpha,blend,clipRect,true );
		}else{
			bitmapData.copyPixels( surface.bitmap.bitmapData,surface.rect,new Point( x,y ) );
		}
		return 0;
	}

	internal function DrawSurface2( surface:gxtkSurface,x:Number,y:Number,srcx:int,srcy:int,srcw:int,srch:int ):int{
		UseBitmap();

		var srcrect:Rectangle=new Rectangle( srcx,srcy,srcw,srch );
		
		if( matrix || clipRect || alpha || blend ){

			var scratch:BitmapData=surface.scratch;
			if( scratch==null || srcw!=scratch.width || srch!=scratch.height ){
				if( scratch!=null ) scratch.dispose();
				scratch=new BitmapData( srcw,srch );
				surface.scratch=scratch;
			}
			scratch.copyPixels( surface.bitmap.bitmapData,srcrect,new Point( 0,0 ) );
			
			var mmatrix:Matrix=matrix;
			if( mmatrix==null ){
				mmatrix=new Matrix( 1,0,0,1,x,y );
			}else if( x!=0 || y!=0 ){
				//have to translate matrix! TODO!
				return -1;
			}

			bitmapData.draw( scratch,mmatrix,alpha,blend,clipRect,true );
		}else{
			bitmapData.copyPixels( surface.bitmap.bitmapData,srcrect,new Point( x,y ) );
		}
		
		/*
		if( matrix ){
			if( x!=0 || y!=0 ){
				//have to translate matrix! TODO!
				return -1;
			}
			//Sexy! draw() has no src_rect so use a scratch bitmap...
			var scratch:BitmapData=surface.scratch;
			if( scratch==null || srcw!=scratch.width || srch!=scratch.height ){
				if( scratch!=null ) scratch.dispose();
				scratch=new BitmapData( srcw,srch );
				surface.scratch=scratch;
			}
			scratch.copyPixels( surface.bitmap.bitmapData,srcrect,new Point( 0,0 ) );
			bitmapData.draw( scratch,matrix,alpha,blend,clipRect,true );
		}else if( clipRect || alpha || blend ){
			var mat:Matrix=new Matrix( 1,0,0,1,x,y );
			bitmapData.draw( surface.bitmap,mat,alpha,blend,clipRect,true );
		}else{
			bitmapData.copyPixels( surface.bitmap.bitmapData,srcrect,new Point( x,y ) );
		}
		*/
		
		return 0;
	}
}

class gxtkSurface{
	internal var loader:Loader;
	internal var loaded:int;
	internal var bitmap:Bitmap;
	internal var rect:Rectangle;
	internal var scratch:BitmapData;
	
	internal function OnLoaded( e:Event ):void{
		try{
			bitmap=Bitmap( loader.content );
			loaded=1;
		}catch( ex:SecurityError ){
			Die( ex );
		}
		loader=null;
		app.DecLoading();
	}

	internal function OnError( e:Event ):void{
		loaded=-1;
		loader=null;
		app.DecLoading();
	}

	internal function Load( path:String ):void{

		var ty:String=app.GetMetaData( path,"type" );
		if( ty.indexOf( "image/" )!=0 ) return;

		var w:int=parseInt( app.GetMetaData( path,"width" ) );
		var h:int=parseInt( app.GetMetaData( path,"height" ) );
		
		this.rect=new Rectangle( 0,0,w,h );

		loader=new Loader();

		loader.contentLoaderInfo.addEventListener( Event.INIT,OnLoaded );
		loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR,OnError );
	
		app.IncLoading();

		loader.load( new URLRequest( "data/"+path ) );
	}

	//***** GXTK API *****

	internal function Width():int{
		return rect.width;
	}

	internal function Height():int{
		return rect.height;
	}

	internal function Loaded():int{
		return loaded;
	}
}

class gxtkInput{
	internal var keyStates:Array=new Array( 512 );
	internal var charQueue:Array=new Array( 32 );
	internal var charPut:int=0;
	internal var charGet:int=0;
	internal var mouseX:Number=0;
	internal var mouseY:Number=0;
	
	function gxtkInput(){
		for( var i:int=0;i<512;++i ){
			keyStates[i]=0;
		}
	}
	
	internal function BeginUpdate():void{
	}
	
	internal function EndUpdate():void{
		for( var i:int=0;i<512;++i ){
			keyStates[i]&=0x100;
		}
		charGet=0;
		charPut=0;
	}
	
	internal function OnKeyDown( key:int ):void{
		if( (keyStates[key]&0x100)==0 ){
			keyStates[key]|=0x100;
			++keyStates[key];
		}
	}

	internal function OnKeyUp( key:int ):void{
		keyStates[key]&=0xff;
	}
	
	internal function PutChar( chr:int ):void{
		if( chr==0 ) return;
		if( charPut-charGet<32 ){
			charQueue[charPut & 31]=chr;
			charPut+=1;
		}
	}
	
	internal function OnMouseMove( x:Number,y:Number ):void{
		mouseX=x;
		mouseY=y;
	}

	//***** GXTK API *****
	
	internal function KeyDown( key:int ):int{
		if( key>0 && key<512 ){
			if( key==KEY_TOUCH0 ) key=KEY_LMB;
			return keyStates[key] >> 8;
		}
		return 0;
	}

	internal function KeyHit( key:int ):int{
		if( key>0 && key<512 ){
			if( key==KEY_TOUCH0 ) key=KEY_LMB;
			return keyStates[key] & 0xff;
		}
		return 0;
	}

	internal function GetChar():int{
		if( charGet!=charPut ){
			var chr:int=charQueue[charGet & 31];
			charGet+=1;
			return chr;
		}
		return 0;
	}
	
	internal function MouseX():Number{
		return mouseX;
	}

	internal function MouseY():Number{
		return mouseY;
	}

	internal function JoyX( index:int ):Number{
		return 0;
	}
	
	internal function JoyY( index:int ):Number{
		return 0;
	}
	
	internal function JoyZ( index:int ):Number{
		return 0;
	}
	
	internal function TouchX( index:int ):Number{
		return mouseX;
	}

	internal function TouchY( index:int ):Number{
		return mouseY;
	}
}

class gxtkAudio{

	internal var channels:Array=new Array( 32 );
	internal var transforms:Array=new Array( 32 );
	internal var samples:Array=new Array( 32 );

	function gxtkAudio(){
		for( var i:int=0;i<32;++i ){
			transforms[i]=new SoundTransform();
		}
	}
	
	//***** GXTK API *****
	
	internal function LoadSample( path:String ):gxtkSample{
		var req:URLRequest=new URLRequest( "data/"+path );
		var sound:Sound=new Sound( req );
		return new gxtkSample( sound );
	}
	
	internal function DestroySample( sample:gxtkSample ):int{
		return 0;
	}

	internal function PlaySample( sample:gxtkSample,channel:int,flags:int ):int{
		if( channels[channel] ) channels[channel].stop();
		channels[channel]=sample.sound.play( 0,flags ? 0x7fffffff : 0,transforms[channel] );
		samples[channel]=sample;
		return 0;
	}
	
	internal function StopChannel( channel:int ):int{
		if( channels[channel] ){
			channels[channel].stop();
			channels[channel]=null;
			samples[channel]=null;
		}
		return 0;
	}
	
	internal function ChannelState( channel:int ):int{
		return -1;
		/* Doesn't work, position never reacehs length, another 'known issue' with flash!
		if( channels[channel] ){
			if( channels[channel].position<samples[channel].sound.length ) return 1;
			channels[channel].stop();
			channels[channel]=null;
			samples[channel]=null;
		}
		return 0;
		*/
	}
	
	internal function SetVolume( channel:int,volume:Number ):int{
		transforms[channel].volume=volume;
		if( channels[channel] ) channels[channel].soundTransform=transforms[channel];
		return 0;
	}
	
	internal function SetPan( channel:int,pan:Number ):int{
		transforms[channel].pan=pan;
		if( channels[channel] ) channels[channel].soundTransform=transforms[channel];
		return 0;
	}
	
	internal function SetRate( channel:int,rate:Number ):int{
		return -1;
	}
	
}

class gxtkSample{

	internal var sound:Sound;

	function gxtkSample( sound:Sound ){
		this.sound=sound;
	}
}
class bb_app_App extends Object{
	internal function bbApp_new():bb_app_App{
		bb_app_device=(new bb_app_AppDevice).bbAppDevice_new(this);
		return this;
	}
	internal function bbOnCreate():int{
		return 0;
	}
	internal function bbOnUpdate():int{
		return 0;
	}
	internal function bbOnSuspend():int{
		return 0;
	}
	internal function bbOnResume():int{
		return 0;
	}
	internal function bbOnRender():int{
		return 0;
	}
	internal function bbOnLoading():int{
		return 0;
	}
}
class bb_main_MyGame extends bb_app_App{
	internal function bbMyGame_new():bb_main_MyGame{
		super.bbApp_new();
		return this;
	}
	internal var bbbg:bb_graphics_Image=null;
	internal static var bbscore:int;
	internal function bbInitNewGame():void{
		bb_bullet_Bullet.bbInit();
		bb_explosion_Explosion.bbInit();
		bb_ship_Ship.bbInit();
		bbscore=0;
		bb_asteroid_Asteroid.bblist=null;
		for(var bbi:int=0;bbi<=2;bbi=bbi+1){
			bb_asteroid_Asteroid.bbSpawn(bb_random_Rnd2(0.000000,(bb_graphics_DeviceWidth())),bb_random_Rnd2(0.000000,((bb_graphics_DeviceHeight()/2)|0)),0);
		}
	}
	internal override function bbOnCreate():int{
		bb_app_SetUpdateRate(60);
		this.bbbg=bb_graphics_LoadImage("asteroidgame/bg.png",1,bb_graphics_Image.bbDefaultFlags);
		bb_soundplayer_SoundPlayer.bbInit();
		this.bbInitNewGame();
		bb_invalidaterect_InvalidateRect.bbClear();
		bb_invalidaterect_InvalidateRect.bbAdd(0,0,bb_graphics_DeviceWidth(),bb_graphics_DeviceHeight());
		return 1;
	}
	internal var bbship:bb_ship_Ship=null;
	internal function bbDoCollision():void{
		var bbradius:Number=0;
		var bb:bb_list_Enumerator=bb_asteroid_Asteroid.bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bba:bb_asteroid_Asteroid=((bb.bbNextObject()) as bb_asteroid_Asteroid);
			bbradius=(bb_asteroid_Asteroid.bbimage[bba.bbsize].bbWidth());
			if(bb_helpers_Distance(this.bbship.bbx,this.bbship.bby,bba.bbx,bba.bby)<bbradius){
				bb_explosion_Explosion.bbSpawn(bba.bbx,bba.bby,1.000000);
				bb_explosion_Explosion.bbSpawn(this.bbship.bbx,this.bbship.bby,0.75);
				this.bbship=null;
				return;
			}
			var bb2:bb_list_Enumerator=bb_bullet_Bullet.bblist.bbObjectEnumerator();
			while(bb2.bbHasNext()){
				var bbb:bb_bullet_Bullet=((bb2.bbNextObject()) as bb_bullet_Bullet);
				if(bb_helpers_Distance(bbb.bbx,bbb.bby,bba.bbx,bba.bby)<bbradius){
					var bb3:int=bba.bbsize;
					if(bb3==0){
						bb_explosion_Explosion.bbSpawn(bba.bbx,bba.bby,1.0);
						bb_asteroid_Asteroid.bbSpawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
						bb_asteroid_Asteroid.bbSpawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
						bb_asteroid_Asteroid.bbSpawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
					}else{
						if(bb3==1){
							bb_explosion_Explosion.bbSpawn(bba.bbx,bba.bby,.5);
							bb_asteroid_Asteroid.bbSpawn(bba.bbx+bb_random_Rnd2(-5.000000,5.000000),bba.bby+bb_random_Rnd2(-5.000000,5.000000),2);
							bb_asteroid_Asteroid.bbSpawn(bba.bbx+bb_random_Rnd2(-5.000000,5.000000),bba.bby+bb_random_Rnd2(-5.000000,5.000000),2);
						}else{
							if(bb3==2){
								bb_explosion_Explosion.bbSpawn(bba.bbx,bba.bby,.5);
								bb_asteroid_Asteroid.bbSpawn(bb_random_Rnd2(0.000000,(bb_graphics_DeviceWidth())),0.000000-bb_random_Rnd2(0.000000,30.000000),0);
								bbscore+=100;
							}
						}
					}
					bbb.bbDestroy();
					bba.bbDestroy();
				}
			}
		}
	}
	internal override function bbOnUpdate():int{
		if((this.bbship)!=null){
			this.bbship.bbUpdate();
		}else{
			if((bb_input_KeyHit(88))!=0){
				this.bbInitNewGame();
				this.bbship=(new bb_ship_Ship).bbShip_new();
			}
		}
		bb_bullet_Bullet.bbUpdateAll();
		bb_asteroid_Asteroid.bbUpdateAll();
		if((this.bbship)!=null){
			this.bbDoCollision();
		}
		bb_explosion_Explosion.bbUpdateAll();
		return 1;
	}
	internal function bbRenderBG():void{
		var bb:bb_list_Enumerator=bb_invalidaterect_InvalidateRect.bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbi:bb_invalidaterect_InvalidateRect=((bb.bbNextObject()) as bb_invalidaterect_InvalidateRect);
			bb_graphics_SetScissor((bbi.bbx),(bbi.bby),(bbi.bbw),(bbi.bbh));
			var bbx:int=0;
			var bby:int=0;
			while(bbx<bb_graphics_DeviceWidth()){
				while(bby<bb_graphics_DeviceHeight()){
					bb_graphics_DrawImage(this.bbbg,(bbx),(bby),0);
					bby+=480;
				}
				bbx+=640;
				bby=0;
			}
		}
		bb_graphics_SetScissor(0.000000,0.000000,(bb_graphics_DeviceWidth()),(bb_graphics_DeviceHeight()));
		bb_invalidaterect_InvalidateRect.bbClear();
	}
	internal override function bbOnRender():int{
		this.bbRenderBG();
		bb_asteroid_Asteroid.bbRenderAll();
		bb_bullet_Bullet.bbRenderAll();
		if((this.bbship)!=null){
			this.bbship.bbRender();
			bb_graphics_DrawText("Score: "+String(bbscore),0.000000,0.000000,0.000000,0.000000);
			bb_invalidaterect_InvalidateRect.bbAdd(0,0,100,25);
		}else{
			bb_graphics_DrawText("G A M E    O V E R - Y O U R    S C O R E: "+String(bbscore),0.000000,0.000000,0.000000,0.000000);
			bb_graphics_DrawText("Press X to Start new Game",0.000000,25.000000,0.000000,0.000000);
			bb_graphics_DrawText("Instructions: Arrow Keys to move, X to fire!",0.000000,50.000000,0.000000,0.000000);
			bb_invalidaterect_InvalidateRect.bbAdd(0,0,370,75);
		}
		bb_explosion_Explosion.bbRenderAll();
		return 1;
	}
	internal override function bbOnLoading():int{
		bb_graphics_Cls(0.000000,0.000000,0.000000);
		bb_graphics_DrawText("Loading...",0.000000,0.000000,0.000000,0.000000);
		return 1;
	}
}
class bb_app_AppDevice extends gxtkApp{
	internal var bbapp:bb_app_App=null;
	internal function bbAppDevice_new(bbapp:bb_app_App):bb_app_AppDevice{
		this.bbapp=bbapp;
		bb_graphics_SetGraphicsContext((new bb_graphics_GraphicsContext).bbGraphicsContext_new(this.GraphicsDevice()));
		bb_input_SetInputDevice(this.InputDevice());
		bb_audio_SetAudioDevice(this.AudioDevice());
		return this;
	}
	internal function bbAppDevice_new2():bb_app_AppDevice{
		return this;
	}
	internal override function OnCreate():int{
		return this.bbapp.bbOnCreate();
	}
	internal override function OnUpdate():int{
		return this.bbapp.bbOnUpdate();
	}
	internal override function OnSuspend():int{
		return this.bbapp.bbOnSuspend();
	}
	internal override function OnResume():int{
		return this.bbapp.bbOnResume();
	}
	internal override function OnRender():int{
		bb_graphics_BeginRender();
		var bbr:int=this.bbapp.bbOnRender();
		bb_graphics_EndRender();
		return bbr;
	}
	internal override function OnLoading():int{
		bb_graphics_BeginRender();
		var bbr:int=this.bbapp.bbOnLoading();
		bb_graphics_EndRender();
		return bbr;
	}
}
class bb_graphics_GraphicsContext extends Object{
	internal var bbdevice:gxtkGraphics=null;
	internal function bbGraphicsContext_new(bbdevice:gxtkGraphics):bb_graphics_GraphicsContext{
		this.bbdevice=bbdevice;
		return this;
	}
	internal function bbGraphicsContext_new2():bb_graphics_GraphicsContext{
		return this;
	}
	internal var bbmatrixSp:int=0;
	internal var bbix:Number=1.000000;
	internal var bbiy:Number=0;
	internal var bbjx:Number=0;
	internal var bbjy:Number=1.000000;
	internal var bbtx:Number=0;
	internal var bbty:Number=0;
	internal var bbtformed:int=0;
	internal var bbmatDirty:int=0;
	internal var bbcolor_r:Number=0;
	internal var bbcolor_g:Number=0;
	internal var bbcolor_b:Number=0;
	internal var bbalpha:Number=0;
	internal var bbblend:int=0;
	internal var bbscissor_x:Number=0;
	internal var bbscissor_y:Number=0;
	internal var bbscissor_width:Number=0;
	internal var bbscissor_height:Number=0;
	internal var bbmatrixStack:Array=new_number_array(192);
	internal var bbfont:bb_graphics_Image=null;
	internal var bbdefaultFont:bb_graphics_Image=null;
	internal var bbfirstChar:int=0;
}
var bb_graphics_context:bb_graphics_GraphicsContext;
internal function bb_graphics_SetGraphicsContext(bbgc:bb_graphics_GraphicsContext):int{
	bb_graphics_context=bbgc;
	return 0;
}
var bb_input_device:gxtkInput;
internal function bb_input_SetInputDevice(bbdev:gxtkInput):int{
	bb_input_device=bbdev;
	return 0;
}
var bb_audio_device:gxtkAudio;
internal function bb_audio_SetAudioDevice(bbdev:gxtkAudio):int{
	bb_audio_device=bbdev;
	return 0;
}
var bb_app_device:bb_app_AppDevice;
internal function bb_Main():void{
	(new bb_main_MyGame).bbMyGame_new();
}
internal function bb_graphics_SetMatrix(bbix:Number,bbiy:Number,bbjx:Number,bbjy:Number,bbtx:Number,bbty:Number):int{
	bb_graphics_context.bbix=bbix;
	bb_graphics_context.bbiy=bbiy;
	bb_graphics_context.bbjx=bbjx;
	bb_graphics_context.bbjy=bbjy;
	bb_graphics_context.bbtx=bbtx;
	bb_graphics_context.bbty=bbty;
	bb_graphics_context.bbtformed=((bbix!=1.000000 || bbiy!=0.000000 || bbjx!=0.000000 || bbjy!=1.000000 || bbtx!=0.000000 || bbty!=0.000000)?1:0);
	bb_graphics_context.bbmatDirty=1;
	return 0;
}
internal function bb_graphics_SetMatrix2(bbm:Array):int{
	bb_graphics_SetMatrix(bbm[0],bbm[1],bbm[2],bbm[3],bbm[4],bbm[5]);
	return 0;
}
internal function bb_graphics_SetColor(bbr:Number,bbg:Number,bbb:Number):int{
	bb_graphics_context.bbcolor_r=bbr;
	bb_graphics_context.bbcolor_g=bbg;
	bb_graphics_context.bbcolor_b=bbb;
	bb_graphics_context.bbdevice.SetColor(bbr,bbg,bbb);
	return 0;
}
internal function bb_graphics_SetAlpha(bbalpha:Number):int{
	bb_graphics_context.bbalpha=bbalpha;
	bb_graphics_context.bbdevice.SetAlpha(bbalpha);
	return 0;
}
internal function bb_graphics_SetBlend(bbblend:int):int{
	bb_graphics_context.bbblend=bbblend;
	bb_graphics_context.bbdevice.SetBlend(bbblend);
	return 0;
}
internal function bb_graphics_DeviceWidth():int{
	return bb_graphics_context.bbdevice.Width();
}
internal function bb_graphics_DeviceHeight():int{
	return bb_graphics_context.bbdevice.Height();
}
internal function bb_graphics_SetScissor(bbx:Number,bby:Number,bbwidth:Number,bbheight:Number):int{
	bb_graphics_context.bbscissor_x=bbx;
	bb_graphics_context.bbscissor_y=bby;
	bb_graphics_context.bbscissor_width=bbwidth;
	bb_graphics_context.bbscissor_height=bbheight;
	bb_graphics_context.bbdevice.SetScissor(((bbx)|0),((bby)|0),((bbwidth)|0),((bbheight)|0));
	return 0;
}
internal function bb_graphics_BeginRender():int{
	bb_graphics_context.bbmatrixSp=0;
	bb_graphics_SetMatrix(1.000000,0.000000,0.000000,1.000000,0.000000,0.000000);
	bb_graphics_SetColor(255.000000,255.000000,255.000000);
	bb_graphics_SetAlpha(1.000000);
	bb_graphics_SetBlend(0);
	bb_graphics_SetScissor(0.000000,0.000000,(bb_graphics_DeviceWidth()),(bb_graphics_DeviceHeight()));
	return 0;
}
internal function bb_graphics_EndRender():int{
	return 0;
}
internal function bb_app_SetUpdateRate(bbhertz:int):int{
	return bb_app_device.SetUpdateRate(bbhertz);
}
class bb_resource_Resource extends Object{
	internal function bbResource_new():bb_resource_Resource{
		return this;
	}
	internal var bbnode:bb_list_Node=null;
	internal function bbRegister(bbtype:String):int{
		var bblist:bb_list_List=((bb_resource_resources.bbValueForKey((((new bb_boxes_StringObject).bbStringObject_new3(bbtype))))) as bb_list_List);
		if(!((bblist)!=null)){
			bblist=(new bb_list_List).bbList_new();
			bb_resource_resources.bbInsert(((new bb_boxes_StringObject).bbStringObject_new3(bbtype)),bblist);
		}
		this.bbnode=bblist.bbAddLast(this);
		return 0;
	}
	internal var bbrefs:int=1;
	internal function bbRetain():int{
		this.bbrefs+=1;
		return 0;
	}
}
class bb_graphics_Image extends bb_resource_Resource{
	internal static var bbDefaultFlags:int;
	internal var bbsurface:gxtkSurface=null;
	internal var bbwidth:int=0;
	internal var bbheight:int=0;
	internal var bbflags:int=0;
	internal var bbframes:Array=[];
	internal var bbtx:Number=0;
	internal var bbty:Number=0;
	internal function bbSetHandle(bbtx:Number,bbty:Number):int{
		this.bbtx=bbtx;
		this.bbty=bbty;
		this.bbflags=this.bbflags&-2;
		return 0;
	}
	internal function bbImage_new(bbpath:String,bbnframes:int,bbiflags:int):bb_graphics_Image{
		super.bbResource_new();
		this.bbsurface=bb_graphics_context.bbdevice.LoadSurface(bbpath);
		if(!((this.bbsurface)!=null)){
			error("Failed to load image "+bbpath);
		}
		this.bbRegister("mojo.graphics.Image");
		this.bbwidth=((this.bbsurface.Width()/bbnframes)|0);
		this.bbheight=this.bbsurface.Height();
		this.bbflags=bbiflags;
		this.bbframes=new_object_array(bbnframes);
		for(var bbi:int=0;bbi<bbnframes;bbi=bbi+1){
			this.bbframes[bbi]=(new bb_graphics_Frame).bbFrame_new(bbi*this.bbwidth,0);
		}
		if(bbnframes==1){
			this.bbflags|=65536;
		}
		if((this.bbflags&1)!=0){
			this.bbSetHandle((this.bbwidth)/2.0,(this.bbheight)/2.0);
		}
		return this;
	}
	internal var bbsource:bb_graphics_Image=null;
	internal function bbImage_new2(bbx:int,bby:int,bbiwidth:int,bbiheight:int,bbnframes:int,bbiflags:int,bbsource:bb_graphics_Image):bb_graphics_Image{
		super.bbResource_new();
		this.bbRegister("mojo.graphics.Image");
		bbsource.bbRetain();
		this.bbsource=bbsource;
		this.bbsurface=bbsource.bbsurface;
		this.bbwidth=bbiwidth;
		this.bbheight=bbiheight;
		this.bbflags=bbiflags;
		this.bbframes=new_object_array(bbnframes);
		var bbix:int=bbx+bbsource.bbframes[0].bbx;
		var bbiy:int=bby+bbsource.bbframes[0].bby;
		for(var bbi:int=0;bbi<bbnframes;bbi=bbi+1){
			if(bbix+this.bbwidth>bbsource.bbwidth){
				bbix=bbsource.bbframes[0].bbx;
				bbiy+=this.bbheight;
			}
			this.bbframes[bbi]=(new bb_graphics_Frame).bbFrame_new(bbix,bbiy);
			bbix+=this.bbwidth;
		}
		if(bbnframes==1 && bbx==0 && bby==0 && this.bbwidth==this.bbsurface.Width() && this.bbheight==this.bbsurface.Height()){
			this.bbflags|=65536;
		}
		if((this.bbflags&1)!=0){
			this.bbSetHandle((this.bbwidth)/2.0,(this.bbheight)/2.0);
		}
		return this;
	}
	internal function bbImage_new3():bb_graphics_Image{
		super.bbResource_new();
		return this;
	}
	internal function bbGrabImage(bbx:int,bby:int,bbwidth:int,bbheight:int,bbframes:int,bbflags:int):bb_graphics_Image{
		if(this.bbframes.length!=1){
			return null;
		}
		return (new bb_graphics_Image).bbImage_new2(bbx,bby,bbwidth,bbheight,bbframes,bbflags,this);
	}
	internal function bbWidth():int{
		return this.bbwidth;
	}
	internal function bbHandleX():Number{
		return this.bbtx;
	}
	internal function bbHandleY():Number{
		return this.bbty;
	}
	internal function bbHeight():int{
		return this.bbheight;
	}
	internal function bbLoaded():int{
		return this.bbsurface.Loaded();
	}
	internal function bbFrames():int{
		return this.bbframes.length;
	}
}
class bb_list_List extends Object{
	internal function bbList_new():bb_list_List{
		return this;
	}
	internal var bb_head:bb_list_Node=(new bb_list_Node).bbNode_new();
	internal function bbAddLast(bbdata:Object):bb_list_Node{
		return (new bb_list_Node).bbNode_new2(this.bb_head,this.bb_head.bb_pred,bbdata);
	}
	internal function bbCount():int{
		var bbn:int=0;
		var bbnode:bb_list_Node=this.bb_head.bb_succ;
		while(bbnode!=this.bb_head){
			bbnode=bbnode.bb_succ;
			bbn+=1;
		}
		return bbn;
	}
	internal function bbObjectEnumerator():bb_list_Enumerator{
		return (new bb_list_Enumerator).bbEnumerator_new(this);
	}
	internal function bbEquals(bblhs:Object,bbrhs:Object):int{
		return ((bblhs==bbrhs)?1:0);
	}
	internal function bbRemoveEach(bbvalue:Object):int{
		var bbnode:bb_list_Node=this.bb_head.bb_succ;
		while(bbnode!=this.bb_head){
			bbnode=bbnode.bb_succ;
			if(((this.bbEquals((bbnode.bb_pred.bb_data),(bbvalue)))!=0)){
				bbnode.bb_pred.bbRemove();
			}
		}
		return 0;
	}
	internal function bbRemove(bbvalue:Object):int{
		this.bbRemoveEach(bbvalue);
		return 0;
	}
}
class bb_boxes_StringObject extends Object{
	internal var bbvalue:String="";
	internal function bbStringObject_new(bbvalue:int):bb_boxes_StringObject{
		this.bbvalue=String(bbvalue);
		return this;
	}
	internal function bbStringObject_new2(bbvalue:Number):bb_boxes_StringObject{
		this.bbvalue=String(bbvalue);
		return this;
	}
	internal function bbStringObject_new3(bbvalue:String):bb_boxes_StringObject{
		this.bbvalue=bbvalue;
		return this;
	}
	internal function bbStringObject_new4():bb_boxes_StringObject{
		return this;
	}
}
class bb_map_Map extends Object{
	internal function bbMap_new():bb_map_Map{
		return this;
	}
	internal var bbroot:bb_map_Node=null;
	internal function bbCompare(bblhs:Object,bbrhs:Object):int{
		return 0;
	}
	internal function bbFindNode(bbkey:Object):bb_map_Node{
		var bbnode:bb_map_Node=this.bbroot;
		while((bbnode)!=null){
			var bbcmp:int=this.bbCompare((bbkey),(bbnode.bbkey));
			if(bbcmp>0){
				bbnode=bbnode.bbright;
			}else{
				if(bbcmp<0){
					bbnode=bbnode.bbleft;
				}else{
					return bbnode;
				}
			}
		}
		return bbnode;
	}
	internal function bbGet(bbkey:Object):Object{
		var bbnode:bb_map_Node=this.bbFindNode(bbkey);
		if((bbnode)!=null){
			return bbnode.bbvalue;
		}
		return null;
	}
	internal function bbValueForKey(bbkey:Object):Object{
		return this.bbGet(bbkey);
	}
	internal function bbRotateLeft(bbnode:bb_map_Node):int{
		var bbchild:bb_map_Node=bbnode.bbright;
		bbnode.bbright=bbchild.bbleft;
		if((bbchild.bbleft)!=null){
			bbchild.bbleft.bbparent=bbnode;
		}
		bbchild.bbparent=bbnode.bbparent;
		if((bbnode.bbparent)!=null){
			if(bbnode==bbnode.bbparent.bbleft){
				bbnode.bbparent.bbleft=bbchild;
			}else{
				bbnode.bbparent.bbright=bbchild;
			}
		}else{
			this.bbroot=bbchild;
		}
		bbchild.bbleft=bbnode;
		bbnode.bbparent=bbchild;
		return 0;
	}
	internal function bbRotateRight(bbnode:bb_map_Node):int{
		var bbchild:bb_map_Node=bbnode.bbleft;
		bbnode.bbleft=bbchild.bbright;
		if((bbchild.bbright)!=null){
			bbchild.bbright.bbparent=bbnode;
		}
		bbchild.bbparent=bbnode.bbparent;
		if((bbnode.bbparent)!=null){
			if(bbnode==bbnode.bbparent.bbright){
				bbnode.bbparent.bbright=bbchild;
			}else{
				bbnode.bbparent.bbleft=bbchild;
			}
		}else{
			this.bbroot=bbchild;
		}
		bbchild.bbright=bbnode;
		bbnode.bbparent=bbchild;
		return 0;
	}
	internal function bbInsertFixup(bbnode:bb_map_Node):int{
		while(((bbnode.bbparent)!=null) && bbnode.bbparent.bbcolor==-1 && ((bbnode.bbparent.bbparent)!=null)){
			if(bbnode.bbparent==bbnode.bbparent.bbparent.bbleft){
				var bbuncle:bb_map_Node=bbnode.bbparent.bbparent.bbright;
				if(((bbuncle)!=null) && bbuncle.bbcolor==-1){
					bbnode.bbparent.bbcolor=1;
					bbuncle.bbcolor=1;
					bbuncle.bbparent.bbcolor=-1;
					bbnode=bbuncle.bbparent;
				}else{
					if(bbnode==bbnode.bbparent.bbright){
						bbnode=bbnode.bbparent;
						this.bbRotateLeft(bbnode);
					}
					bbnode.bbparent.bbcolor=1;
					bbnode.bbparent.bbparent.bbcolor=-1;
					this.bbRotateRight(bbnode.bbparent.bbparent);
				}
			}else{
				var bbuncle2:bb_map_Node=bbnode.bbparent.bbparent.bbleft;
				if(((bbuncle2)!=null) && bbuncle2.bbcolor==-1){
					bbnode.bbparent.bbcolor=1;
					bbuncle2.bbcolor=1;
					bbuncle2.bbparent.bbcolor=-1;
					bbnode=bbuncle2.bbparent;
				}else{
					if(bbnode==bbnode.bbparent.bbleft){
						bbnode=bbnode.bbparent;
						this.bbRotateRight(bbnode);
					}
					bbnode.bbparent.bbcolor=1;
					bbnode.bbparent.bbparent.bbcolor=-1;
					this.bbRotateLeft(bbnode.bbparent.bbparent);
				}
			}
		}
		this.bbroot.bbcolor=1;
		return 0;
	}
	internal function bbSet(bbkey:Object,bbvalue:Object):int{
		var bbnode:bb_map_Node=this.bbroot;
		var bbparent:bb_map_Node=null;
		var bbcmp:int=0;
		while((bbnode)!=null){
			bbparent=bbnode;
			bbcmp=this.bbCompare((bbkey),(bbnode.bbkey));
			if(bbcmp>0){
				bbnode=bbnode.bbright;
			}else{
				if(bbcmp<0){
					bbnode=bbnode.bbleft;
				}else{
					bbnode.bbvalue=bbvalue;
					return 0;
				}
			}
		}
		bbnode=(new bb_map_Node).bbNode_new(bbkey,bbvalue,-1,bbparent);
		if(!((bbparent)!=null)){
			this.bbroot=bbnode;
			return 0;
		}
		if(bbcmp>0){
			bbparent.bbright=bbnode;
		}else{
			bbparent.bbleft=bbnode;
		}
		this.bbInsertFixup(bbnode);
		return 0;
	}
	internal function bbInsert(bbkey:Object,bbvalue:Object):int{
		return this.bbSet(bbkey,bbvalue);
	}
}
class bb_map_StringMap extends bb_map_Map{
	internal function bbStringMap_new():bb_map_StringMap{
		super.bbMap_new();
		return this;
	}
	internal override function bbCompare(bblhs:Object,bbrhs:Object):int{
		var bbl:String=((bblhs) as bb_boxes_StringObject).bbvalue;
		var bbr:String=((bbrhs) as bb_boxes_StringObject).bbvalue;
		if(bbl<bbr){
			return -1;
		}
		return ((bbl>bbr)?1:0);
	}
}
var bb_resource_resources:bb_map_StringMap;
class bb_map_Node extends Object{
	internal var bbkey:Object=null;
	internal var bbright:bb_map_Node=null;
	internal var bbleft:bb_map_Node=null;
	internal var bbvalue:Object=null;
	internal var bbcolor:int=0;
	internal var bbparent:bb_map_Node=null;
	internal function bbNode_new(bbkey:Object,bbvalue:Object,bbcolor:int,bbparent:bb_map_Node):bb_map_Node{
		this.bbkey=bbkey;
		this.bbvalue=bbvalue;
		this.bbcolor=bbcolor;
		this.bbparent=bbparent;
		return this;
	}
	internal function bbNode_new2():bb_map_Node{
		return this;
	}
}
class bb_list_Node extends Object{
	internal var bb_succ:bb_list_Node=null;
	internal var bb_pred:bb_list_Node=null;
	internal function bbNode_new():bb_list_Node{
		this.bb_succ=this;
		this.bb_pred=this;
		return this;
	}
	internal var bb_data:Object=null;
	internal function bbNode_new2(bbsucc:bb_list_Node,bbpred:bb_list_Node,bbdata:Object):bb_list_Node{
		this.bb_succ=bbsucc;
		this.bb_pred=bbpred;
		this.bb_succ.bb_pred=this;
		this.bb_pred.bb_succ=this;
		this.bb_data=bbdata;
		return this;
	}
	internal function bbRemove():int{
		this.bb_succ.bb_pred=this.bb_pred;
		this.bb_pred.bb_succ=this.bb_succ;
		return 0;
	}
}
class bb_graphics_Frame extends Object{
	internal var bbx:int=0;
	internal var bby:int=0;
	internal function bbFrame_new(bbx:int,bby:int):bb_graphics_Frame{
		this.bbx=bbx;
		this.bby=bby;
		return this;
	}
	internal function bbFrame_new2():bb_graphics_Frame{
		return this;
	}
}
internal function bb_graphics_LoadImage(bbpath:String,bbframeCount:int,bbflags:int):bb_graphics_Image{
	return (new bb_graphics_Image).bbImage_new(bbpath,bbframeCount,bbflags);
}
internal function bb_graphics_LoadImage2(bbpath:String,bbframeWidth:int,bbframeHeight:int,bbframeCount:int,bbflags:int):bb_graphics_Image{
	var bbatlas:bb_graphics_Image=(new bb_graphics_Image).bbImage_new(bbpath,1,0);
	if((bbatlas)!=null){
		return bbatlas.bbGrabImage(0,0,bbframeWidth,bbframeHeight,bbframeCount,bbflags);
	}
	return null;
}
class bb_soundplayer_SoundPlayer extends Object{
	internal static var bbsoundLaser:bb_audio_Sound;
	internal static var bbsoundXplode:bb_audio_Sound;
	internal static function bbInit():void{
		bbsoundLaser=bb_audio_LoadSound("asteroidgame/laszer.mp3");
		bbsoundXplode=bb_audio_LoadSound("asteroidgame/xplode.mp3");
	}
	internal static var bbsoundCh:int;
	internal static function bbPlayFx(bbs:bb_audio_Sound):void{
		bbsoundCh+=1;
		if(bbsoundCh>8){
			bbsoundCh=0;
		}
		bb_audio_StopChannel(bbsoundCh);
		bb_audio_PlaySound(bbs,bbsoundCh,0);
	}
}
class bb_audio_Sound extends bb_resource_Resource{
	internal var bbsample:gxtkSample=null;
	internal function bbSound_new(bbsample:gxtkSample):bb_audio_Sound{
		super.bbResource_new();
		this.bbsample=bbsample;
		if((bbsample)!=null){
			this.bbRegister("mojo.audio.Sound");
		}
		return this;
	}
	internal function bbSound_new2():bb_audio_Sound{
		super.bbResource_new();
		return this;
	}
}
internal function bb_audio_LoadSound(bbpath:String):bb_audio_Sound{
	var bbsample:gxtkSample=bb_audio_device.LoadSample(bbpath);
	return (new bb_audio_Sound).bbSound_new(bbsample);
}
class bb_spaceobject_SpaceObject extends Object{
	internal function bbSpaceObject_new():bb_spaceobject_SpaceObject{
		return this;
	}
	internal var bbx:Number=0;
	internal var bby:Number=0;
	internal var bbrotation:Number=0;
	internal var bbdx:Number=0;
	internal var bbdy:Number=0;
}
class bb_bullet_Bullet extends bb_spaceobject_SpaceObject{
	internal static var bbimg:bb_graphics_Image;
	internal static var bblist:bb_list_List;
	internal static function bbInit():void{
		if(!((bbimg)!=null)){
			bbimg=bb_graphics_LoadImage("asteroidgame/bullet.png",1,1);
		}
		if(!((bblist)!=null)){
			bblist=(new bb_list_List).bbList_new();
		}
	}
	internal static var bbcdown:int;
	internal function bbBullet_new():bb_bullet_Bullet{
		super.bbSpaceObject_new();
		return this;
	}
	internal static function bbSpawn(bbx:Number,bby:Number,bbr:Number,bbspeedx:Number,bbspeedy:Number):void{
		if(bbcdown>15){
			var bbs:bb_bullet_Bullet=(new bb_bullet_Bullet).bbBullet_new();
			bbs.bbx=bbx;
			bbs.bby=bby;
			bbs.bbdx=Math.cos((bbr)*0.0174532925)*6.0+bbspeedx;
			bbs.bbdy=Math.sin((bbr)*0.0174532925)*6.0+bbspeedy;
			bbs.bbrotation=-bbr;
			bblist.bbAddLast(bbs);
			bbcdown=0;
			bb_soundplayer_SoundPlayer.bbPlayFx(bb_soundplayer_SoundPlayer.bbsoundLaser);
		}
	}
	internal function bbDestroy():void{
		bblist.bbRemove(this);
	}
	internal function bbUpdate():void{
		this.bbx+=this.bbdx;
		this.bby+=this.bbdy;
		if(this.bbx<-20.000000 || this.bbx>(bb_graphics_DeviceWidth()+20) || this.bby<-20.000000 || this.bby>(bb_graphics_DeviceHeight()+20)){
			this.bbDestroy();
		}
	}
	internal static function bbUpdateAll():void{
		bbcdown+=1;
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbb:bb_bullet_Bullet=((bb.bbNextObject()) as bb_bullet_Bullet);
			bbb.bbUpdate();
		}
	}
	internal function bbRender():void{
		bb_invalidaterect_InvalidateRect.bbDraw(bbimg,this.bbx,this.bby,this.bbrotation,1.000000,1.000000,0);
	}
	internal static function bbRenderAll():void{
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbb:bb_bullet_Bullet=((bb.bbNextObject()) as bb_bullet_Bullet);
			bbb.bbRender();
		}
	}
}
class bb_explosion_Explosion extends Object{
	internal static var bbimg:bb_graphics_Image;
	internal static var bblist:bb_list_List;
	internal static function bbInit():void{
		if(!((bbimg)!=null)){
			bbimg=bb_graphics_LoadImage("asteroidgame/explosion.png",32,1);
		}
		if(!((bblist)!=null)){
			bblist=(new bb_list_List).bbList_new();
		}
	}
	internal var bbscale:Number=0;
	internal function bbExplosion_new():bb_explosion_Explosion{
		this.bbscale=1.000000;
		return this;
	}
	internal var bbx:Number=0;
	internal var bby:Number=0;
	internal static function bbSpawn(bbx:Number,bby:Number,bbscale:Number):void{
		var bbe:bb_explosion_Explosion=(new bb_explosion_Explosion).bbExplosion_new();
		bbe.bbx=bbx;
		bbe.bby=bby;
		bbe.bbscale=bbscale;
		bblist.bbAddLast(bbe);
		bb_soundplayer_SoundPlayer.bbPlayFx(bb_soundplayer_SoundPlayer.bbsoundXplode);
	}
	internal var bbframe:int=0;
	internal function bbDestroy():void{
		bblist.bbRemove(this);
	}
	internal function bbUpdate():void{
		this.bbframe+=1;
		if(this.bbframe>=32){
			this.bbDestroy();
		}
	}
	internal static function bbUpdateAll():void{
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbe:bb_explosion_Explosion=((bb.bbNextObject()) as bb_explosion_Explosion);
			bbe.bbUpdate();
		}
	}
	internal function bbRender():void{
		bb_invalidaterect_InvalidateRect.bbDraw(bbimg,this.bbx,this.bby,0.000000,this.bbscale,this.bbscale,this.bbframe % 32);
	}
	internal static function bbRenderAll():void{
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbe:bb_explosion_Explosion=((bb.bbNextObject()) as bb_explosion_Explosion);
			bbe.bbRender();
		}
	}
}
class bb_ship_Ship extends bb_spaceobject_SpaceObject{
	internal static var bbimage:bb_graphics_Image;
	internal static function bbInit():void{
		if(!((bbimage)!=null)){
			bbimage=bb_graphics_LoadImage("asteroidgame/ship.png",1,1);
		}
	}
	internal var bbturnSpeed:Number=0;
	internal function bbUpdate():void{
		if((bb_input_KeyDown(88))!=0){
			bb_bullet_Bullet.bbSpawn(this.bbx,this.bby,this.bbrotation,this.bbdx,this.bbdy);
		}
		if((bb_input_KeyDown(38))!=0){
			this.bbdx+=Math.cos((this.bbrotation)*0.0174532925)*0.08;
			this.bbdy+=Math.sin((this.bbrotation)*0.0174532925)*0.08;
		}
		if((bb_input_KeyDown(40))!=0){
			this.bbdx-=Math.cos((this.bbrotation)*0.0174532925)*0.08;
			this.bbdy-=Math.sin((this.bbrotation)*0.0174532925)*0.08;
		}
		var bbspeedVectorLength:Number=Math.sqrt(this.bbdx*this.bbdx+this.bbdy*this.bbdy);
		if(bbspeedVectorLength>0.000000){
			this.bbdx-=this.bbdx/bbspeedVectorLength*0.015;
			this.bbdy-=this.bbdy/bbspeedVectorLength*0.015;
		}
		if(bbspeedVectorLength>3.0){
			this.bbdx+=this.bbdx/bbspeedVectorLength*(3.0-bbspeedVectorLength);
			this.bbdy+=this.bbdy/bbspeedVectorLength*(3.0-bbspeedVectorLength);
		}
		this.bbx+=this.bbdx;
		this.bby+=this.bbdy;
		if((bb_input_KeyDown(37))!=0){
			this.bbturnSpeed-=1.26;
		}
		if((bb_input_KeyDown(39))!=0){
			this.bbturnSpeed+=1.26;
		}
		if(this.bbturnSpeed>4.000000){
			this.bbturnSpeed=4.000000;
		}
		if(this.bbturnSpeed<-4.000000){
			this.bbturnSpeed=-4.000000;
		}
		this.bbrotation+=this.bbturnSpeed;
		if(this.bbrotation>360.000000){
			this.bbrotation-=360.000000;
		}
		if(this.bbrotation<0.000000){
			this.bbrotation+=360.000000;
		}
		if(this.bbturnSpeed>0.18){
			this.bbturnSpeed-=0.18;
		}
		if(this.bbturnSpeed<-0.180000){
			this.bbturnSpeed+=0.18;
		}
		if(this.bbturnSpeed<0.18 && this.bbturnSpeed>-0.180000){
			this.bbturnSpeed=0.000000;
		}
		if(this.bbx>(bb_graphics_DeviceWidth())){
			this.bbx-=(bb_graphics_DeviceWidth());
		}
		if(this.bby>(bb_graphics_DeviceHeight())){
			this.bby-=(bb_graphics_DeviceHeight());
		}
		if(this.bbx<0.000000){
			this.bbx+=(bb_graphics_DeviceWidth());
		}
		if(this.bby<0.000000){
			this.bby+=(bb_graphics_DeviceHeight());
		}
	}
	internal function bbShip_new():bb_ship_Ship{
		super.bbSpaceObject_new();
		this.bbx=((bb_graphics_DeviceWidth()/2)|0);
		this.bby=(((bb_graphics_DeviceHeight()/2)|0)+((bb_graphics_DeviceHeight()/4)|0));
		return this;
	}
	internal function bbRender():void{
		bb_invalidaterect_InvalidateRect.bbDraw(bbimage,this.bbx,this.bby,-this.bbrotation,1.000000,1.000000,0);
	}
}
class bb_asteroid_Asteroid extends bb_spaceobject_SpaceObject{
	internal static var bblist:bb_list_List;
	internal static var bbimage:Array;
	internal function bbAsteroid_new():bb_asteroid_Asteroid{
		super.bbSpaceObject_new();
		if(!((bbimage[2])!=null)){
			bbimage[2]=bb_graphics_LoadImage("asteroidgame/asteroid3.png",1,1);
		}
		if(!((bbimage[1])!=null)){
			bbimage[1]=bb_graphics_LoadImage("asteroidgame/asteroid1.png",1,1);
		}
		if(!((bbimage[0])!=null)){
			bbimage[0]=bb_graphics_LoadImage("asteroidgame/asteroid2.png",1,1);
		}
		return this;
	}
	internal var bbsize:int=0;
	internal static function bbSpawn(bbx:Number,bby:Number,bbsize:int):void{
		var bbasteroid:bb_asteroid_Asteroid=(new bb_asteroid_Asteroid).bbAsteroid_new();
		if(!((bblist)!=null)){
			bblist=(new bb_list_List).bbList_new();
		}
		if(bblist.bbCount()<25){
			var bbspeed:Number=0.000000;
			var bb:int=bbsize;
			if(bb==0){
				bbspeed=0.25+bb_random_Rnd2(0.000000,0.25);
			}else{
				if(bb==1){
					bbspeed=.5+bb_random_Rnd2(0.000000,.5);
				}else{
					if(bb==2){
						bbspeed=.75+bb_random_Rnd2(0.000000,.75);
					}
				}
			}
			bbasteroid.bbx=bbx;
			bbasteroid.bby=bby;
			bbasteroid.bbrotation=bb_random_Rnd2(0.000000,360.000000);
			bbasteroid.bbsize=bbsize;
			bbasteroid.bbdx=Math.cos((bbasteroid.bbrotation)*0.0174532925)*bbspeed;
			bbasteroid.bbdy=Math.sin((bbasteroid.bbrotation)*0.0174532925)*bbspeed;
			bblist.bbAddLast(bbasteroid);
		}
	}
	internal function bbUpdate():void{
		this.bbx+=this.bbdx;
		this.bby+=this.bbdy;
		if(this.bbx>(bb_graphics_DeviceWidth()+50)){
			this.bbx=-50.000000;
		}
		if(this.bbx<-50.000000){
			this.bbx=(bb_graphics_DeviceWidth()+50);
		}
		if(this.bby>(bb_graphics_DeviceHeight()+50)){
			this.bby=-50.000000;
		}
		if(this.bby<-50.000000){
			this.bby=(bb_graphics_DeviceHeight()+50);
		}
	}
	internal static function bbUpdateAll():void{
		if(!((bblist)!=null)){
			return;
		}
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbasteroid:bb_asteroid_Asteroid=((bb.bbNextObject()) as bb_asteroid_Asteroid);
			bbasteroid.bbUpdate();
		}
	}
	internal function bbDestroy():void{
		bblist.bbRemove(this);
	}
	internal function bbRender():void{
		var bbscale:Number=1.000000;
		var bb:int=this.bbsize;
		if(bb==0){
			this.bbrotation+=0.2;
			bb_invalidaterect_InvalidateRect.bbAdd(((this.bbx-50.000000)|0),((this.bby-50.000000)|0),100,100);
		}else{
			if(bb==1){
				this.bbrotation+=0.5;
				bb_invalidaterect_InvalidateRect.bbAdd(((this.bbx-20.000000)|0),((this.bby-20.000000)|0),40,40);
			}else{
				if(bb==2){
					this.bbrotation+=1.2;
					bb_invalidaterect_InvalidateRect.bbAdd(((this.bbx-20.000000)|0),((this.bby-20.000000)|0),40,40);
				}
			}
		}
		bb_invalidaterect_InvalidateRect.bbDraw(bbimage[this.bbsize],this.bbx,this.bby,this.bbrotation,bbscale,bbscale,0);
	}
	internal static function bbRenderAll():void{
		if(!((bblist)!=null)){
			return;
		}
		var bb:bb_list_Enumerator=bblist.bbObjectEnumerator();
		while(bb.bbHasNext()){
			var bbasteroid:bb_asteroid_Asteroid=((bb.bbNextObject()) as bb_asteroid_Asteroid);
			bbasteroid.bbRender();
		}
	}
}
var bb_random_Seed:int;
internal function bb_random_Rnd():Number{
	bb_random_Seed=bb_random_Seed*1664525+1013904223|0;
	return (((bb_random_Seed/4)|0)&1073741823)/1073741824.0000;
}
internal function bb_random_Rnd2(bblow:Number,bbhigh:Number):Number{
	return bb_random_Rnd3(bbhigh-bblow)+bblow;
}
internal function bb_random_Rnd3(bbrange:Number):Number{
	return bb_random_Rnd()*bbrange;
}
class bb_invalidaterect_InvalidateRect extends Object{
	internal static var bblist:bb_list_List;
	internal static function bbClear():void{
		bblist=(new bb_list_List).bbList_new();
	}
	internal function bbInvalidateRect_new():bb_invalidaterect_InvalidateRect{
		return this;
	}
	internal var bbx:int=0;
	internal var bby:int=0;
	internal var bbw:int=0;
	internal var bbh:int=0;
	internal static function bbAdd(bbx:int,bby:int,bbw:int,bbh:int):void{
		var bbi:bb_invalidaterect_InvalidateRect=(new bb_invalidaterect_InvalidateRect).bbInvalidateRect_new();
		bbi.bbx=bbx;
		bbi.bby=bby;
		bbi.bbw=bbw;
		bbi.bbh=bbh;
		bblist.bbAddLast(bbi);
	}
	internal static function bbDraw(bbi:bb_graphics_Image,bbx:Number,bby:Number,bbr:Number,bbsx:Number,bbsy:Number,bbframe:int):void{
		var bbp:Array=new_object_array(4);
		bbp[0]=(new bb_point_Point).bbPoint_new(-bbi.bbHandleX(),-bbi.bbHandleY());
		bbp[1]=(new bb_point_Point).bbPoint_new(bbp[0].bbx+(bbi.bbWidth()),bbp[0].bby+(bbi.bbHeight()));
		bbp[2]=(new bb_point_Point).bbPoint_new(bbp[0].bbx,bbp[1].bby);
		bbp[3]=(new bb_point_Point).bbPoint_new(bbp[1].bbx,bbp[0].bby);
		for(var bbi2:int=0;bbi2<=3;bbi2=bbi2+1){
			bbp[bbi2].bbRotate(-bbr);
		}
		var bbdx:Number=0.000000;
		var bbdy:Number=0.000000;
		for(var bbi3:int=0;bbi3<=3;bbi3=bbi3+1){
			var bbtd:Number=bb_helpers_Distance(0.000000,0.000000,bbp[bbi3].bbx,0.000000);
			if(bb_math_Abs2(bbtd)>bbdx){
				bbdx=bb_math_Abs2(bbtd);
			}
			bbtd=bb_helpers_Distance(0.000000,0.000000,0.000000,bbp[bbi3].bby);
			if(bb_math_Abs2(bbtd)>bbdy){
				bbdy=bb_math_Abs2(bbtd);
			}
		}
		bbdx+=2.000000;
		bbdy+=2.000000;
		bbAdd(((-bbdx+bbx)|0),((-bbdy+bby)|0),((bbdx*2.000000)|0),((bbdy*2.000000)|0));
		bb_graphics_DrawImage2(bbi,bbx,bby,bbr,bbsx,bbsy,bbframe);
	}
}
internal function bb_input_KeyDown(bbkey:int):int{
	return bb_input_device.KeyDown(bbkey);
}
internal function bb_audio_StopChannel(bbchannel:int):int{
	bb_audio_device.StopChannel(bbchannel);
	return 0;
}
internal function bb_audio_PlaySound(bbsound:bb_audio_Sound,bbchannel:int,bbflags:int):int{
	if((bbsound.bbsample)!=null){
		bb_audio_device.PlaySample(bbsound.bbsample,bbchannel,bbflags);
	}
	return 0;
}
internal function bb_input_KeyHit(bbkey:int):int{
	return bb_input_device.KeyHit(bbkey);
}
class bb_list_Enumerator extends Object{
	internal var bb_list:bb_list_List=null;
	internal var bb_curr:bb_list_Node=null;
	internal function bbEnumerator_new(bblist:bb_list_List):bb_list_Enumerator{
		this.bb_list=bblist;
		this.bb_curr=bblist.bb_head.bb_succ;
		return this;
	}
	internal function bbEnumerator_new2():bb_list_Enumerator{
		return this;
	}
	internal function bbHasNext():Boolean{
		return this.bb_curr!=this.bb_list.bb_head;
	}
	internal function bbNextObject():Object{
		var bbdata:Object=this.bb_curr.bb_data;
		this.bb_curr=this.bb_curr.bb_succ;
		return bbdata;
	}
}
internal function bb_helpers_Distance(bbx1:Number,bby1:Number,bbx2:Number,bby2:Number):Number{
	var bbdx:Number=bbx2-bbx1;
	var bbdy:Number=bby2-bby1;
	return Math.sqrt(bbdx*bbdx+bbdy*bbdy);
}
internal function bb_graphics_PushMatrix():int{
	var bbsp:int=bb_graphics_context.bbmatrixSp;
	bb_graphics_context.bbmatrixStack[bbsp+0]=bb_graphics_context.bbix;
	bb_graphics_context.bbmatrixStack[bbsp+1]=bb_graphics_context.bbiy;
	bb_graphics_context.bbmatrixStack[bbsp+2]=bb_graphics_context.bbjx;
	bb_graphics_context.bbmatrixStack[bbsp+3]=bb_graphics_context.bbjy;
	bb_graphics_context.bbmatrixStack[bbsp+4]=bb_graphics_context.bbtx;
	bb_graphics_context.bbmatrixStack[bbsp+5]=bb_graphics_context.bbty;
	bb_graphics_context.bbmatrixSp=bbsp+6;
	return 0;
}
internal function bb_graphics_Transform(bbix:Number,bbiy:Number,bbjx:Number,bbjy:Number,bbtx:Number,bbty:Number):int{
	var bbix2:Number=bbix*bb_graphics_context.bbix+bbiy*bb_graphics_context.bbjx;
	var bbiy2:Number=bbix*bb_graphics_context.bbiy+bbiy*bb_graphics_context.bbjy;
	var bbjx2:Number=bbjx*bb_graphics_context.bbix+bbjy*bb_graphics_context.bbjx;
	var bbjy2:Number=bbjx*bb_graphics_context.bbiy+bbjy*bb_graphics_context.bbjy;
	var bbtx2:Number=bbtx*bb_graphics_context.bbix+bbty*bb_graphics_context.bbjx+bb_graphics_context.bbtx;
	var bbty2:Number=bbtx*bb_graphics_context.bbiy+bbty*bb_graphics_context.bbjy+bb_graphics_context.bbty;
	bb_graphics_SetMatrix(bbix2,bbiy2,bbjx2,bbjy2,bbtx2,bbty2);
	return 0;
}
internal function bb_graphics_Transform2(bbcoords:Array):Array{
	var bbout:Array=new_number_array(bbcoords.length);
	for(var bbi:int=0;bbi<bbcoords.length-1;bbi=bbi+2){
		var bbx:Number=bbcoords[bbi];
		var bby:Number=bbcoords[bbi+1];
		bbout[bbi]=bbx*bb_graphics_context.bbix+bby*bb_graphics_context.bbjx+bb_graphics_context.bbtx;
		bbout[bbi+1]=bbx*bb_graphics_context.bbiy+bby*bb_graphics_context.bbjy+bb_graphics_context.bbty;
	}
	return bbout;
}
internal function bb_graphics_Translate(bbx:Number,bby:Number):int{
	bb_graphics_Transform(1.000000,0.000000,0.000000,1.000000,bbx,bby);
	return 0;
}
internal function bb_graphics_ValidateMatrix():int{
	if((bb_graphics_context.bbmatDirty)!=0){
		bb_graphics_context.bbdevice.SetMatrix(bb_graphics_context.bbix,bb_graphics_context.bbiy,bb_graphics_context.bbjx,bb_graphics_context.bbjy,bb_graphics_context.bbtx,bb_graphics_context.bbty);
		bb_graphics_context.bbmatDirty=0;
	}
	return 0;
}
internal function bb_graphics_PopMatrix():int{
	var bbsp:int=bb_graphics_context.bbmatrixSp-6;
	bb_graphics_SetMatrix(bb_graphics_context.bbmatrixStack[bbsp+0],bb_graphics_context.bbmatrixStack[bbsp+1],bb_graphics_context.bbmatrixStack[bbsp+2],bb_graphics_context.bbmatrixStack[bbsp+3],bb_graphics_context.bbmatrixStack[bbsp+4],bb_graphics_context.bbmatrixStack[bbsp+5]);
	bb_graphics_context.bbmatrixSp=bbsp;
	return 0;
}
internal function bb_graphics_DrawImage(bbimage:bb_graphics_Image,bbx:Number,bby:Number,bbframe:int):int{
	var bbf:bb_graphics_Frame=bbimage.bbframes[bbframe];
	if((bb_graphics_context.bbtformed)!=0){
		bb_graphics_PushMatrix();
		bb_graphics_Translate(bbx-bbimage.bbtx,bby-bbimage.bbty);
		bb_graphics_ValidateMatrix();
		if((bbimage.bbflags&65536)!=0){
			bb_graphics_context.bbdevice.DrawSurface(bbimage.bbsurface,0.000000,0.000000);
		}else{
			bb_graphics_context.bbdevice.DrawSurface2(bbimage.bbsurface,0.000000,0.000000,bbf.bbx,bbf.bby,bbimage.bbwidth,bbimage.bbheight);
		}
		bb_graphics_PopMatrix();
	}else{
		bb_graphics_ValidateMatrix();
		if((bbimage.bbflags&65536)!=0){
			bb_graphics_context.bbdevice.DrawSurface(bbimage.bbsurface,bbx-bbimage.bbtx,bby-bbimage.bbty);
		}else{
			bb_graphics_context.bbdevice.DrawSurface2(bbimage.bbsurface,bbx-bbimage.bbtx,bby-bbimage.bbty,bbf.bbx,bbf.bby,bbimage.bbwidth,bbimage.bbheight);
		}
	}
	return 0;
}
internal function bb_graphics_Rotate(bbangle:Number):int{
	bb_graphics_Transform(Math.cos((bbangle)*0.0174532925),-Math.sin((bbangle)*0.0174532925),Math.sin((bbangle)*0.0174532925),Math.cos((bbangle)*0.0174532925),0.000000,0.000000);
	return 0;
}
internal function bb_graphics_Scale(bbx:Number,bby:Number):int{
	bb_graphics_Transform(bbx,0.000000,0.000000,bby,0.000000,0.000000);
	return 0;
}
internal function bb_graphics_DrawImage2(bbimage:bb_graphics_Image,bbx:Number,bby:Number,bbrotation:Number,bbscaleX:Number,bbscaleY:Number,bbframe:int):int{
	var bbf:bb_graphics_Frame=bbimage.bbframes[bbframe];
	bb_graphics_PushMatrix();
	bb_graphics_Translate(bbx,bby);
	bb_graphics_Rotate(bbrotation);
	bb_graphics_Scale(bbscaleX,bbscaleY);
	bb_graphics_Translate(-bbimage.bbtx,-bbimage.bbty);
	bb_graphics_ValidateMatrix();
	if((bbimage.bbflags&65536)!=0){
		bb_graphics_context.bbdevice.DrawSurface(bbimage.bbsurface,0.000000,0.000000);
	}else{
		bb_graphics_context.bbdevice.DrawSurface2(bbimage.bbsurface,0.000000,0.000000,bbf.bbx,bbf.bby,bbimage.bbwidth,bbimage.bbheight);
	}
	bb_graphics_PopMatrix();
	return 0;
}
class bb_point_Point extends Object{
	internal var bbx:Number=0;
	internal var bby:Number=0;
	internal function bbPoint_new(bbx:Number,bby:Number):bb_point_Point{
		this.bbx=bbx;
		this.bby=bby;
		return this;
	}
	internal function bbPoint_new2():bb_point_Point{
		return this;
	}
	internal function bbRotate(bbr:Number):void{
		var bbox:Number=this.bbx;
		var bboy:Number=this.bby;
		this.bbx=Math.cos((bbr)*0.0174532925)*bbox-Math.sin((bbr)*0.0174532925)*bboy;
		this.bby=Math.sin((bbr)*0.0174532925)*bbox+Math.cos((bbr)*0.0174532925)*bboy;
	}
}
internal function bb_math_Abs(bbx:int):int{
	if(bbx>=0){
		return bbx;
	}
	return -bbx;
}
internal function bb_math_Abs2(bbx:Number):Number{
	if(bbx>=0.000000){
		return bbx;
	}
	return -bbx;
}
internal function bb_graphics_SetFont(bbfont:bb_graphics_Image,bbfirstChar:int):int{
	if(!((bbfont)!=null)){
		if(!((bb_graphics_context.bbdefaultFont)!=null)){
			bb_graphics_context.bbdefaultFont=bb_graphics_LoadImage2("mojo_font.png",7,13,256,0);
		}
		bbfont=bb_graphics_context.bbdefaultFont;
		bbfirstChar=32;
	}
	bb_graphics_context.bbfont=bbfont;
	bb_graphics_context.bbfirstChar=bbfirstChar;
	return 0;
}
internal function bb_graphics_DrawText(bbtext:String,bbx:Number,bby:Number,bbxalign:Number,bbyalign:Number):int{
	if(!((bb_graphics_context.bbfont)!=null)){
		bb_graphics_SetFont(null,32);
	}
	if(!((bb_graphics_context.bbfont)!=null)){
		return 0;
	}
	if(!((bb_graphics_context.bbfont.bbLoaded())!=0)){
		return 0;
	}
	bbx=bbx-(bb_graphics_context.bbfont.bbWidth()*bbtext.length)*bbxalign;
	bby=bby-(bb_graphics_context.bbfont.bbHeight())*bbyalign;
	for(var bbi:int=0;bbi<bbtext.length;bbi=bbi+1){
		var bbch:int=bbtext.charCodeAt(bbi)-bb_graphics_context.bbfirstChar;
		if(bbch>=0 && bbch<bb_graphics_context.bbfont.bbFrames()){
			bb_graphics_DrawImage(bb_graphics_context.bbfont,bbx+(bbi*bb_graphics_context.bbfont.bbWidth()),bby,bbch);
		}
	}
	return 0;
}
internal function bb_graphics_Cls(bbr:Number,bbg:Number,bbb:Number):int{
	bb_graphics_context.bbdevice.Cls(bbr,bbg,bbb);
	return 0;
}
function bb_Init():void{
	bb_graphics_context=null;
	bb_input_device=null;
	bb_audio_device=null;
	bb_app_device=null;
	bb_graphics_Image.bbDefaultFlags=0;
	bb_resource_resources=(new bb_map_StringMap).bbStringMap_new();
	bb_soundplayer_SoundPlayer.bbsoundLaser=null;
	bb_soundplayer_SoundPlayer.bbsoundXplode=null;
	bb_bullet_Bullet.bbimg=null;
	bb_bullet_Bullet.bblist=null;
	bb_explosion_Explosion.bbimg=null;
	bb_explosion_Explosion.bblist=null;
	bb_ship_Ship.bbimage=null;
	bb_main_MyGame.bbscore=0;
	bb_asteroid_Asteroid.bblist=null;
	bb_random_Seed=1234;
	bb_asteroid_Asteroid.bbimage=new_object_array(3);
	bb_invalidaterect_InvalidateRect.bblist=null;
	bb_bullet_Bullet.bbcdown=0;
	bb_soundplayer_SoundPlayer.bbsoundCh=0;
}
//${END_CODE}
