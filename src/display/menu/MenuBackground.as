package display.menu{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
    import flash.events.Event;   	
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import utils.Utils;

	public class MenuBackground extends Sprite{
		private const
			me:Object={x:"r",y:"b"}, // l,c,r / t,c,b / n
			gitd:Object={x:"l",y:"b"},
			lg:Object={x:"c",y:"30"},
			pic:Boolean=Config.CUSTOM_BACKGROUND;
		
		private var 
			b:Bitmap,
			bd:BitmapData;
		
		[Embed(source="../../../lib/graphics/menu.png")]private const back:Class;
		[Embed(source="../../../lib/graphics/me.png")]private const myLogo:Class;
		[Embed(source="../../../lib/graphics/gitd.png")]private const GITD:Class;
		[Embed(source="../../../lib/graphics/logo.png")]private const logo:Class;

	public function MenuBackground():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);
		draw();
	}
	
	private function draw():void{
		bd=new BitmapData(stage.stageWidth,stage.stageHeight,true,0xFFFFFFFF);				
		if(!pic){
			bd.perlinNoise(36+int(Math.random()*(stage.stageWidth-36)),1+int(Math.random()*stage.stageHeight),1+int(Math.random()*6),Math.random()*int.MAX_VALUE,true,false,1+int(Math.random()*6),true);
			Utils.paint(bd,Config.BACKGROUND_COLOR);
		}
		else{
			var 
				d:BitmapData=new back().bitmapData;
			bd.copyPixels(d,d.rect,new Point());
		}
		b=new Bitmap(bd,"never",true);
		addChild(b);
		add(new logo().bitmapData,lg,0,190);
		add(new GITD().bitmapData,gitd,200);	
		add(new myLogo().bitmapData,me,0,70);
	}
	
	private function add(pic:BitmapData,position:Object,W:int=0,H:int=0):void{
		var
			w:int=pic.width,
			h:int=pic.height,
			s:int=10,
			X:int,
			Y:int,
			sc:Number=W!==0?W/w:H!==0?H/h:1,
			m:Matrix=new Matrix(),
			d:BitmapData=new BitmapData(w*sc,h*sc,true,0x00000000);
		m.scale(sc,sc);
		d.draw(pic,(W+H!==0)?m:null);
		w=d.width,
		h=d.height;
		if(position.x==="l")
			X=s;
		else if(position.x==="c")
			X=(stage.stageWidth-w)*.5;
		else if(position.x==="r")
			X=stage.stageWidth-w-s;
		else if(!isNaN(parseInt(position.x)))
			X=parseInt(position.x);
		if(position.y==="t")
			Y=s;
		else if(position.y==="c")
			Y=(stage.stageHeight-h)*.5;
		else if(position.y==="b")
			Y=stage.stageHeight-h-s;
		else if(!isNaN(parseInt(position.y)))
			Y=parseInt(position.y);
		bd.copyPixels(d,d.rect,new Point(X,Y),bd,new Point(X,Y),true);
	}
	
	private function die(e:Event):void{
		removeEventListener(Event.REMOVED_FROM_STAGE,die);		
		removeChildren();
		bd.dispose();
		bd=null;
		b=null;
	}

	
	}
}