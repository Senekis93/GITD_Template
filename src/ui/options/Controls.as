package ui.options{
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextLineMetrics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import events.StateEvent;
	import data.Save;
	import debug.Log;
	import ui.buttons.ButtonCreator;
	import skyboy.ui.Key;

	public class Controls extends Sprite{
		private var 
			d:Sprite,
			t:int=-1,
			groups:Vector.<Object>=new <Object>[];
			
		private const
			TEXT:int=Config.TEXT_COLOR,
			BORDER:int=Config.BORDER_COLOR,
			BACKGROUND:int=Config.BACKGROUND_COLOR,
			BUTTON:int=Config.BUTTON_COLOR;
			
	public function addKeys():void{
		createGroup(70,110,80,"sampleKey","Sample key");
		createGroup(90,210,60,"sampleKey","Sample key");
		createGroup(110,300,40,"sampleKey","Sample Key");
	}

	public function Controls():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);
		drawBackground();
		addEventListener(MouseEvent.CLICK,click);
		stage.addEventListener(KeyboardEvent.KEY_DOWN,kd);	
		addKeys();
	}
	
	private function drawBackground():void{
		graphics.beginFill(BACKGROUND);
		graphics.drawRect(0,0,640,480);
		graphics.endFill();	
		var 
			t:TextField=field(500);
		t.text="Click on the key that you want to modify, then press a key on your keyboard to change its value.";		t.x=70,t.y=10;
		border(t);		
		doneButton();
	}
	
	private function doneButton():void{
		d=ButtonCreator.b("Done",0,400,BUTTON);
		addChild(d);
		d.x=(640-d.width)*.5;
		d.addEventListener(MouseEvent.CLICK,quit);
	}
	
	private function createGroup(X:int,Y:int,W:int,P:String,D:String):void{
		const
			i:int=groups.length,
			k:Sprite=key(X,Y,W,W);
		groups[i]={
			key:k,
			value:P,
			text:text(W*1.1,W*1.1,String.fromCharCode(Save.file.data[P]),k)
			};
		draw(groups[i].key);
		description(X,Y,W,D);
	}
	
	private function description(X:int,Y:int,W:int,D:String):void{
		var
			t:TextField=new TextField(),
			s:int=23,
			h:int=W;
		t.selectable=false;
		t.multiline=t.wordWrap=true;
		t.width=(stage.stageWidth-(X+W+60));
		t.autoSize="left";
		t.height=0;
		t.background=t.border=true;
		t.backgroundColor=Config.BUTTON_COLOR;
		t.defaultTextFormat=new TextFormat("_serif",s,TEXT,true);		
		addChild(t);
		t.text=D;
		W*=.76;
		if(t.height>W){
			while(t.height>W)
				t.setTextFormat(new TextFormat("_serif",--s,TEXT,true));
		}
		else
			while(t.height<W)
				t.setTextFormat(new TextFormat("_serif",++s,TEXT,true));
		if(t.height>W)
			t.setTextFormat(new TextFormat("_serif",--s,TEXT,true));
		var 
			l:int=t.maxScrollV;
		if(l===1){
			var 
				m:TextLineMetrics=t.getLineMetrics(0);
			t.width=m.width+5;
		}
		else{
			var 
				i:int=-1,
				v:int,
				w:TextLineMetrics;
			--l;
			while(++i<l){
				w=t.getLineMetrics(i);
				if(w.width>v)
					v=w.width;
			}
			t.width=v+5;
		}
		t.x=X+(((640-X)-t.width)*.5);
		t.y=Y+((h-t.height)*.5);
		border(t);
	}
	
	private function quit(e:MouseEvent):void{
		Save.file.flush();
		dispatchEvent(new StateEvent(StateEvent.CONTROL));
	}
	
	private function border(t:TextField):void{
		graphics.lineStyle(2,BORDER);
		graphics.beginFill(0,0);
		graphics.drawRect(t.x-1,t.y-1,t.width,t.height);
	}
	
	private function field(s:int):TextField{
		var 
			t:TextField=new TextField();
		t.selectable=false;
		t.multiline=t.wordWrap=true;
		t.width=s;
		t.autoSize="left";
		t.height=0;
		t.background=t.border=true;
		t.backgroundColor=Config.BUTTON_COLOR;
		t.defaultTextFormat=new TextFormat("_serif",23,Config.TEXT_COLOR,true);		
		addChild(t);
		return t;
	}
	
	private function draw(k:Sprite):void{
		const 
			X:int=k.x,
			Y:int=k.y,
			W:int=k.width,
			H:int=k.height;		
		with(graphics){
			beginFill(Config.BUTTON_COLOR);
			lineStyle(2,Config.BORDER_COLOR);
			moveTo(X,Y);
			lineTo(X-W*.1,Y+H*0.05);
			lineTo(X-W*.1,Y+H*1.1);
			lineTo(X+W*1.1,Y+H*1.1);
			lineTo(X+W*1.1,Y+H*0.05);
			lineTo(X+W,Y);
			endFill();
		}
	}
	
	private function kd(e:KeyboardEvent):void{
		if(t===-1)
			return;
		update(groups[t].key.width,groups[t].key.height,groups[t].text,Key.nameForCode(e.keyCode));
	}
	
	private function click(e:MouseEvent):void{
		const 
			X:int=e.stageX,
			Y:int=e.stageY;
		var 
			k:Sprite,
			i:int=-1,
			l:int=groups.length;
		while(++i<l){
			k=groups[i].key;
			if(X>=k.x){
				if(X<=k.x+k.width){
					if(Y>=k.y){
						if(Y<=k.y+k.height){
							t=i;
							break;
						}
					}
				}
			}
		}
	}
	
	private function key(X:int,Y:int,W:int,H:int):Sprite{
		var 
			k:Sprite=new Sprite();
		k.graphics.beginFill(Config.BACKGROUND_COLOR);
		k.graphics.lineStyle(2,Config.BORDER_COLOR);
		k.graphics.drawRoundRect(0,0,W,H,W*.1,H*.1);
		k.graphics.endFill();
		addChild(k);
		k.x=X,
		k.y=Y;
		return k;
	}
	
	private function text(W:int,H:int,S:String,P:Sprite):TextField{
		const 
			T:TextField=new TextField();
		T.defaultTextFormat=new TextFormat("_typewriter",int(W/2.5),0,true);
		T.selectable=T.multiline=T.wordWrap=false;
		T.width=0;
		T.autoSize="left";		
		P.addChild(T);
		update(W,H,T,S);
		return T;
	}
	
	private function update(W:int,H:int,T:TextField,S:String):void{		
		if(S===null)
			S="?";
		T.width=0;	
		T.text=S;
		while(T.width>W)
			T.text=T.text.slice(0,-1);
		T.x=-5+(W-T.width)*.5;
		T.y=-5+(H-T.height)*.5;
	}

	private function die(e:Event):void{
		d.removeEventListener(MouseEvent.CLICK,quit);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN,kd);
		removeEventListener(Event.REMOVED_FROM_STAGE,die);
		removeEventListener(MouseEvent.CLICK,click);
		removeChildren();
		d=null;
		groups=null;
	}
	
	}
}