package display.logo{
	import flash.display.Bitmap;
    import flash.events.Event;
	import display.SADO;
   

	public class Intro extends SADO{	
		
	public function Intro(E:String):void{
		super(E);		
		// TODO Add your intro / logo here. 
		start(); // delete this line
		/* This is only required if you have the SHOW_INTRO property set to true.
		Make sure to call done(); when your intro is over.*/
	}
/*Delete this */	
[Embed(source="../../../lib/graphics/intro.png")]private const pic:Class;		
private var p:Bitmap=new pic();	
private function start():void{paintBack();addChild(p);p.alpha=0;p.x=(640-p.width)*.5;p.y=(480-p.height)*.5;addEventListener(Event.ENTER_FRAME,function(e:Event):void{if(p.alpha<1)p.alpha+=0.015;else done();});}	
private function paintBack():void{graphics.beginFill(Config.BACKGROUND_COLOR);graphics.drawRect(0,0,640,480);graphics.endFill();}	
/*           */	
	}
}