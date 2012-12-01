package events{
    import flash.events.Event;   

	public class StateEvent extends Event{
		
		public static const
			MENU:String="m",
			GAME:String="g",
			CREDITS:String="c",
			CREDBACK:String="b",
			GAMEBACK:String="B",
			OPTIONS:String="o",
			OPTBACK:String="r",
			CONTROL:String="C";

	public function StateEvent(man:String):void{
		super(man,true,true);
	}	
	}
}