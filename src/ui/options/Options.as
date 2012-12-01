package ui.options{
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import audio.MusicPlayer;
	import data.Save;
	import debug.Log;
	import events.StateEvent;		
	import ui.buttons.ButtonCreator;
	import utils.FPSCounter;
	import utils.Utils;

	public class Options extends Sprite{
		private var
			cm:Boolean,
			con:Controls,
			c:Sprite,
			q:Vector.<Sprite>,
			m:Sprite,
			d:Sprite,
			fps:FPSCounter,
			preview:Preview;
		
		private const
			C:int=Config.BUTTON_COLOR,	
			C1:int=Config.BACKGROUND_COLOR, 
			C2:int=Config.TEXT_COLOR;

	public function Options():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);
		draw();
	}
	
	private function draw():void{
		graphics.beginFill(C1);
		graphics.drawRect(0,0,640,480);
		graphics.endFill();		
		fps=new FPSCounter(C2);
		addChild(fps);
		graphics.lineStyle(3,C2);
		graphics.beginFill(0,0);
		graphics.drawRect(20,20,600,120);
		graphics.endFill();
		preview=new Preview();
		addChild(preview);
		preview.y=143;
		preview.x=(640-preview.width)*.5;
		preview.height=250;
		var 
			t:TextField=new TextField();
		t.selectable=false;
		t.width=0;
		t.autoSize="left";
		t.text="Quality settings         ";
		addChild(t);
		t.y=20;		
		t.setTextFormat(new TextFormat("_typewriter",24,C2,true));
		//Utils.center(t,stage,"x");
		t.x=(stage.stageWidth-t.width)*.5;
		fps.y=t.y-fps.height*.5;
		fps.x=400;
		q=new <Sprite>[ButtonCreator.b("low",60,70,C),
					   ButtonCreator.b("medium",240,70,C),
					   ButtonCreator.b("high",420,70,C)];
		var 
			i:int=-1,
			l:int=q.length;
		while(++i<l)
			addChild(q[i]);
		stage.addEventListener(MouseEvent.CLICK,click);
		m=ButtonCreator.b("Music",30,400,C);
		d=ButtonCreator.b("Back",460,400,C);
		if(Config.SHOW_CONTROLS)
			c=ButtonCreator.b("Controls",240,400,C),
			addChild(c);
		addChild(m);
		addChild(d);		
		if(!Config.DISABLE_ANIMATIONS)
			d.alpha=0;
	}
	
	public function start():void{
		addEventListener(Event.ENTER_FRAME,f);
	}
	
	private function f(e:Event):void{
		fps.frame();		
		if(d.alpha<1)
			d.alpha+=0.07;
		preview.frame();
	}
	
	
	private function click(e:MouseEvent):void{
		if(cm){
			if(!con)
				cm=false;
			return;
		}
		var 
			i:int=-1,
			l:int=q.length,
			X:int=e.stageX,
			Y:int=e.stageY,
			t:Sprite;
		while(++i<l){
			t=q[i];
			if(X>t.x){
				if(X<t.x+t.width){
					if(Y>t.y){
						if(Y<t.y+t.height){
							changeQuality(i+1);
							return;
						}
					}
				}
			}
		}
		t=m;
		if(X>t.x){
			if(X<t.x+t.width){
				if(Y>t.y){
					if(Y<t.y+t.height){
						toogleMusic();
						return;
					}
				}
			}
		}
		t=d;
		if(X>t.x){
			if(X<t.x+t.width){
				if(Y>t.y){
					if(Y<t.y+t.height){
						Save.file.flush();
						dispatchEvent(new StateEvent(StateEvent.OPTBACK));						
					}
				}
			}
		}
		if(!c)
			return;
		t=c;
		if(X>t.x){
			if(X<t.x+t.width){
				if(Y>t.y){
					if(Y<t.y+t.height){
						showControls();					
					}
				}
			}
		}
	}
	
	private function showControls():void{
		con=new Controls();
		con.addEventListener(StateEvent.CONTROL,hideControls);
		addChild(con);
		cm=true;
		removeEventListener(Event.ENTER_FRAME,f);	
	}
	
	private function hideControls(e:StateEvent):void{
		con.removeEventListener(StateEvent.CONTROL,hideControls);
		removeChild(con);
		con=null;
		addEventListener(Event.ENTER_FRAME,f);	
	}
	
	private function toogleMusic():void{
		Save.file.data.music=!Save.file.data.music;
		if(Save.file.data.music){
			MusicPlayer.play(MusicPlayer.MAIN_TRACK);
		}
		else 
			MusicPlayer.stop();
	}
	
	private function changeQuality(v:int):void{
		preview.update(v);
		Save.file.data.quality=v;
		Log.it("Quality:",v===3?"High":v===2?"Medium":"Low");
	}

	private function die(e:Event):void{		
		stage.removeEventListener(MouseEvent.CLICK,click);
		removeEventListener(Event.REMOVED_FROM_STAGE,die);
		removeEventListener(Event.ENTER_FRAME,f);		
		removeChildren();
		preview=null;
		fps=null;
		q=null;
		m=null;
		d=null;
		c=null;
		if(con){
			con.removeEventListener(StateEvent.CONTROL,hideControls);
			con=null;
		}
	}
	
	}
}