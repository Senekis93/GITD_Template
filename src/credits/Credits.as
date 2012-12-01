package credits{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import events.StateEvent;
	import ui.buttons.ButtonCreator;
	import utils.Utils;

	public class Credits extends Sprite{
		[Embed(source="../../lib/graphics/coder.png")]private const code:Class;
		[Embed(source="../../lib/graphics/graphics.png")]private const pics:Class;
		[Embed(source="../../lib/graphics/musician.png")]private const music:Class;
		[Embed(source="../../lib/graphics/testers.png")]private const beta:Class;
		[Embed(source="../../lib/graphics/gitd.png")]private const gitd:Class;
		
		private var
			button:Sprite,
			con:Sprite,
			p:Vector.<Point>,
			sp:Sprite;
		
		private const
			GITD_LINK:String=Config.GITD_LINK,
			C:int=Config.BUTTON_COLOR, 
			C2:int=Config.BORDER_COLOR,
			C3:int=Config.BACKGROUND_COLOR,	
			L:int=3;

	public function Credits():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);
		con=new Sprite();
		addChild(con);	
		drawBack();
		drawRects();
		addIcons();
		addGITD();
	}
	
	public function build():void{
		addText();
		addButton();
	}
	
	private function addButton():void{
		button=ButtonCreator.b("Back",470,410,C);
		addChild(button);
		if(!Config.DISABLE_ANIMATIONS)
			button.alpha=0;
		addEventListener(Event.ENTER_FRAME,showButton);
		button.addEventListener(MouseEvent.CLICK,back);
	}
	
	private function showButton(e:Event):void{
		if(button.alpha<1)
			button.alpha+=0.07;
	}
	
	private function back(e:MouseEvent):void{
		button.removeEventListener(MouseEvent.CLICK,back);
		dispatchEvent(new StateEvent(StateEvent.CREDBACK));
	}
	
	private function addGITD():void{
		var 
			b:Bitmap=new gitd(),
			s:Number=0.25;
		addChild(b);		
		b.x=450;
		b.y=330;
		b.scaleX=b.scaleY=s;
		sp=new Sprite();
		sp.graphics.beginFill(0,0);
		sp.graphics.drawRect(0,0,b.width,b.height);
		sp.graphics.endFill();
		sp.x=b.x;
		sp.y=b.y;
		sp.buttonMode=true;
		addChild(sp);
		sp.addEventListener(MouseEvent.CLICK,showGITD);
	}
	
	private function showGITD(e:MouseEvent):void{
		if(GITD_LINK!="")
			navigateToURL(new URLRequest(GITD_LINK),"_blank");
	}
	
	private function addText():void{		
		var 
			t:CreditTitle,
			s:int=5,
			S:int=15,
			c:CreditEntry,
			l:TextField;
		t=new CreditTitle();
		addChild(t);
		t.text="Code & Design";
		t.y=p[0].y+s;
		t.x=p[0].x+60;
		/** @Programmer */
		if(Config.AUTHOR!==""){
			c=new CreditEntry();
			addChild(c);
			c.text=Config.AUTHOR;
			c.y=t.y+t.height+S;
			c.x=t.x+100;
			l=new CreditLink();
			addChild(l);
			l.htmlText=Config.WEBSITE!==""?"(<a href=\""+Config.WEBSITE+"\" target=\"_blank\">Personal website.</a>)\n":"";
			l.htmlText+=Config.KONG_NAME!==""?"(<a href=\"http://www.kongregate.com/accounts/"+Config.KONG_NAME+"\" target=\"_blank\">Kongregate profile.</a>)":"";
			l.y=c.y+S;
			l.x=c.x;
		}
		/**********/
		/** @Graphics */
		if(Config.ARTIST!==""){
			t=new CreditTitle();
			addChild(t);
			t.text="Graphics";
			t.y=p[1].y+s;
			t.x=p[1].x+100;
			c=new CreditEntry();
			addChild(c);
			c.text=Config.ARTIST;
			c.y=t.y+t.height+S;
			c.x=t.x+20;
			if(Config.ART_CREDITS!==""){
				l=new CreditLink();
				addChild(l);
				l.htmlText="(<a href=\""+Config.ART_CREDITS+"\" target=\"_blank\">Website.</a>)";
				l.y=c.y+S;
				l.x=c.x;
			}
		}
		/**********/
		/** @Music */
		if(Config.MUSICIAN!==""){
			t=new CreditTitle();
			addChild(t);
			t.text="Music";
			t.y=p[2].y+s;
			t.x=p[2].x+100;
			c=new CreditEntry();
			addChild(c);
			c.text=Config.MUSICIAN;
			c.y=t.y+t.height+S;
			c.x=t.x+60;
			if(Config.MUSIC_CREDITS!==""){
				l=new CreditLink();
				addChild(l);
				l.htmlText="(<a href=\""+Config.MUSIC_CREDITS+"\" target=\"_blank\">Website.</a>)";
				l.y=c.y+S;
				l.x=c.x;
			}
		}
		/**********/
		/** @Betatester */
		if(Config.TESTER!==""){
			t=new CreditTitle();
			addChild(t);
			t.text="Beta testers";
			t.y=p[3].y+s;
			t.x=p[3].x+60;	
			c=new CreditEntry();
			addChild(c);
			c.text=Config.TESTER;
			c.y=t.y+t.height+S;
			c.x=t.x+70;
			if(Config.TEST_CREDITS!=""){
				l=new CreditLink();
				addChild(l);
				l.htmlText="(<a href=\""+Config.TEST_CREDITS+"\" target=\"_blank\">Website.</a>)";
				l.y=c.y+S;
				l.x=c.x;
			}
		}
		/***********/	
			l=new CreditLast();
			addChild(l);
		l.htmlText="<font size=\"18\"><b>Game In Ten Days</b> (GiTD) is a competition which \ntakes place at "+
		"the <a target=\"_blank\" href=\"http://www.kongregate.com/forums/4\">Programming forum</a>.\n\n"+
		"As it name states, all entries must be built in less than \nten days.\n"+
		"Make sure to visit the forum and vote for your favorite!";
		l.y=330;
		l.x=15;
	}
	
	private function addIcons():void{
		var 
			b:Bitmap,
			s:int=5,
			i:int=-1,
			l:int=p.length,
			c:Vector.<String>=new <String>["code","pics","music","beta"];
		while(++i<l){
			b=new this[c[i]]();
			addChild(b);
			b.x=p[i].x+s;
			b.y=p[i].y+(s*3);
		}
	}
	
	private function drawBack():void{
		graphics.beginFill(C3);
		graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
		graphics.endFill();
	}
	
	private function drawRects():void{
		graphics.lineStyle(L,C2);
		var 
			w:int=stage.stageWidth,
			h:int=stage.stageHeight,
			s:int=10,
			sw:int=(w/2)-s-(s/2),
			sh:int=(h/3)-s-(s/4),
			i:int=-1;
		p=new <Point>[new Point(s,s),new Point((s*2)+sw,s),new Point(s,(s*2)+sh),new Point((s*2)+sw,(s*2)+sh)];
		const 
			l:int=p.length;
		while(++i<l){
			graphics.beginFill(C,0.7);
			graphics.drawRect(p[i].x,p[i].y,sw,sh);
			graphics.endFill();
		}
		graphics.beginFill(C,0.7);
		graphics.moveTo(s,(s*3)+(2*sh));
		graphics.lineTo(w-s,(s*3)+(2*sh));
		graphics.lineTo(w-s,(s*3)+(2*sh)+(sh*.5));
		graphics.lineTo(w-s*20,h-s-(sh*.5));
		graphics.lineTo(w-s*20,h-s);
		graphics.lineTo(s,h-s);
		graphics.lineTo(s,(s*3)+(2*sh));
		graphics.endFill();		
	}

	private function die(e:Event):void{
	removeEventListener(Event.REMOVED_FROM_STAGE,die);
	removeEventListener(Event.ENTER_FRAME,showButton);
	button.removeEventListener(MouseEvent.CLICK,back);
	removeChildren();
	button=null;
	con=null;
	p=null;
	if(sp)
		sp.removeEventListener(MouseEvent.CLICK,showGITD);
	sp=null;
	}
	
	}
}