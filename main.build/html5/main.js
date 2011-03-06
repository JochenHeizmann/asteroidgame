
//Change this to true for a stretchy canvas!
//
var RESIZEABLE_CANVAS=false;

//Start us up!
//
window.onload=function( e ){

	if( RESIZEABLE_CANVAS ){
		window.onresize=function( e ){
			var canvas=document.getElementById( "GameCanvas" );

			//This vs window.innerWidth, which apparently doesn't account for scrollbar?
			var width=document.body.clientWidth;
			
			//This vs document.body.clientHeight, which does weird things - document seems to 'grow'...perhaps canvas resize pushing page down?
			var height=window.innerHeight;			

			canvas.width=width;
			canvas.height=height;
		}
		window.onresize( null );
	}
	
	var canvas=document.getElementById( "GameCanvas" );

	GameMain( canvas );
}

//${METADATA_BEGIN}
var META_DATA="[asteroidgame/asteroid1.png];type=image/png;width=30;height=27;\n[asteroidgame/asteroid2.png];type=image/png;width=85;height=85;\n[asteroidgame/asteroid3.png];type=image/png;width=25;height=23;\n[asteroidgame/bg.png];type=image/png;width=640;height=480;\n[asteroidgame/bullet.png];type=image/png;width=12;height=3;\n[asteroidgame/explosion.png];type=image/png;width=6144;height=192;\n[asteroidgame/laszer.wav];type=audio/x-wav;length=5926;hertz=44100;\n[asteroidgame/ship.png];type=image/png;width=24;height=28;\n[asteroidgame/xplode.wav];type=audio/x-wav;length=9648;hertz=8000;\n[mojo_font.png];type=image/png;width=448;height=52;\n";

//${METADATA_END}
function getMetaData( path,key ){	
	var i=META_DATA.indexOf( "["+path+"]" );
	if( i==-1 ) return "";
	i+=path.length+2;

	var e=META_DATA.indexOf( "\n",i );
	if( e==-1 ) e=META_DATA.length;

	i=META_DATA.indexOf( ";"+key+"=",i )
	if( i==-1 || i>=e ) return "";
	i+=key.length+2;

	e=META_DATA.indexOf( ";",i );
	if( e==-1 ) return "";

	return META_DATA.slice( i,e );
}

function loadString( path ){
	if( path=="" ) return "";
//${TEXTFILES_BEGIN}
		return "";

//${TEXTFILES_END}
}

//This is generally redefined by mojo.
//
function GameMain( canvas ){
	bb_Init();
	bb_Main();
}

//${TRANSCODE_BEGIN}

// Javascript Monkey runtime.
//
// Placed into the public domain 24/02/2011.
// No warranty implied; use at your own risk.

//***** JavaScript Runtime *****

var err_info="";
var err_stack=[];

function push_err(){
	err_stack.push( err_info );
}

function pop_err(){
	err_info=err_stack.pop();
}

function stackTrace(){
	var str="";
	push_err();
	err_stack.reverse();
	for( var i=0;i<err_stack.length;++i ){
		str+=err_stack[i]+"\n";
	}
	err_stack.reverse();
	pop_err();
	return str;
}

function print( str ){
	if( window.console!=undefined ){
		window.console.log( str );
	}
}

function error( err ){
	throw err;
}

function dbg_object( obj ){
	if( obj ) return obj;
	error( "Null object access" );
}

function dbg_array( arr,index ){
	if( index>=0 && index<arr.length ) return arr;
	error( "Array index out of range" );
}

function new_bool_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=false;
	return arr;
}

function new_number_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=0;
	return arr;
}

function new_string_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]='';
	return arr;
}

function new_array_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=[];
	return arr;
}

function new_object_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=null;
	return arr;
}

function resize_bool_array( arr,len ){
   var res=Array( len );
   var n=Math.min( arr.length,len );
   for( var i=0;i<n;++i ) res[i]=arr[i];
   for( var j=n;j<len;++j ) res[j]=false;
   return res;
}

function resize_number_array( arr,len ){
   var res=Array( len );
   var n=Math.min( arr.length,len );
   for( var i=0;i<n;++i ) res[i]=arr[i];
   for( var j=n;j<len;++j ) res[j]=0;
   return res;
}

function resize_string_array( arr,len ){
   var res=Array( len );
   var n=Math.min( arr.length,len );
   for( var i=0;i<n;++i ) res[i]=arr[i];
   for( var j=n;j<len;++j ) res[j]='';
   return res;
}

function resize_array_array( arr,len ){
   var res=Array( len );
   var n=Math.min( arr.length,len );
   for( var i=0;i<n;++i ) res[i]=arr[i];
   for( var j=n;j<len;++j ) res[j]=[];
   return res;
}

function resize_object_array( arr,len ){
   var res=Array( len );
   var n=Math.min( arr.length,len );
   for( var i=0;i<n;++i ) res[i]=arr[i];
   for( var j=n;j<len;++j ) res[j]=null;
   return res;
}

function string_join( sep,bits ){
	if( bits.length==0 ) return '';
	var str=bits[0];
	for( var i=1;i<bits.length;++i ) str+=sep+bits[i];
	return str;
}

function string_trim( str ){
	var i=0,i2=str.length;
	while( i<i2 && str.charCodeAt(i)<=32 ) i+=1;
	while( i2>i && str.charCodeAt(i2-1)<=32 ) i2-=1;
	return str.slice( i,i2 );
}

function string_starts_with( str,substr ){
	return substr.length<=str.length && str.slice(0,substr.length)==substr;
}

function string_ends_with( str,substr ){
	return substr.length<=str.length && str.slice(str.length-substr.length,str.length)==substr;
}

function object_downcast( obj,clas ){
	if( obj instanceof clas ) return obj;
	return null;
}

function extend_class( clas ){
	var tmp=function(){};
	tmp.prototype=clas.prototype;
	return new tmp;
}



// HTML5 mojo runtime.
//
// Copyright 2011 Mark Sibly, all rights reserved.
// No warranty implied; use at your own risk.

var dead=0;

var KEY_LMB=1;
var KEY_RMB=2;
var KEY_MMB=3;
var KEY_TOUCH0=0x180;

function die( ex ){
	dead=1;
	alert( ex+"\n"+stackTrace() );
	throw ex;
}

function eatEvent( e ){
	if( e.stopPropagation ){
		e.stopPropagation();
		e.preventDefault();
	}else{
		e.cancelBubble=true;
		e.returnValue=false;
	}
}

function keyToChar( key ){
	switch( key ){
	case 8:
	case 9:
	case 13:
	case 27:
	case 32:
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

function GameMain( canvas ){

	_app=null;
	_canvas=canvas;

	try{
		bb_Init();
		bb_Main();
	}catch( ex ){
		die( ex );
	}
	
	if( !_app ) return;
	
	var theApp=_app;

	_app=null;
	_canvas=null;
	
	canvas.onkeydown=function( e ){
		theApp.input.OnKeyDown( e.keyCode );
		var chr=keyToChar( e.keyCode );
		if( chr ) theApp.input.PutChar( chr );
		if( e.keyCode<48 || (e.keyCode>111 && e.keyCode<124) ) eatEvent( e );
	}

	canvas.onkeyup=function( e ){
		theApp.input.OnKeyUp( e.keyCode );
	}

	canvas.onkeypress=function( e ){
		if( e.charCode ){
			theApp.input.PutChar( e.charCode );
		}else if( e.which ){
			theApp.input.PutChar( e.which );
		}
	}
	
	canvas.onmousedown=function( e ){
		theApp.input.OnKeyDown( KEY_LMB );
		eatEvent( e );
	}
	
	canvas.onmouseup=function( e ){
		theApp.input.OnKeyUp( KEY_LMB );
		eatEvent( e );
	}
	
	canvas.onmouseout=function( e ){
		theApp.input.OnKeyUp( KEY_LMB );
		eatEvent( e );
	}

	canvas.onmousemove=function( e ){
		var x=e.clientX+document.body.scrollLeft;
		var y=e.clientY+document.body.scrollTop;
		var c=canvas;
		while( c ){
			x-=c.offsetLeft;
			y-=c.offsetTop;
			c=c.offsetParent;
		}
		theApp.input.OnMouseMove( x,y );
		eatEvent( e );
	}
/*
	canvas.onfocus=function( e ){
		theApp.InvokeOnResume();
	}
	
	canvas.onblur=function( e ){
		theApp.InvokeOnSuspend();
	}
*/		
	canvas.focus();

	theApp.InvokeOnCreate();
	theApp.InvokeOnRender();
}

//***** gxtkApp class *****

function gxtkApp(){

	_app=this;
	
	this.graphics=new gxtkGraphics( this,_canvas );
	this.input=new gxtkInput( this );
	this.audio=new gxtkAudio( this );

	this.loading=0;
	this.maxloading=0;

	this.updateRate=0;
	this.intervalObj=this.SetUpdateTimer( 100.0 );
	
	this.startMillis=(new Date).getTime();
	
	this.suspended=false;
}

gxtkApp.prototype.SetUpdateTimer=function( millis ){
	var theApp=this;
	function timerFired(){ 
		theApp.UpdateTimerFired(); 
	}
	return setInterval( timerFired,millis );
}

gxtkApp.prototype.UpdateTimerFired=function(){
	this.InvokeOnUpdate();
	this.InvokeOnRender();
}

gxtkApp.prototype.IncLoading=function(){

	++this.loading;

	if( this.loading>this.maxloading ) this.maxloading=this.loading;

	if( this.loading!=1 ) return;

	if( this.updateRate ){
		clearInterval( this.intervalObj );
		this.intervalObj=this.SetUpdateTimer( 100.0 );
	}
}

gxtkApp.prototype.DecLoading=function(){

	--this.loading;

	if( this.loading!=0 ) return;

	this.maxloading=0;

	if( this.updateRate ){
		clearInterval( this.intervalObj );
		this.intervalObj=this.SetUpdateTimer( 1000.0/this.updateRate );
	}
}

gxtkApp.prototype.GetMetaData=function( path,key ){
	return getMetaData( path,key );
}

gxtkApp.prototype.InvokeOnCreate=function(){
	if( dead ) return;
	
	try{
		this.OnCreate();
	}catch( ex ){
		die( ex );
	}
}

gxtkApp.prototype.InvokeOnUpdate=function(){
	if( dead || this.suspended ) return;
	
	try{
		this.input.BeginUpdate();
		if( this.updateRate && !this.loading ){
			this.OnUpdate();
		}
		this.input.EndUpdate();
	}catch( ex ){
		die( ex );
	}
}

gxtkApp.prototype.InvokeOnSuspend=function(){
	if( dead || this.suspended ) return;
	
	try{
		this.suspended=true;
		this.OnSuspend();
	}catch( ex ){
		die( ex );
	}
}

gxtkApp.prototype.InvokeOnResume=function(){
	if( dead || !this.suspended ) return;
	
	try{
		this.OnResume();
		this.suspended=false;
	}catch( ex ){
		die( ex );
	}
}

gxtkApp.prototype.InvokeOnRender=function(){
	if( dead || this.suspended ) return;
	
	try{
		this.graphics.BeginRender();
		if( this.loading ){
			this.OnLoading();
		}else{
			this.OnRender();
		}
		this.graphics.EndRender();
	}catch( ex ){
		die( ex );
	}
}

//***** GXTK API *****

gxtkApp.prototype.GraphicsDevice=function(){
	return this.graphics;
}

gxtkApp.prototype.InputDevice=function(){
	return this.input;
}

gxtkApp.prototype.AudioDevice=function(){
	return this.audio;
}

gxtkApp.prototype.AppTitle=function(){
	return document.URL;
}

gxtkApp.prototype.LoadState=function(){
	var state=localStorage.getItem( "gxtkapp@"+document.URL );
	if( state ) return state;
	return "";
}

gxtkApp.prototype.SaveState=function( state ){
	localStorage.setItem( "gxtkapp@"+document.URL,state );
}

gxtkApp.prototype.LoadString=function( path ){
	return loadString( path );
}

gxtkApp.prototype.SetUpdateRate=function( hertz ){

	this.updateRate=hertz;

	if( this.loading ) return;

	clearInterval( this.intervalObj );

	if( this.updateRate ){
		this.intervalObj=this.SetUpdateTimer( 1000.0/this.updateRate );
	}else{
		this.intervalObj=this.SetUpdateTimer( 100.0 );
	}
}

gxtkApp.prototype.MilliSecs=function(){
	return ((new Date).getTime()-this.startMillis)|0;
}

gxtkApp.prototype.Loading=function(){
	return this.loading;
}

gxtkApp.prototype.OnCreate=function(){
}

gxtkApp.prototype.OnUpdate=function(){
}

gxtkApp.prototype.OnSuspend=function(){
}

gxtkApp.prototype.OnResume=function(){
}

gxtkApp.prototype.OnRender=function(){
}

gxtkApp.prototype.OnLoading=function(){
}

//***** gxtkGraphics class *****

function gxtkGraphics( app,canvas ){
	this.app=app;
	this.canvas=canvas;
	this.gc=canvas.getContext( '2d' );
	this.color="rgb(255,255,255)"
	this.alpha=1.0;
	this.blend="source-over";
	this.ix=1;this.iy=0;
	this.jx=0;this.jy=1;
	this.tx=0;this.ty=0;
	this.tformed=false;
	this.scissorX=0;
	this.scissorY=0;
	this.scissorWidth=0;
	this.scissorHeight=0;
	this.clipped=false;
}

gxtkGraphics.prototype.BeginRender=function(){
	this.gc.save();
}

gxtkGraphics.prototype.EndRender=function(){
	this.gc.restore();
}

gxtkGraphics.prototype.Width=function(){
	return this.canvas.width;
}

gxtkGraphics.prototype.Height=function(){
	return this.canvas.height;
}

gxtkGraphics.prototype.LoadSurface=function( path ){
	var surface=new gxtkSurface( this );
	surface.Load( path );
	return surface;
}

gxtkGraphics.prototype.DestroySurface=function( surface ){
}

gxtkGraphics.prototype.SetAlpha=function( alpha ){
	this.alpha=alpha;
	this.gc.globalAlpha=alpha;
}

gxtkGraphics.prototype.SetColor=function( r,g,b ){
	this.color="rgb("+(r|0)+","+(g|0)+","+(b|0)+")";
	this.gc.fillStyle=this.color;
	this.gc.strokeStyle=this.color;
}

gxtkGraphics.prototype.SetBlend=function( blend ){
	switch( blend ){
	case 1:
		this.blend="lighter";
		break;
	default:
		this.blend="source-over";
	}
	this.gc.globalCompositeOperation=this.blend;
}

gxtkGraphics.prototype.SetScissor=function( x,y,w,h ){
	this.scissorX=x;
	this.scissorY=y;
	this.scissorWidth=w;
	this.scissorHeight=h;
	this.clipped=(x!=0 || y!=0 || w!=this.canvas.width && h!=this.canvas.height);
	this.gc.restore();
	this.gc.save();
	if( this.clipped ){
		this.gc.beginPath();
		this.gc.rect( x,y,w,h );
		this.gc.clip();
		this.gc.closePath();
	}
	this.gc.fillStyle=this.color;
	this.gc.strokeStyle=this.color;
	if( this.tformed ) this.gc.setTransform( this.ix,this.iy,this.jx,this.jy,this.tx,this.ty );
}

gxtkGraphics.prototype.SetMatrix=function( ix,iy,jx,jy,tx,ty ){
	this.ix=ix;this.iy=iy;
	this.jx=jx;this.jy=jy;
	this.tx=tx;this.ty=ty;
	this.gc.setTransform( ix,iy,jx,jy,tx,ty );
	this.tformed=(ix!=1 || iy!=0 || jx!=0 || jy!=1 || tx!=0 || ty!=0);
}

gxtkGraphics.prototype.Cls=function( r,g,b ){
	if( this.tformed ) this.gc.setTransform( 1,0,0,1,0,0 );
	this.gc.fillStyle="rgb("+(r|0)+","+(g|0)+","+(b|0)+")";
	this.gc.globalAlpha=1;
	this.gc.globalCompositeOperation="source-over";
	this.gc.fillRect( 0,0,this.canvas.width,this.canvas.height );
	this.gc.fillStyle=this.color;
	this.gc.globalAlpha=this.alpha;
	this.gc.globalCompositeOperation=this.blend;
	if( this.tformed ) this.gc.setTransform( this.ix,this.iy,this.jx,this.jy,this.tx,this.ty );
}

gxtkGraphics.prototype.DrawRect=function( x,y,w,h ){
	if( w<0 ){ x+=w;w=-w; }
	if( h<0 ){ y+=h;h=-h; }
	if( w<=0 || h<=0 ) return;			//Safari Kludge!
	//
	this.gc.fillRect( x,y,w,h );
}

gxtkGraphics.prototype.DrawLine=function( x1,y1,x2,y2 ){
  	this.gc.beginPath();
  	this.gc.moveTo( x1,y1 );
  	this.gc.lineTo( x2,y2 );
  	this.gc.stroke();
  	this.gc.closePath();
}

gxtkGraphics.prototype.DrawOval=function( x,y,w,h ){
	if( w<0 ){ x+=w;w=-w; }
	if( h<0 ){ y+=h;h=-h; }
	if( w<=0 || h<=0 ) return;			//Safari Kludge!
	//
  	var w2=w/2,h2=h/2;
	this.gc.save();
	this.gc.translate( x+w2,y+h2 );
	this.gc.scale( w2,h2 );
  	this.gc.beginPath();
	this.gc.arc( 0,0,1,0,Math.PI*2,false );
	this.gc.fill();
  	this.gc.closePath();
	this.gc.restore();
}

gxtkGraphics.prototype.DrawSurface=function( surface,x,y ){
	if( surface.loaded ) this.gc.drawImage( surface.image,x,y );
}

gxtkGraphics.prototype.DrawSurface2=function( surface,x,y,srcx,srcy,srcw,srch ){
	if( srcw<0 ){ srcx+=srcw;srcw=-srcw; }
	if( srch<0 ){ srcy+=srch;srch=-srch; }
	if( srcw<=0 || srch<=0 ) return;	//Safari Kludge!
	//
	if( surface.loaded ) this.gc.drawImage( surface.image,srcx,srcy,srcw,srch,x,y,srcw,srch );
}

//***** gxtkSurface class *****

function gxtkSurface( graphics ){
	this.graphics=graphics;
	this.swidth=0;
	this.sheight=0;
	this.image=null;
	this.loaded=0;
}

gxtkSurface.prototype.Load=function( path ){

	var ty=this.graphics.app.GetMetaData( path,"type" );
	if( ty.indexOf( "image/" )!=0 ) return;

	this.swidth=parseInt( this.graphics.app.GetMetaData( path,"width" ) );
	this.sheight=parseInt( this.graphics.app.GetMetaData( path,"height" ) );

	this.image=new Image();
	
	var surface=this;
	this.image.onload=function(){
		//executes in scope of HTML Image
		surface.loaded=1;
		surface.graphics.app.DecLoading();
	};

	this.graphics.app.IncLoading();

	this.image.src="data/"+path;
}

//***** GXTK API *****

gxtkSurface.prototype.Width=function(){
	return this.swidth;
}

gxtkSurface.prototype.Height=function(){
	return this.sheight;
}

gxtkSurface.prototype.Loaded=function(){
	return this.loaded;
}

//***** Class gxtkInput *****

function gxtkInput( app ){
	this.app=app;
	this.keyStates=new Array( 512 );
	this.charQueue=new Array( 32 );
	this.charPut=0;
	this.charGet=0;
	this.mouseX=0;
	this.mouseY=0;
	this.joyX=0;
	this.joyY=0;
	this.joyZ=0;
	this.accelX=0;
	this.accelY=0;
	this.accelZ=0;
	for( var i=0;i<512;++i ){
		this.keyStates[i]=0;
	}
}

gxtkInput.prototype.BeginUpdate=function(){
}

gxtkInput.prototype.EndUpdate=function(){
	for( var i=0;i<512;++i ){
		this.keyStates[i]&=0x100;
	}
	this.charGet=0;
	this.charPut=0;
}

gxtkInput.prototype.OnKeyDown=function( key ){
	if( (this.keyStates[key]&0x100)==0 ){
		this.keyStates[key]|=0x100;
		++this.keyStates[key];	
	}
}

gxtkInput.prototype.OnKeyUp=function( key ){
	this.keyStates[key]&=0xff;
}

gxtkInput.prototype.PutChar=function( char ){
	if( this.charPut-this.charGet<32 ){
		this.charQueue[this.charPut & 31]=char;
		this.charPut+=1;
	}
}

gxtkInput.prototype.OnMouseMove=function( x,y ){
	this.mouseX=x;
	this.mouseY=y;
}

//***** GXTK API *****

gxtkInput.prototype.KeyDown=function( key ){
	if( key>0 && key<512 ){
		if( key==KEY_TOUCH0 ) key=KEY_LMB;
		return this.keyStates[key] >> 8;
	}
	return 0;
}

gxtkInput.prototype.KeyHit=function( key ){
	if( key>0 && key<512 ){
		if( key==KEY_TOUCH0 ) key=KEY_LMB;
		return this.keyStates[key] & 0xff;
	}
	return 0;
}

gxtkInput.prototype.GetChar=function(){
	if( this.charPut!=this.charGet ){
		var char=this.charQueue[this.charGet & 31];
		this.charGet+=1;
		return char;
	}
	return 0;
}

gxtkInput.prototype.MouseX=function(){
	return this.mouseX;
}

gxtkInput.prototype.MouseY=function(){
	return this.mouseY;
}

gxtkInput.prototype.JoyX=function( index ){
	return this.joyX;
}

gxtkInput.prototype.JoyY=function( index ){
	return this.joyY;
}

gxtkInput.prototype.JoyZ=function( index ){
	return this.joyZ;
}

gxtkInput.prototype.TouchX=function( index ){
	return this.mouseX;
}

gxtkInput.prototype.TouchY=function( index ){
	return this.mouseY;
}

gxtkInput.prototype.AccelX=function(){
	return 0;
}

gxtkInput.prototype.AccelY=function(){
	return 0;
}

gxtkInput.prototype.AccelZ=function(){
	return 0;
}


//***** gxtkChannel class *****
function gxtkChannel(){
	this.audio=null;
	this.sample=null;
	this.volume=1;
	this.pan=0;
	this.rate=1;
}

//***** gxtkAudio class *****
function gxtkAudio( app ){
	this.app=app;
	this.okay=typeof(Audio)!="undefined";
	this.nextchan=0;
	this.channels=new Array(32);
	for( var i=0;i<32;++i ){
		this.channels[i]=new gxtkChannel();
	}
}

gxtkAudio.prototype.LoadSample=function( path ){
	if( !this.okay ) return new gxtkSample( null );
	
	var audio=new Audio( "data/"+path );
	return new gxtkSample( audio );
}

gxtkAudio.prototype.DestroySample=function( sample ){
}

gxtkAudio.prototype.PlaySample=function( sample,channel,flags ){
	if( !this.okay ) return;
	
	var chan=this.channels[channel];
	
	if( chan.sample==sample && chan.audio ){	//&& !chan.audio.paused ){
		chan.audio.loop=(flags&1)!=0;
		chan.audio.volume=chan.volume;
		try{
			chan.audio.currentTime=0;
		}catch(ex){
		}
		chan.audio.play();
		return;
	}

	if( chan.audio ) chan.audio.pause();
	
	var audio=sample.AllocAudio();
	
	if( audio ){
		for( var i=0;i<32;++i ){
			if( this.channels[i].audio==audio ){
				this.channels[i].audio=null;
				break;
			}
		}
		audio.loop=(flags&1)!=0;
		audio.volume=chan.volume;
		audio.play();
	}
	
	chan.audio=audio;
	chan.sample=sample;
}

gxtkAudio.prototype.StopChannel=function( channel ){
	var chan=this.channels[channel];
	if( chan.audio ) chan.audio.pause();
}

gxtkAudio.prototype.ChannelState=function( channel ){
	var chan=this.channels[channel];
	if( chan.audio && !chan.audio.paused && !chan.audio.ended ) return 1;
	return 0;
}

gxtkAudio.prototype.SetVolume=function( channel,volume ){
	var chan=this.channels[channel];
	if( chan.audio ) chan.audio.volume=volume;
	chan.volume=volume;
}

gxtkAudio.prototype.SetPan=function( channel,pan ){
	var chan=this.channels[channel];
	chan.pan=pan;
}

gxtkAudio.prototype.SetRate=function( channel,rate ){
	var chan=this.channels[channel];
	chan.rate=rate;
}

//***** gxtkSample class *****

function gxtkSample( audio ){
	this.audio=audio;
	this.insts=new Array( 8 );
}

gxtkSample.prototype.AllocAudio=function(){
	for( var i=0;i<8;++i ){
		var audio=this.insts[i];
		if( audio ){
			//Ok, this is ugly but seems to work best...no idea how/why!
			if( audio.paused ){
				if( audio.currentTime==0 ) return audio;
				audio.currentTime=0;
			}else if( audio.ended ){
				audio.pause();
			}
		}else{
			audio=new Audio( this.audio.src );
			this.insts[i]=audio;
			return audio;
		}
	}
	return null;
}
function bb_app_App(){
	Object.call(this);
}
function bb_app_App_new(){
	bb_app_device=bb_app_AppDevice_new.call(new bb_app_AppDevice,this);
	return this;
}
bb_app_App.prototype.bbOnCreate=function(){
	return 0;
}
bb_app_App.prototype.bbOnUpdate=function(){
	return 0;
}
bb_app_App.prototype.bbOnSuspend=function(){
	return 0;
}
bb_app_App.prototype.bbOnResume=function(){
	return 0;
}
bb_app_App.prototype.bbOnRender=function(){
	return 0;
}
bb_app_App.prototype.bbOnLoading=function(){
	return 0;
}
function bb_main_MyGame(){
	bb_app_App.call(this);
	this.bbbg=null;
	this.bbship=null;
}
bb_main_MyGame.prototype=extend_class(bb_app_App);
function bb_main_MyGame_new(){
	bb_app_App_new.call(this);
	return this;
}
var bb_main_MyGame_score;
bb_main_MyGame.prototype.bbInitNewGame=function(){
	bb_bullet_Bullet_Init();
	bb_explosion_Explosion_Init();
	bb_ship_Ship_Init();
	bb_main_MyGame_score=0;
	bb_asteroid_Asteroid_list=null;
	for(var bbi=0;bbi<=2;bbi=bbi+1){
		bb_asteroid_Asteroid_Spawn(bb_random_Rnd2(0.000000,(bb_graphics_DeviceWidth())),bb_random_Rnd2(0.000000,(bb_graphics_DeviceHeight())),0);
	}
}
bb_main_MyGame.prototype.bbOnCreate=function(){
	bb_app_SetUpdateRate(60);
	this.bbbg=bb_graphics_LoadImage("asteroidgame/bg.png",1,bb_graphics_Image_DefaultFlags);
	bb_soundplayer_SoundPlayer_Init();
	this.bbInitNewGame();
	bb_invalidaterect_InvalidateRect_Clear();
	bb_invalidaterect_InvalidateRect_Add(0,0,bb_graphics_DeviceWidth(),bb_graphics_DeviceHeight());
	return 1;
}
bb_main_MyGame.prototype.bbDoCollision=function(){
	var bbradius=0;
	var bb=bb_asteroid_Asteroid_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bba=object_downcast((bb.bbNextObject()),bb_asteroid_Asteroid);
		bbradius=(bb_asteroid_Asteroid_image[bba.bbsize].bbWidth());
		if(bb_helpers_Distance(this.bbship.bbx,this.bbship.bby,bba.bbx,bba.bby)<bbradius){
			bb_explosion_Explosion_Spawn(bba.bbx,bba.bby,1.000000);
			bb_explosion_Explosion_Spawn(this.bbship.bbx,this.bbship.bby,0.75);
			this.bbship=null;
			return;
		}
		var bb2=bb_bullet_Bullet_list.bbObjectEnumerator();
		while(bb2.bbHasNext()){
			var bbb=object_downcast((bb2.bbNextObject()),bb_bullet_Bullet);
			if(bb_helpers_Distance(bbb.bbx,bbb.bby,bba.bbx,bba.bby)<bbradius){
				var bb3=bba.bbsize;
				if(bb3==0){
					bb_explosion_Explosion_Spawn(bba.bbx,bba.bby,1.0);
					bb_asteroid_Asteroid_Spawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
					bb_asteroid_Asteroid_Spawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
					bb_asteroid_Asteroid_Spawn(bba.bbx+bb_random_Rnd2(-10.000000,10.000000),bba.bby+bb_random_Rnd2(-10.000000,10.000000),1);
				}else{
					if(bb3==1){
						bb_explosion_Explosion_Spawn(bba.bbx,bba.bby,.5);
						bb_asteroid_Asteroid_Spawn(bba.bbx+bb_random_Rnd2(-5.000000,5.000000),bba.bby+bb_random_Rnd2(-5.000000,5.000000),2);
						bb_asteroid_Asteroid_Spawn(bba.bbx+bb_random_Rnd2(-5.000000,5.000000),bba.bby+bb_random_Rnd2(-5.000000,5.000000),2);
					}else{
						if(bb3==2){
							bb_explosion_Explosion_Spawn(bba.bbx,bba.bby,.5);
							bb_asteroid_Asteroid_Spawn(bb_random_Rnd2(0.000000,(bb_graphics_DeviceWidth())),0.000000-bb_random_Rnd2(0.000000,30.000000),0);
							bb_main_MyGame_score+=100;
						}
					}
				}
				bbb.bbDestroy();
				bba.bbDestroy();
			}
		}
	}
}
bb_main_MyGame.prototype.bbOnUpdate=function(){
	if((this.bbship)!=null){
		this.bbship.bbUpdate();
	}else{
		if((bb_input_KeyHit(88))!=0){
			this.bbInitNewGame();
			this.bbship=bb_ship_Ship_new.call(new bb_ship_Ship);
		}
	}
	bb_bullet_Bullet_UpdateAll();
	bb_asteroid_Asteroid_UpdateAll();
	if((this.bbship)!=null){
		this.bbDoCollision();
	}
	bb_explosion_Explosion_UpdateAll();
	return 1;
}
bb_main_MyGame.prototype.bbRenderBG=function(){
	var bb=bb_invalidaterect_InvalidateRect_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbi=object_downcast((bb.bbNextObject()),bb_invalidaterect_InvalidateRect);
		bb_graphics_SetScissor((bbi.bbx),(bbi.bby),(bbi.bbw),(bbi.bbh));
		var bbx=0;
		var bby=0;
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
	bb_invalidaterect_InvalidateRect_Clear();
}
bb_main_MyGame.prototype.bbOnRender=function(){
	this.bbRenderBG();
	bb_asteroid_Asteroid_RenderAll();
	bb_bullet_Bullet_RenderAll();
	if((this.bbship)!=null){
		this.bbship.bbRender();
		bb_graphics_DrawText("Score: "+String(bb_main_MyGame_score),0.000000,0.000000,0.000000,0.000000);
		bb_invalidaterect_InvalidateRect_Add(0,0,100,25);
	}else{
		bb_graphics_DrawText("G A M E    O V E R - Y O U R    S C O R E: "+String(bb_main_MyGame_score),0.000000,0.000000,0.000000,0.000000);
		bb_graphics_DrawText("Press X to Start new Game",0.000000,25.000000,0.000000,0.000000);
		bb_graphics_DrawText("Instructions: Arrow Keys to move, X to fire!",0.000000,50.000000,0.000000,0.000000);
		bb_invalidaterect_InvalidateRect_Add(0,0,370,75);
	}
	bb_explosion_Explosion_RenderAll();
	return 1;
}
bb_main_MyGame.prototype.bbOnLoading=function(){
	bb_graphics_Cls(0.000000,0.000000,0.000000);
	bb_graphics_DrawText("Loading...",0.000000,0.000000,0.000000,0.000000);
	return 1;
}
function bb_app_AppDevice(){
	gxtkApp.call(this);
	this.bbapp=null;
}
bb_app_AppDevice.prototype=extend_class(gxtkApp);
function bb_app_AppDevice_new(bbapp){
	this.bbapp=bbapp;
	bb_graphics_SetGraphicsContext(bb_graphics_GraphicsContext_new.call(new bb_graphics_GraphicsContext,this.GraphicsDevice()));
	bb_input_SetInputDevice(this.InputDevice());
	bb_audio_SetAudioDevice(this.AudioDevice());
	return this;
}
function bb_app_AppDevice_new2(){
	return this;
}
bb_app_AppDevice.prototype.OnCreate=function(){
	return this.bbapp.bbOnCreate();
}
bb_app_AppDevice.prototype.OnUpdate=function(){
	return this.bbapp.bbOnUpdate();
}
bb_app_AppDevice.prototype.OnSuspend=function(){
	return this.bbapp.bbOnSuspend();
}
bb_app_AppDevice.prototype.OnResume=function(){
	return this.bbapp.bbOnResume();
}
bb_app_AppDevice.prototype.OnRender=function(){
	bb_graphics_BeginRender();
	var bbr=this.bbapp.bbOnRender();
	bb_graphics_EndRender();
	return bbr;
}
bb_app_AppDevice.prototype.OnLoading=function(){
	bb_graphics_BeginRender();
	var bbr=this.bbapp.bbOnLoading();
	bb_graphics_EndRender();
	return bbr;
}
function bb_graphics_GraphicsContext(){
	Object.call(this);
	this.bbdevice=null;
	this.bbmatrixSp=0;
	this.bbix=1.000000;
	this.bbiy=0;
	this.bbjx=0;
	this.bbjy=1.000000;
	this.bbtx=0;
	this.bbty=0;
	this.bbtformed=0;
	this.bbmatDirty=0;
	this.bbcolor_r=0;
	this.bbcolor_g=0;
	this.bbcolor_b=0;
	this.bbalpha=0;
	this.bbblend=0;
	this.bbscissor_x=0;
	this.bbscissor_y=0;
	this.bbscissor_width=0;
	this.bbscissor_height=0;
	this.bbmatrixStack=new_number_array(192);
	this.bbfont=null;
	this.bbdefaultFont=null;
	this.bbfirstChar=0;
}
function bb_graphics_GraphicsContext_new(bbdevice){
	this.bbdevice=bbdevice;
	return this;
}
function bb_graphics_GraphicsContext_new2(){
	return this;
}
var bb_graphics_context;
function bb_graphics_SetGraphicsContext(bbgc){
	bb_graphics_context=bbgc;
	return 0;
}
var bb_input_device;
function bb_input_SetInputDevice(bbdev){
	bb_input_device=bbdev;
	return 0;
}
var bb_audio_device;
function bb_audio_SetAudioDevice(bbdev){
	bb_audio_device=bbdev;
	return 0;
}
var bb_app_device;
function bb_Main(){
	bb_main_MyGame_new.call(new bb_main_MyGame);
}
function bb_graphics_SetMatrix(bbix,bbiy,bbjx,bbjy,bbtx,bbty){
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
function bb_graphics_SetMatrix2(bbm){
	bb_graphics_SetMatrix(bbm[0],bbm[1],bbm[2],bbm[3],bbm[4],bbm[5]);
	return 0;
}
function bb_graphics_SetColor(bbr,bbg,bbb){
	bb_graphics_context.bbcolor_r=bbr;
	bb_graphics_context.bbcolor_g=bbg;
	bb_graphics_context.bbcolor_b=bbb;
	bb_graphics_context.bbdevice.SetColor(bbr,bbg,bbb);
	return 0;
}
function bb_graphics_SetAlpha(bbalpha){
	bb_graphics_context.bbalpha=bbalpha;
	bb_graphics_context.bbdevice.SetAlpha(bbalpha);
	return 0;
}
function bb_graphics_SetBlend(bbblend){
	bb_graphics_context.bbblend=bbblend;
	bb_graphics_context.bbdevice.SetBlend(bbblend);
	return 0;
}
function bb_graphics_DeviceWidth(){
	return bb_graphics_context.bbdevice.Width();
}
function bb_graphics_DeviceHeight(){
	return bb_graphics_context.bbdevice.Height();
}
function bb_graphics_SetScissor(bbx,bby,bbwidth,bbheight){
	bb_graphics_context.bbscissor_x=bbx;
	bb_graphics_context.bbscissor_y=bby;
	bb_graphics_context.bbscissor_width=bbwidth;
	bb_graphics_context.bbscissor_height=bbheight;
	bb_graphics_context.bbdevice.SetScissor(((bbx)|0),((bby)|0),((bbwidth)|0),((bbheight)|0));
	return 0;
}
function bb_graphics_BeginRender(){
	bb_graphics_context.bbmatrixSp=0;
	bb_graphics_SetMatrix(1.000000,0.000000,0.000000,1.000000,0.000000,0.000000);
	bb_graphics_SetColor(255.000000,255.000000,255.000000);
	bb_graphics_SetAlpha(1.000000);
	bb_graphics_SetBlend(0);
	bb_graphics_SetScissor(0.000000,0.000000,(bb_graphics_DeviceWidth()),(bb_graphics_DeviceHeight()));
	return 0;
}
function bb_graphics_EndRender(){
	return 0;
}
function bb_app_SetUpdateRate(bbhertz){
	return bb_app_device.SetUpdateRate(bbhertz);
}
function bb_resource_Resource(){
	Object.call(this);
	this.bbnode=null;
	this.bbrefs=1;
}
function bb_resource_Resource_new(){
	return this;
}
bb_resource_Resource.prototype.bbRegister=function(bbtype){
	var bblist=object_downcast((bb_resource_resources.bbValueForKey(bb_boxes_StringObject_new3.call(new bb_boxes_StringObject,bbtype))),bb_list_List);
	if(!((bblist)!=null)){
		bblist=bb_list_List_new.call(new bb_list_List);
		bb_resource_resources.bbInsert((bb_boxes_StringObject_new3.call(new bb_boxes_StringObject,bbtype)),bblist);
	}
	this.bbnode=bblist.bbAddLast(this);
	return 0;
}
bb_resource_Resource.prototype.bbRetain=function(){
	this.bbrefs+=1;
	return 0;
}
function bb_graphics_Image(){
	bb_resource_Resource.call(this);
	this.bbsurface=null;
	this.bbwidth=0;
	this.bbheight=0;
	this.bbflags=0;
	this.bbframes=[];
	this.bbtx=0;
	this.bbty=0;
	this.bbsource=null;
}
bb_graphics_Image.prototype=extend_class(bb_resource_Resource);
var bb_graphics_Image_DefaultFlags;
bb_graphics_Image.prototype.bbSetHandle=function(bbtx,bbty){
	this.bbtx=bbtx;
	this.bbty=bbty;
	this.bbflags=this.bbflags&-2;
	return 0;
}
function bb_graphics_Image_new(bbpath,bbnframes,bbiflags){
	bb_resource_Resource_new.call(this);
	this.bbsurface=bb_graphics_context.bbdevice.LoadSurface(bbpath);
	if(!((this.bbsurface)!=null)){
		error("Failed to load image "+bbpath);
	}
	this.bbRegister("mojo.graphics.Image");
	this.bbwidth=((this.bbsurface.Width()/bbnframes)|0);
	this.bbheight=this.bbsurface.Height();
	this.bbflags=bbiflags;
	this.bbframes=new_object_array(bbnframes);
	for(var bbi=0;bbi<bbnframes;bbi=bbi+1){
		this.bbframes[bbi]=bb_graphics_Frame_new.call(new bb_graphics_Frame,bbi*this.bbwidth,0);
	}
	if(bbnframes==1){
		this.bbflags|=65536;
	}
	if((this.bbflags&1)!=0){
		this.bbSetHandle((this.bbwidth)/2.0,(this.bbheight)/2.0);
	}
	return this;
}
function bb_graphics_Image_new2(bbx,bby,bbiwidth,bbiheight,bbnframes,bbiflags,bbsource){
	bb_resource_Resource_new.call(this);
	this.bbRegister("mojo.graphics.Image");
	bbsource.bbRetain();
	this.bbsource=bbsource;
	this.bbsurface=bbsource.bbsurface;
	this.bbwidth=bbiwidth;
	this.bbheight=bbiheight;
	this.bbflags=bbiflags;
	this.bbframes=new_object_array(bbnframes);
	var bbix=bbx+bbsource.bbframes[0].bbx;
	var bbiy=bby+bbsource.bbframes[0].bby;
	for(var bbi=0;bbi<bbnframes;bbi=bbi+1){
		if(bbix+this.bbwidth>bbsource.bbwidth){
			bbix=bbsource.bbframes[0].bbx;
			bbiy+=this.bbheight;
		}
		this.bbframes[bbi]=bb_graphics_Frame_new.call(new bb_graphics_Frame,bbix,bbiy);
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
function bb_graphics_Image_new3(){
	bb_resource_Resource_new.call(this);
	return this;
}
bb_graphics_Image.prototype.bbGrabImage=function(bbx,bby,bbwidth,bbheight,bbframes,bbflags){
	if(this.bbframes.length!=1){
		return null;
	}
	return bb_graphics_Image_new2.call(new bb_graphics_Image,bbx,bby,bbwidth,bbheight,bbframes,bbflags,this);
}
bb_graphics_Image.prototype.bbWidth=function(){
	return this.bbwidth;
}
bb_graphics_Image.prototype.bbHandleX=function(){
	return this.bbtx;
}
bb_graphics_Image.prototype.bbHandleY=function(){
	return this.bbty;
}
bb_graphics_Image.prototype.bbHeight=function(){
	return this.bbheight;
}
bb_graphics_Image.prototype.bbLoaded=function(){
	return this.bbsurface.Loaded();
}
bb_graphics_Image.prototype.bbFrames=function(){
	return this.bbframes.length;
}
function bb_list_List(){
	Object.call(this);
	this.bb_head=bb_list_Node_new.call(new bb_list_Node);
}
function bb_list_List_new(){
	return this;
}
bb_list_List.prototype.bbAddLast=function(bbdata){
	return bb_list_Node_new2.call(new bb_list_Node,this.bb_head,this.bb_head.bb_pred,bbdata);
}
bb_list_List.prototype.bbCount=function(){
	var bbn=0;
	var bbnode=this.bb_head.bb_succ;
	while(bbnode!=this.bb_head){
		bbnode=bbnode.bb_succ;
		bbn+=1;
	}
	return bbn;
}
bb_list_List.prototype.bbObjectEnumerator=function(){
	return bb_list_Enumerator_new.call(new bb_list_Enumerator,this);
}
bb_list_List.prototype.bbEquals=function(bblhs,bbrhs){
	return ((bblhs==bbrhs)?1:0);
}
bb_list_List.prototype.bbRemoveEach=function(bbvalue){
	var bbnode=this.bb_head.bb_succ;
	while(bbnode!=this.bb_head){
		bbnode=bbnode.bb_succ;
		if(((this.bbEquals((bbnode.bb_pred.bb_data),(bbvalue)))!=0)){
			bbnode.bb_pred.bbRemove();
		}
	}
	return 0;
}
bb_list_List.prototype.bbRemove=function(bbvalue){
	this.bbRemoveEach(bbvalue);
	return 0;
}
function bb_boxes_StringObject(){
	Object.call(this);
	this.bbvalue="";
}
function bb_boxes_StringObject_new(bbvalue){
	this.bbvalue=String(bbvalue);
	return this;
}
function bb_boxes_StringObject_new2(bbvalue){
	this.bbvalue=String(bbvalue);
	return this;
}
function bb_boxes_StringObject_new3(bbvalue){
	this.bbvalue=bbvalue;
	return this;
}
function bb_boxes_StringObject_new4(){
	return this;
}
function bb_map_Map(){
	Object.call(this);
	this.bbroot=null;
}
function bb_map_Map_new(){
	return this;
}
bb_map_Map.prototype.bbCompare=function(bblhs,bbrhs){
	return 0;
}
bb_map_Map.prototype.bbFindNode=function(bbkey){
	var bbnode=this.bbroot;
	while((bbnode)!=null){
		var bbcmp=this.bbCompare((bbkey),(bbnode.bbkey));
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
bb_map_Map.prototype.bbGet=function(bbkey){
	var bbnode=this.bbFindNode(bbkey);
	if((bbnode)!=null){
		return bbnode.bbvalue;
	}
	return null;
}
bb_map_Map.prototype.bbValueForKey=function(bbkey){
	return this.bbGet(bbkey);
}
bb_map_Map.prototype.bbRotateLeft=function(bbnode){
	var bbchild=bbnode.bbright;
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
bb_map_Map.prototype.bbRotateRight=function(bbnode){
	var bbchild=bbnode.bbleft;
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
bb_map_Map.prototype.bbInsertFixup=function(bbnode){
	while(((bbnode.bbparent)!=null) && bbnode.bbparent.bbcolor==-1 && ((bbnode.bbparent.bbparent)!=null)){
		if(bbnode.bbparent==bbnode.bbparent.bbparent.bbleft){
			var bbuncle=bbnode.bbparent.bbparent.bbright;
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
			var bbuncle2=bbnode.bbparent.bbparent.bbleft;
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
bb_map_Map.prototype.bbSet=function(bbkey,bbvalue){
	var bbnode=this.bbroot;
	var bbparent=null;
	var bbcmp=0;
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
	bbnode=bb_map_Node_new.call(new bb_map_Node,bbkey,bbvalue,-1,bbparent);
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
bb_map_Map.prototype.bbInsert=function(bbkey,bbvalue){
	return this.bbSet(bbkey,bbvalue);
}
function bb_map_StringMap(){
	bb_map_Map.call(this);
}
bb_map_StringMap.prototype=extend_class(bb_map_Map);
function bb_map_StringMap_new(){
	bb_map_Map_new.call(this);
	return this;
}
bb_map_StringMap.prototype.bbCompare=function(bblhs,bbrhs){
	var bbl=object_downcast((bblhs),bb_boxes_StringObject).bbvalue;
	var bbr=object_downcast((bbrhs),bb_boxes_StringObject).bbvalue;
	if(bbl<bbr){
		return -1;
	}
	return ((bbl>bbr)?1:0);
}
var bb_resource_resources;
function bb_map_Node(){
	Object.call(this);
	this.bbkey=null;
	this.bbright=null;
	this.bbleft=null;
	this.bbvalue=null;
	this.bbcolor=0;
	this.bbparent=null;
}
function bb_map_Node_new(bbkey,bbvalue,bbcolor,bbparent){
	this.bbkey=bbkey;
	this.bbvalue=bbvalue;
	this.bbcolor=bbcolor;
	this.bbparent=bbparent;
	return this;
}
function bb_map_Node_new2(){
	return this;
}
function bb_list_Node(){
	Object.call(this);
	this.bb_succ=null;
	this.bb_pred=null;
	this.bb_data=null;
}
function bb_list_Node_new(){
	this.bb_succ=this;
	this.bb_pred=this;
	return this;
}
function bb_list_Node_new2(bbsucc,bbpred,bbdata){
	this.bb_succ=bbsucc;
	this.bb_pred=bbpred;
	this.bb_succ.bb_pred=this;
	this.bb_pred.bb_succ=this;
	this.bb_data=bbdata;
	return this;
}
bb_list_Node.prototype.bbRemove=function(){
	this.bb_succ.bb_pred=this.bb_pred;
	this.bb_pred.bb_succ=this.bb_succ;
	return 0;
}
function bb_graphics_Frame(){
	Object.call(this);
	this.bbx=0;
	this.bby=0;
}
function bb_graphics_Frame_new(bbx,bby){
	this.bbx=bbx;
	this.bby=bby;
	return this;
}
function bb_graphics_Frame_new2(){
	return this;
}
function bb_graphics_LoadImage(bbpath,bbframeCount,bbflags){
	return bb_graphics_Image_new.call(new bb_graphics_Image,bbpath,bbframeCount,bbflags);
}
function bb_graphics_LoadImage2(bbpath,bbframeWidth,bbframeHeight,bbframeCount,bbflags){
	var bbatlas=bb_graphics_Image_new.call(new bb_graphics_Image,bbpath,1,0);
	if((bbatlas)!=null){
		return bbatlas.bbGrabImage(0,0,bbframeWidth,bbframeHeight,bbframeCount,bbflags);
	}
	return null;
}
function bb_soundplayer_SoundPlayer(){
	Object.call(this);
}
var bb_soundplayer_SoundPlayer_soundLaser;
var bb_soundplayer_SoundPlayer_soundXplode;
function bb_soundplayer_SoundPlayer_Init(){
	bb_soundplayer_SoundPlayer_soundLaser=bb_audio_LoadSound("asteroidgame/laszer.wav");
	bb_soundplayer_SoundPlayer_soundXplode=bb_audio_LoadSound("asteroidgame/xplode.wav");
}
var bb_soundplayer_SoundPlayer_soundCh;
function bb_soundplayer_SoundPlayer_PlayFx(bbs){
	bb_soundplayer_SoundPlayer_soundCh+=1;
	if(bb_soundplayer_SoundPlayer_soundCh>8){
		bb_soundplayer_SoundPlayer_soundCh=0;
	}
	bb_audio_StopChannel(bb_soundplayer_SoundPlayer_soundCh);
	bb_audio_PlaySound(bbs,bb_soundplayer_SoundPlayer_soundCh,0);
}
function bb_audio_Sound(){
	bb_resource_Resource.call(this);
	this.bbsample=null;
}
bb_audio_Sound.prototype=extend_class(bb_resource_Resource);
function bb_audio_Sound_new(bbsample){
	bb_resource_Resource_new.call(this);
	this.bbsample=bbsample;
	if((bbsample)!=null){
		this.bbRegister("mojo.audio.Sound");
	}
	return this;
}
function bb_audio_Sound_new2(){
	bb_resource_Resource_new.call(this);
	return this;
}
function bb_audio_LoadSound(bbpath){
	var bbsample=bb_audio_device.LoadSample(bbpath);
	return bb_audio_Sound_new.call(new bb_audio_Sound,bbsample);
}
function bb_spaceobject_SpaceObject(){
	Object.call(this);
	this.bbx=0;
	this.bby=0;
	this.bbrotation=0;
	this.bbdx=0;
	this.bbdy=0;
}
function bb_spaceobject_SpaceObject_new(){
	return this;
}
function bb_bullet_Bullet(){
	bb_spaceobject_SpaceObject.call(this);
}
bb_bullet_Bullet.prototype=extend_class(bb_spaceobject_SpaceObject);
var bb_bullet_Bullet_img;
var bb_bullet_Bullet_list;
function bb_bullet_Bullet_Init(){
	if(!((bb_bullet_Bullet_img)!=null)){
		bb_bullet_Bullet_img=bb_graphics_LoadImage("asteroidgame/bullet.png",1,1);
	}
	if(!((bb_bullet_Bullet_list)!=null)){
		bb_bullet_Bullet_list=bb_list_List_new.call(new bb_list_List);
	}
}
var bb_bullet_Bullet_cdown;
function bb_bullet_Bullet_new(){
	bb_spaceobject_SpaceObject_new.call(this);
	return this;
}
function bb_bullet_Bullet_Spawn(bbx,bby,bbr,bbspeedx,bbspeedy){
	if(bb_bullet_Bullet_cdown>15){
		var bbs=bb_bullet_Bullet_new.call(new bb_bullet_Bullet);
		bbs.bbx=bbx;
		bbs.bby=bby;
		bbs.bbdx=Math.cos((bbr)*0.0174532925)*6.0+bbspeedx;
		bbs.bbdy=Math.sin((bbr)*0.0174532925)*6.0+bbspeedy;
		bbs.bbrotation=-bbr;
		bb_bullet_Bullet_list.bbAddLast(bbs);
		bb_bullet_Bullet_cdown=0;
		bb_soundplayer_SoundPlayer_PlayFx(bb_soundplayer_SoundPlayer_soundLaser);
	}
}
bb_bullet_Bullet.prototype.bbDestroy=function(){
	bb_bullet_Bullet_list.bbRemove(this);
}
bb_bullet_Bullet.prototype.bbUpdate=function(){
	this.bbx+=this.bbdx;
	this.bby+=this.bbdy;
	if(this.bbx<-20.000000 || this.bbx>(bb_graphics_DeviceWidth()+20) || this.bby<-20.000000 || this.bby>(bb_graphics_DeviceHeight()+20)){
		this.bbDestroy();
	}
}
function bb_bullet_Bullet_UpdateAll(){
	bb_bullet_Bullet_cdown+=1;
	var bb=bb_bullet_Bullet_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbb=object_downcast((bb.bbNextObject()),bb_bullet_Bullet);
		bbb.bbUpdate();
	}
}
bb_bullet_Bullet.prototype.bbRender=function(){
	bb_invalidaterect_InvalidateRect_Draw(bb_bullet_Bullet_img,this.bbx,this.bby,this.bbrotation,1.000000,1.000000,0);
}
function bb_bullet_Bullet_RenderAll(){
	var bb=bb_bullet_Bullet_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbb=object_downcast((bb.bbNextObject()),bb_bullet_Bullet);
		bbb.bbRender();
	}
}
function bb_explosion_Explosion(){
	Object.call(this);
	this.bbscale=0;
	this.bbx=0;
	this.bby=0;
	this.bbframe=0;
}
var bb_explosion_Explosion_img;
var bb_explosion_Explosion_list;
function bb_explosion_Explosion_Init(){
	if(!((bb_explosion_Explosion_img)!=null)){
		bb_explosion_Explosion_img=bb_graphics_LoadImage("asteroidgame/explosion.png",32,1);
	}
	if(!((bb_explosion_Explosion_list)!=null)){
		bb_explosion_Explosion_list=bb_list_List_new.call(new bb_list_List);
	}
}
function bb_explosion_Explosion_new(){
	this.bbscale=1.000000;
	return this;
}
function bb_explosion_Explosion_Spawn(bbx,bby,bbscale){
	var bbe=bb_explosion_Explosion_new.call(new bb_explosion_Explosion);
	bbe.bbx=bbx;
	bbe.bby=bby;
	bbe.bbscale=bbscale;
	bb_explosion_Explosion_list.bbAddLast(bbe);
	bb_soundplayer_SoundPlayer_PlayFx(bb_soundplayer_SoundPlayer_soundXplode);
}
bb_explosion_Explosion.prototype.bbDestroy=function(){
	bb_explosion_Explosion_list.bbRemove(this);
}
bb_explosion_Explosion.prototype.bbUpdate=function(){
	this.bbframe+=1;
	if(this.bbframe>=32){
		this.bbDestroy();
	}
}
function bb_explosion_Explosion_UpdateAll(){
	var bb=bb_explosion_Explosion_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbe=object_downcast((bb.bbNextObject()),bb_explosion_Explosion);
		bbe.bbUpdate();
	}
}
bb_explosion_Explosion.prototype.bbRender=function(){
	bb_invalidaterect_InvalidateRect_Draw(bb_explosion_Explosion_img,this.bbx,this.bby,0.000000,this.bbscale,this.bbscale,this.bbframe % 32);
}
function bb_explosion_Explosion_RenderAll(){
	var bb=bb_explosion_Explosion_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbe=object_downcast((bb.bbNextObject()),bb_explosion_Explosion);
		bbe.bbRender();
	}
}
function bb_ship_Ship(){
	bb_spaceobject_SpaceObject.call(this);
	this.bbturnSpeed=0;
}
bb_ship_Ship.prototype=extend_class(bb_spaceobject_SpaceObject);
var bb_ship_Ship_image;
function bb_ship_Ship_Init(){
	if(!((bb_ship_Ship_image)!=null)){
		bb_ship_Ship_image=bb_graphics_LoadImage("asteroidgame/ship.png",1,1);
	}
}
bb_ship_Ship.prototype.bbUpdate=function(){
	if((bb_input_KeyDown(88))!=0){
		bb_bullet_Bullet_Spawn(this.bbx,this.bby,this.bbrotation,this.bbdx,this.bbdy);
	}
	if((bb_input_KeyDown(38))!=0){
		this.bbdx+=Math.cos((this.bbrotation)*0.0174532925)*0.08;
		this.bbdy+=Math.sin((this.bbrotation)*0.0174532925)*0.08;
	}
	if((bb_input_KeyDown(40))!=0){
		this.bbdx-=Math.cos((this.bbrotation)*0.0174532925)*0.08;
		this.bbdy-=Math.sin((this.bbrotation)*0.0174532925)*0.08;
	}
	var bbspeedVectorLength=Math.sqrt(this.bbdx*this.bbdx+this.bbdy*this.bbdy);
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
function bb_ship_Ship_new(){
	bb_spaceobject_SpaceObject_new.call(this);
	this.bbx=300.000000;
	this.bby=400.000000;
	return this;
}
bb_ship_Ship.prototype.bbRender=function(){
	bb_invalidaterect_InvalidateRect_Draw(bb_ship_Ship_image,this.bbx,this.bby,-this.bbrotation,1.000000,1.000000,0);
}
function bb_asteroid_Asteroid(){
	bb_spaceobject_SpaceObject.call(this);
	this.bbsize=0;
}
bb_asteroid_Asteroid.prototype=extend_class(bb_spaceobject_SpaceObject);
var bb_asteroid_Asteroid_list;
var bb_asteroid_Asteroid_image;
function bb_asteroid_Asteroid_new(){
	bb_spaceobject_SpaceObject_new.call(this);
	if(!((bb_asteroid_Asteroid_image[2])!=null)){
		bb_asteroid_Asteroid_image[2]=bb_graphics_LoadImage("asteroidgame/asteroid3.png",1,1);
	}
	if(!((bb_asteroid_Asteroid_image[1])!=null)){
		bb_asteroid_Asteroid_image[1]=bb_graphics_LoadImage("asteroidgame/asteroid1.png",1,1);
	}
	if(!((bb_asteroid_Asteroid_image[0])!=null)){
		bb_asteroid_Asteroid_image[0]=bb_graphics_LoadImage("asteroidgame/asteroid2.png",1,1);
	}
	return this;
}
function bb_asteroid_Asteroid_Spawn(bbx,bby,bbsize){
	var bbasteroid=bb_asteroid_Asteroid_new.call(new bb_asteroid_Asteroid);
	if(!((bb_asteroid_Asteroid_list)!=null)){
		bb_asteroid_Asteroid_list=bb_list_List_new.call(new bb_list_List);
	}
	if(bb_asteroid_Asteroid_list.bbCount()<25){
		var bbspeed=0.000000;
		var bb=bbsize;
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
		bb_asteroid_Asteroid_list.bbAddLast(bbasteroid);
	}
}
bb_asteroid_Asteroid.prototype.bbUpdate=function(){
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
function bb_asteroid_Asteroid_UpdateAll(){
	if(!((bb_asteroid_Asteroid_list)!=null)){
		return;
	}
	var bb=bb_asteroid_Asteroid_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbasteroid=object_downcast((bb.bbNextObject()),bb_asteroid_Asteroid);
		bbasteroid.bbUpdate();
	}
}
bb_asteroid_Asteroid.prototype.bbDestroy=function(){
	bb_asteroid_Asteroid_list.bbRemove(this);
}
bb_asteroid_Asteroid.prototype.bbRender=function(){
	var bbscale=1.000000;
	var bb=this.bbsize;
	if(bb==0){
		this.bbrotation+=0.2;
		bb_invalidaterect_InvalidateRect_Add(((this.bbx-50.000000)|0),((this.bby-50.000000)|0),100,100);
	}else{
		if(bb==1){
			this.bbrotation+=0.5;
			bb_invalidaterect_InvalidateRect_Add(((this.bbx-20.000000)|0),((this.bby-20.000000)|0),40,40);
		}else{
			if(bb==2){
				this.bbrotation+=1.2;
				bb_invalidaterect_InvalidateRect_Add(((this.bbx-20.000000)|0),((this.bby-20.000000)|0),40,40);
			}
		}
	}
	bb_invalidaterect_InvalidateRect_Draw(bb_asteroid_Asteroid_image[this.bbsize],this.bbx,this.bby,this.bbrotation,bbscale,bbscale,0);
}
function bb_asteroid_Asteroid_RenderAll(){
	if(!((bb_asteroid_Asteroid_list)!=null)){
		return;
	}
	var bb=bb_asteroid_Asteroid_list.bbObjectEnumerator();
	while(bb.bbHasNext()){
		var bbasteroid=object_downcast((bb.bbNextObject()),bb_asteroid_Asteroid);
		bbasteroid.bbRender();
	}
}
var bb_random_Seed;
function bb_random_Rnd(){
	bb_random_Seed=bb_random_Seed*1664525+1013904223|0;
	return (((bb_random_Seed/4)|0)&1073741823)/1073741824.0000;
}
function bb_random_Rnd2(bblow,bbhigh){
	return bb_random_Rnd3(bbhigh-bblow)+bblow;
}
function bb_random_Rnd3(bbrange){
	return bb_random_Rnd()*bbrange;
}
function bb_invalidaterect_InvalidateRect(){
	Object.call(this);
	this.bbx=0;
	this.bby=0;
	this.bbw=0;
	this.bbh=0;
}
var bb_invalidaterect_InvalidateRect_list;
function bb_invalidaterect_InvalidateRect_Clear(){
	bb_invalidaterect_InvalidateRect_list=bb_list_List_new.call(new bb_list_List);
}
function bb_invalidaterect_InvalidateRect_new(){
	return this;
}
function bb_invalidaterect_InvalidateRect_Add(bbx,bby,bbw,bbh){
	var bbi=bb_invalidaterect_InvalidateRect_new.call(new bb_invalidaterect_InvalidateRect);
	bbi.bbx=bbx;
	bbi.bby=bby;
	bbi.bbw=bbw;
	bbi.bbh=bbh;
	bb_invalidaterect_InvalidateRect_list.bbAddLast(bbi);
}
function bb_invalidaterect_InvalidateRect_Draw(bbi,bbx,bby,bbr,bbsx,bbsy,bbframe){
	var bbp=new_object_array(4);
	bbp[0]=bb_point_Point_new.call(new bb_point_Point,-bbi.bbHandleX(),-bbi.bbHandleY());
	bbp[1]=bb_point_Point_new.call(new bb_point_Point,bbp[0].bbx+(bbi.bbWidth()),bbp[0].bby+(bbi.bbHeight()));
	bbp[2]=bb_point_Point_new.call(new bb_point_Point,bbp[0].bbx,bbp[1].bby);
	bbp[3]=bb_point_Point_new.call(new bb_point_Point,bbp[1].bbx,bbp[0].bby);
	for(var bbi2=0;bbi2<=3;bbi2=bbi2+1){
		bbp[bbi2].bbRotate(-bbr);
	}
	var bbdx=0.000000;
	var bbdy=0.000000;
	for(var bbi3=0;bbi3<=3;bbi3=bbi3+1){
		var bbtd=bb_helpers_Distance(0.000000,0.000000,bbp[bbi3].bbx,0.000000);
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
	bb_invalidaterect_InvalidateRect_Add(((-bbdx+bbx)|0),((-bbdy+bby)|0),((bbdx*2.000000)|0),((bbdy*2.000000)|0));
	bb_graphics_DrawImage2(bbi,bbx,bby,bbr,bbsx,bbsy,bbframe);
}
function bb_input_KeyDown(bbkey){
	return bb_input_device.KeyDown(bbkey);
}
function bb_audio_StopChannel(bbchannel){
	bb_audio_device.StopChannel(bbchannel);
	return 0;
}
function bb_audio_PlaySound(bbsound,bbchannel,bbflags){
	if((bbsound.bbsample)!=null){
		bb_audio_device.PlaySample(bbsound.bbsample,bbchannel,bbflags);
	}
	return 0;
}
function bb_input_KeyHit(bbkey){
	return bb_input_device.KeyHit(bbkey);
}
function bb_list_Enumerator(){
	Object.call(this);
	this.bb_list=null;
	this.bb_curr=null;
}
function bb_list_Enumerator_new(bblist){
	this.bb_list=bblist;
	this.bb_curr=bblist.bb_head.bb_succ;
	return this;
}
function bb_list_Enumerator_new2(){
	return this;
}
bb_list_Enumerator.prototype.bbHasNext=function(){
	return this.bb_curr!=this.bb_list.bb_head;
}
bb_list_Enumerator.prototype.bbNextObject=function(){
	var bbdata=this.bb_curr.bb_data;
	this.bb_curr=this.bb_curr.bb_succ;
	return bbdata;
}
function bb_helpers_Distance(bbx1,bby1,bbx2,bby2){
	var bbdx=bbx2-bbx1;
	var bbdy=bby2-bby1;
	return Math.sqrt(bbdx*bbdx+bbdy*bbdy);
}
function bb_graphics_PushMatrix(){
	var bbsp=bb_graphics_context.bbmatrixSp;
	bb_graphics_context.bbmatrixStack[bbsp+0]=bb_graphics_context.bbix;
	bb_graphics_context.bbmatrixStack[bbsp+1]=bb_graphics_context.bbiy;
	bb_graphics_context.bbmatrixStack[bbsp+2]=bb_graphics_context.bbjx;
	bb_graphics_context.bbmatrixStack[bbsp+3]=bb_graphics_context.bbjy;
	bb_graphics_context.bbmatrixStack[bbsp+4]=bb_graphics_context.bbtx;
	bb_graphics_context.bbmatrixStack[bbsp+5]=bb_graphics_context.bbty;
	bb_graphics_context.bbmatrixSp=bbsp+6;
	return 0;
}
function bb_graphics_Transform(bbix,bbiy,bbjx,bbjy,bbtx,bbty){
	var bbix2=bbix*bb_graphics_context.bbix+bbiy*bb_graphics_context.bbjx;
	var bbiy2=bbix*bb_graphics_context.bbiy+bbiy*bb_graphics_context.bbjy;
	var bbjx2=bbjx*bb_graphics_context.bbix+bbjy*bb_graphics_context.bbjx;
	var bbjy2=bbjx*bb_graphics_context.bbiy+bbjy*bb_graphics_context.bbjy;
	var bbtx2=bbtx*bb_graphics_context.bbix+bbty*bb_graphics_context.bbjx+bb_graphics_context.bbtx;
	var bbty2=bbtx*bb_graphics_context.bbiy+bbty*bb_graphics_context.bbjy+bb_graphics_context.bbty;
	bb_graphics_SetMatrix(bbix2,bbiy2,bbjx2,bbjy2,bbtx2,bbty2);
	return 0;
}
function bb_graphics_Transform2(bbcoords){
	var bbout=new_number_array(bbcoords.length);
	for(var bbi=0;bbi<bbcoords.length-1;bbi=bbi+2){
		var bbx=bbcoords[bbi];
		var bby=bbcoords[bbi+1];
		bbout[bbi]=bbx*bb_graphics_context.bbix+bby*bb_graphics_context.bbjx+bb_graphics_context.bbtx;
		bbout[bbi+1]=bbx*bb_graphics_context.bbiy+bby*bb_graphics_context.bbjy+bb_graphics_context.bbty;
	}
	return bbout;
}
function bb_graphics_Translate(bbx,bby){
	bb_graphics_Transform(1.000000,0.000000,0.000000,1.000000,bbx,bby);
	return 0;
}
function bb_graphics_ValidateMatrix(){
	if((bb_graphics_context.bbmatDirty)!=0){
		bb_graphics_context.bbdevice.SetMatrix(bb_graphics_context.bbix,bb_graphics_context.bbiy,bb_graphics_context.bbjx,bb_graphics_context.bbjy,bb_graphics_context.bbtx,bb_graphics_context.bbty);
		bb_graphics_context.bbmatDirty=0;
	}
	return 0;
}
function bb_graphics_PopMatrix(){
	var bbsp=bb_graphics_context.bbmatrixSp-6;
	bb_graphics_SetMatrix(bb_graphics_context.bbmatrixStack[bbsp+0],bb_graphics_context.bbmatrixStack[bbsp+1],bb_graphics_context.bbmatrixStack[bbsp+2],bb_graphics_context.bbmatrixStack[bbsp+3],bb_graphics_context.bbmatrixStack[bbsp+4],bb_graphics_context.bbmatrixStack[bbsp+5]);
	bb_graphics_context.bbmatrixSp=bbsp;
	return 0;
}
function bb_graphics_DrawImage(bbimage,bbx,bby,bbframe){
	var bbf=bbimage.bbframes[bbframe];
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
function bb_graphics_Rotate(bbangle){
	bb_graphics_Transform(Math.cos((bbangle)*0.0174532925),-Math.sin((bbangle)*0.0174532925),Math.sin((bbangle)*0.0174532925),Math.cos((bbangle)*0.0174532925),0.000000,0.000000);
	return 0;
}
function bb_graphics_Scale(bbx,bby){
	bb_graphics_Transform(bbx,0.000000,0.000000,bby,0.000000,0.000000);
	return 0;
}
function bb_graphics_DrawImage2(bbimage,bbx,bby,bbrotation,bbscaleX,bbscaleY,bbframe){
	var bbf=bbimage.bbframes[bbframe];
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
function bb_point_Point(){
	Object.call(this);
	this.bbx=0;
	this.bby=0;
}
function bb_point_Point_new(bbx,bby){
	this.bbx=bbx;
	this.bby=bby;
	return this;
}
function bb_point_Point_new2(){
	return this;
}
bb_point_Point.prototype.bbRotate=function(bbr){
	var bbox=this.bbx;
	var bboy=this.bby;
	this.bbx=Math.cos((bbr)*0.0174532925)*bbox-Math.sin((bbr)*0.0174532925)*bboy;
	this.bby=Math.sin((bbr)*0.0174532925)*bbox+Math.cos((bbr)*0.0174532925)*bboy;
}
function bb_math_Abs(bbx){
	if(bbx>=0){
		return bbx;
	}
	return -bbx;
}
function bb_math_Abs2(bbx){
	if(bbx>=0.000000){
		return bbx;
	}
	return -bbx;
}
function bb_graphics_SetFont(bbfont,bbfirstChar){
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
function bb_graphics_DrawText(bbtext,bbx,bby,bbxalign,bbyalign){
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
	for(var bbi=0;bbi<bbtext.length;bbi=bbi+1){
		var bbch=bbtext.charCodeAt(bbi)-bb_graphics_context.bbfirstChar;
		if(bbch>=0 && bbch<bb_graphics_context.bbfont.bbFrames()){
			bb_graphics_DrawImage(bb_graphics_context.bbfont,bbx+(bbi*bb_graphics_context.bbfont.bbWidth()),bby,bbch);
		}
	}
	return 0;
}
function bb_graphics_Cls(bbr,bbg,bbb){
	bb_graphics_context.bbdevice.Cls(bbr,bbg,bbb);
	return 0;
}
function bb_Init(){
	bb_graphics_context=null;
	bb_input_device=null;
	bb_audio_device=null;
	bb_app_device=null;
	bb_graphics_Image_DefaultFlags=0;
	bb_resource_resources=bb_map_StringMap_new.call(new bb_map_StringMap);
	bb_soundplayer_SoundPlayer_soundLaser=null;
	bb_soundplayer_SoundPlayer_soundXplode=null;
	bb_bullet_Bullet_img=null;
	bb_bullet_Bullet_list=null;
	bb_explosion_Explosion_img=null;
	bb_explosion_Explosion_list=null;
	bb_ship_Ship_image=null;
	bb_main_MyGame_score=0;
	bb_asteroid_Asteroid_list=null;
	bb_random_Seed=1234;
	bb_asteroid_Asteroid_image=new_object_array(3);
	bb_invalidaterect_InvalidateRect_list=null;
	bb_bullet_Bullet_cdown=0;
	bb_soundplayer_SoundPlayer_soundCh=0;
}
//${TRANSCODE_END}

//This overrides print in 'std.lang/lang.js'
//
function print( str ){

	var cons=document.getElementById( "GameConsole" );
	if( cons ){
		cons.value+=str+"\n";
	}
	
	if( window.console!=undefined ){
		window.console.log( str );
	}
}

