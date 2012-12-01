package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import com.sociodox.theminer.TheMiner;
	import ui.buttons.ButtonCreator;
	
	public class Preloader extends MovieClip{		
		[Embed(source="../lib/graphics/gitd.png")]private const GITD:Class;
		
		private var
			ys:Vector.<int>,
			button:Sprite,
			gitd:BitmapData,
			t:TextField,
			bd:BitmapData,
			p:Point;
		
		public function Preloader(){
			if(stage){
				stage.scaleMode=StageScaleMode.NO_SCALE;
				stage.align=StageAlign.TOP_LEFT;
			}
			if(CONFIG::debug)
				if(Config.MINER)
					addChild(new TheMiner());
			var 
			m:ContextMenu=new ContextMenu(),
			l:ContextMenuItem=new ContextMenuItem("By "+Config.AUTHOR),
			g:ContextMenuItem=new ContextMenuItem("Made for the "+Config.EDITION+" edition of the GiTD contest.");
			m.hideBuiltInItems();
			m.customItems=[g,l];
			g.enabled=false;
			l.separatorBefore=true;
			contextMenu=m;
			addEventListener(Event.ENTER_FRAME,checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioError);
			graphics.beginFill(Config.BACKGROUND_COLOR);
			graphics.drawRect(0,0,640,480);
			graphics.endFill();
			addChild(new Bitmap(bd=new BitmapData(640,480,true,Config.BACKGROUND_COLOR)));
			addChild(t=new TextField());
			t.y=30,
			t.defaultTextFormat=new TextFormat("_typewriter",23,Config.TEXT_COLOR,true),
			t.selectable=false,
			t.border=true,
			t.borderColor=Config.BORDER_COLOR,
			t.background=true,
			t.backgroundColor=Config.BUTTON_COLOR,
			t.multiline=true,
			t.width=0,
			t.autoSize="left";
			gitd=new GITD().bitmapData;
			p=new Point((640-gitd.width)*.5,100);
		}
		
		private function ioError(e:IOErrorEvent):void{
			t.text=e.text;
		}
		
		private function progress(e:ProgressEvent):void{
			const
				l:Number=e.bytesLoaded/e.bytesTotal;
			bd.copyPixels(gitd,new Rectangle(0,0,gitd.width*l,gitd.width),p);	
			t.text=e.bytesLoaded.toString()+" / "+e.bytesTotal.toString()+" bytes.";
			t.x=(640-t.width)*.5;
		}
		
		private function checkFrame(e:Event):void{
			if(currentFrame==totalFrames)
				stop(),
				loadingFinished();
		}
		
		private function loadingFinished():void{
			removeEventListener(Event.ENTER_FRAME,checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioError);	
			if(Config.GAME_ONLY){
				startup();
				return;
			}
			button=ButtonCreator.b("Launch Game",470,410,Config.BUTTON_COLOR,190);
			addChild(button);
			button.addEventListener(MouseEvent.CLICK,start);
			button.x=(640-button.width)*.5;
			button.y=100+gitd.height+30;
		}
		
		private function start(e:MouseEvent):void{			
			button.removeEventListener(MouseEvent.CLICK,start);
			removeChild(t);
			removeChild(button);
			addEventListener(Event.ENTER_FRAME,f);
			ys=new Vector.<int>(641);
		}
		
		private function f(e:Event):void{
			const 
				W:int=641,
				H:int=480;
			var
				X:int,
				Y:int,
				s:Boolean,
				c:int,
				i:int=-1,
				t:int=3;
			while(++i<t){	
				X=-1;
				c=0;
				while(++X<W){
					Y=-1+ys[X],
					s=false;
					if(Y===478){
						++c;
						continue;
					}
					while(bd.getPixel32(X,++Y)===0x000000){
						if(Y===H){
							s=true;
							break;
						}
					}
					if(s)
						continue;
					if(bd.getPixel32(X,Y)!==0x000000){
						while(Math.random()>0.3){
							ys[X]=Y;
							bd.setPixel32(X,Y,0x000000);
							if(++Y===H)
								break;
						}					
					}
				}				
			}
			if(c===640)
				startup();
		}
		
		private function startup():void{
			if(button)
				button.removeEventListener(MouseEvent.CLICK,start);
			removeEventListener(Event.ENTER_FRAME,f);
			removeChildren();			
			button=null;
			ys=null;
			bd.dispose();
			bd=null;
			gitd.dispose();
			gitd=null;
			t=null;
			p=null;
			const
				mainClass:Class=getDefinitionByName("GiTD_Template")as Class;
			addChild(new mainClass()as DisplayObject);
		}
		
	}
	
}