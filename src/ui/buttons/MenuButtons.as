package ui.buttons{
	import flash.display.Sprite;
    import flash.events.Event; 	
	import events.StateEvent;
	import debug.Log;
	import utils.Utils;
	

	public class MenuButtons extends Sprite{
		
		private const
			OFF:int=160,
			SPEED:Number=15.0,
			C:int=Config.BUTTON_COLOR;			
		
		private var 
			play:Sprite,
			options:Sprite,
			credits:Sprite,
			buttons:Vector.<Sprite>=new <Sprite>[],
			t1:int,
			b:Boolean,
			f:Number=1.0,
			ml:Vector.<Object>=new <Object>[];

	public function MenuButtons():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);		
		createButton("play","Play",-OFF,230,"playRequested");
		if(Config.SHOW_OPTIONS)
			createButton("options","Options",stage.stageWidth,310,"configRequested");
		if(Config.SHOW_CREDITS)
			createButton("credits","Credits",-OFF,Config.SHOW_OPTIONS?390:310,"creditsRequested");
		t1=(stage.stageWidth-play.width)*.5;
		if(Config.DISABLE_ANIMATIONS){
				removeEventListener(Event.ENTER_FRAME,tween);
				var 
					ii:int=-1,
					ll:int=buttons.length;
				while(++ii<ll)
					buttons[ii].x=t1;
				return;
		}
		addEventListener(Event.ENTER_FRAME,tween);
	}
	
	private function tween(e:Event):void{		
		if(!ml)
			return;
		var 
			i:int,
			l:int=buttons.length,
			s:Sprite=buttons[0],
			X:int,
			t:Sprite;
		if(t1!=play.x){
			if(s.x<t1){
				i=-1;
				while(++i<l){
					X=buttons[i].x;
					buttons[i].x+=X<t1?SPEED:-SPEED;						
				}
			}
			if(s.x>t1){
				i=-1;
				while(++i<l)
					buttons[i].x=t1;
				removeEventListener(Event.ENTER_FRAME,tween);
			}
		}
		else removeEventListener(Event.ENTER_FRAME,tween);
	}
	
	private function createButton(p:String,n:String,x:int,y:int,f:String):void{		
		this[p]=ButtonCreator.b(n,x,y,C);
		var 
			b:Sprite=this[p];
		addChild(b);
		b.addEventListener("click",this[f]);
		ml[ml.length]={o:p,l:f};
		buttons[buttons.length]=b;
	}
	
	private function createCenteredButton(p:String,n:String,y:int,f:String):void{		
		this[p]=ButtonCreator.b(n,0,y,C);
		var 
			b:Sprite=this[p];
		addChild(b);
		Utils.center(b,stage,"x");
		b.addEventListener("click",this[f]);
		ml[ml.length]={o:p,l:f};
	}
	
	private function playRequested(e:Event):void{
		dispatchEvent(new StateEvent(StateEvent.GAME));
	}
	
	private function configRequested(e:Event):void{
		dispatchEvent(new StateEvent(StateEvent.OPTIONS));
	}	
	
	private function creditsRequested(e:Event):void{
		dispatchEvent(new StateEvent(StateEvent.CREDITS));
	}		

	private function die(e:Event):void{
		removeEventListener(Event.ENTER_FRAME,tween);
		removeEventListener(Event.REMOVED_FROM_STAGE,die);
		removeChildren();
		var 
			i:int=-1,
			l:int=ml.length;
		while(++i<l)
			this[ml[i].o].removeEventListener("click",this[ml[i].l]);
		ml=null;
		play=null;
		options=null;
		buttons=null;
	}
	
	}
}