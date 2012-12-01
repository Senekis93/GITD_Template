package ui.buttons{
    import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.MouseEvent;	
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	import errors.NoInstance;
   

	public class ButtonCreator{
		private static const
			GLOW:GlowFilter=new GlowFilter(Config.BORDER_COLOR,0.8,8,4);
			
		private static var	
			BEVEL:BevelFilter;

	public function ButtonCreator():void{
		throw new NoInstance();
	}
	
	public static function b(T:String,X:int,Y:int,C:int,W:int=150,H:int=60,A:Number=0.6):Sprite{
		const
			b:Sprite=new Sprite,
			g:Graphics=b.graphics,
			t:ButtonText=new ButtonText(T);
		b.filters=[new BevelFilter(5,90,C,1,Config.TEXT_COLOR,1,3,10,3,3)]
		g.lineStyle(4,0,.3);
		g.drawRect(0,0,W,H);
		g.lineStyle(0);
		g.beginFill(C,A);
		g.drawRect(2,2,W-4,H-4);
		b.x=X;
		b.y=Y;			
		b.addChild(t);
		t.x=W*.5-t.width*.5;
		t.y=(b.height*.5-t.height*.5)-H*.1;
		b.addEventListener(MouseEvent.ROLL_OVER,mo,false,0,true);
		b.addEventListener(MouseEvent.ROLL_OUT,mou,false,0,true);
		b.buttonMode=true;
		b.mouseChildren=false;
		return b;
	}
	
	private static function mo(e:MouseEvent):void{
		BEVEL=e.target.filters[0];
		e.target.filters=[BEVEL,GLOW];
	}
	
	private static function mou(e:MouseEvent):void{
		e.target.filters=[BEVEL];
		BEVEL=null;
	}
	
	}
}

