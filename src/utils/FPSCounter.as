package utils{
    import flash.display.Sprite;
    import flash.events.Event;
	import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getTimer;
	import flash.system.System;

    public class FPSCounter extends Sprite{
		
		private var 
			old:uint=getTimer(),
			f:uint,
			t:TextField;

	public function FPSCounter(C:uint=0xFFFFFF){
		t=new TextField();
		addChild(t);
		t.defaultTextFormat=new TextFormat("_serif",25,C,true);    
		t.selectable=false;
		t.width=0;
		t.autoSize="left";    
	}


	public function frame(e:Event=null):void {
		++f;
		const 
			T:uint=getTimer(),
			D:uint=T-old;
		if(D>999){
			/*const 
				m:String=(((System.totalMemory/1024)*001).toString());*/
			t.text=(f/D*1000).toFixed(1)+" FPS ";
			f=0;
			old=T;

		}
	}   
	
	}
}