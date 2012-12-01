package{
	import flash.display.Shape;
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.text.TextField;
	import flash.text.TextFormat;
	import data.Save;
	import debug.Log;

	public class Preview extends Sprite{
		
		private var t:TextField; // delete this

	public function Preview():void{
		draw(); // TODO Replace this with your own preview	
		// You can skip these tasks if you set SHOW_OPTIONS to false.
	}
	
	/* DELETE */
private function draw():void{var s:Shape=new Shape();s.graphics.beginFill(Config.TEXT_COLOR);s.graphics.drawRect(0,0,600,250);s.graphics.endFill();addChild(s);t=new TextField();t.width=0;t.autoSize="left";t.selectable=false;t.defaultTextFormat=new TextFormat("_sans",23,Config.BUTTON_COLOR,true);addChild(t);t.y=100;update(Save.file.data.quality);}	
private function die(e:Event):void{t=null;removeEventListener(Event.REMOVED_FROM_STAGE,die);removeChildren();}
	/*        */	
	
	
	public function frame():void{
		// TODO Update game preview
	}
	
	public function update(quality:int):void{
		// TODO Delete code below and apply quality change to your preview.
		t.text="Quality: "+(quality===3?"high":quality===2?"medium":"low");
		t.x=(width-t.width)*.5;
	}
	
		
	}
}