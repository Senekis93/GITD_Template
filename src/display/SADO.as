package display{
    import flash.events.Event;
    import flash.display.Sprite;   

	public class SADO extends Sprite{
	
	private var event:String;

	public function SADO(e:String):void{
		event=e;
	}
	
	protected function done():void{
		dispatchEvent(new Event(event));
	}

	}
}



