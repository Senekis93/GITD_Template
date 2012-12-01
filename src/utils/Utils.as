package utils{
	import flash.display.BitmapData;
    import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import debug.Log;
	import errors.NoInstance;
   

	public class Utils{
		private static const
			R:Number=0.212671,
			G:Number=0.71516,
			B:Number=0.072169;
		
		
	public function Utils():void{
			throw new NoInstance();
	}
	
	public static function paint(BD:BitmapData,C:uint):void{
		const 		
			r:Number=(((C>>16)&0xFF)/0xFF),
            g:Number=(((C>>8)&0xFF)/0xFF),
            b:Number=((C&0xFF)/0xFF),       
			cmf:ColorMatrixFilter=new ColorMatrixFilter([r*R,r*G,r*B,0,0,g*R,g*G,g*B,0,0,b*R,b*G,b*B,0,0,0,0,0,1,0]);
		BD.applyFilter(BD,BD.rect,new Point(),cmf);	
	}
	
	static public function center(o:DisplayObject,p:DisplayObjectContainer,m:String="b"):void{
		if(m==="b"){
			if(p is Stage){
				o.x=(((p as Stage).stageWidth-o.width)*.5)+p.x;
				o.y=(((p as Stage).stageHeight-o.height)*.5)+p.y;
				return;
			}
			o.x=((p.width-o.width)*.5)+p.x;
			o.y=((p.height-o.height)*.5)+p.y;
			return;
		}
		if(m==="x")
			o.x=((p.width-o.width)*.5)+p.x;
		else if(m==="y")
			o.y=((p.height-o.height)*.5)+p.y;
		else 
			Log.it("Wrong mode?");
	}
	
	
	}
}



