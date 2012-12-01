package animation{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import debug.Log;
	import errors.NoInstance;
	import utils.Utils;


	public class BDTweens{
		
		public static const
		DRAW:String="draw",
		FADE:String="fade",
		OLD:String="old",
		BOUNCE:String="bounce",
		CIRCLE:String="circle",
		RECTANGLE:String="rectangle",
		SQUARES:String="squares",
		CURTAIN:String="curtain",
		CURTAIN2:String="curtain2",
		PRELOADER:String="preloader",
		ROTATE_90:String="rotate90",
		WINDOW_BLIND:String="window_blind",
		EXPLODE:String="explode",
		ABSORB:String="absorb";
		
		private static const
			m:Vector.<String>=new <String>[DRAW,FADE,OLD,BOUNCE,CIRCLE,RECTANGLE,SQUARES,
			CURTAIN,CURTAIN2,PRELOADER,ROTATE_90,WINDOW_BLIND,EXPLODE,ABSORB], 
			// you can edit this to remove the ones that you dislike.
			_180:Number=Math.PI/180;
		
		private static var
			last:String,
			s:Stage,
			w:int,
			h:int,
			b:Bitmap,
			b2:Bitmap,
			b3:Bitmap,
			bd1:BitmapData,
			bd2:BitmapData,
			bd:BitmapData,
			cur:DisplayObject,
			tar:DisplayObject,
			p:DisplayObjectContainer,
			fun:String,
			co:Sprite,
			co2:Sprite,
			x:int,
			xx:int,
			y:int,
			yy:int,
			i:int,
			q:int,
			r:int,
			t:int,
			a:Number,
			aa:Number,
			rr:Number,
			re:Rectangle,
			po:Point,
			d:Boolean,
			wa:Boolean,
			mo:String,
			sh:Shape,
			sqs:Vector.<Point>,
			locs:Vector.<Point>,
			ys:Vector.<int>,
			c:Function;

	public function BDTweens():void{
		throw new NoInstance();
	}
	
	public static function init(S:Stage):void{
		w=S.stageWidth,
		h=S.stageHeight,
		s=S;
	}
	
	public static function animate(_1:DisplayObject,_2:DisplayObject,P:DisplayObjectContainer,C:Function=null,M:String=null):void{
		bd1=new BitmapData(w,h,true,0x00000000),
		bd2=new BitmapData(w,h,true,0x00000000);
		p=P,
		cur=_1,
		tar=_2;
		if(C!=null)
			c=C;
		bd1.draw(s);
		p.removeChild(_1);
		p.addChild(_2);		
		bd2.draw(s);
		_2.visible=false;
		if(Config.DISABLE_ANIMATIONS){
				end();			
				return;
		}
		if(M){
			last=M;
			BDTweens[M]();
		}
		//else if(true)implode();
		else{
			var 
				rm:String;
			do rm=m[int(Math.random()*m.length)] while(rm==last);
			last=rm;
			BDTweens[last]();
		}		
	}
	
	private static function absorb():void{
		fun="absorbE";		
		b2=new Bitmap(bd2);
		bd=new BitmapData(w,h,true,0x000000);
		bd.copyPixels(bd1,bd.rect,new Point());
		b=new Bitmap(bd);
		p.addChild(b2);
		p.addChild(b);
		x=71.1111,
		y=96,
		xx=0,
		yy=0,
		i=0;
		sqs=new Vector.<Point>(45);		
		while(yy<5){
			sqs[i]=new Point(xx*x,yy*y);
			++i;
			if(++xx==9){
				xx=0;
				++yy;
			}
		}	
		locs=sqs.concat();
		t=-1;
		s.addEventListener(Event.ENTER_FRAME,absorbE);
	}
	
	private static function absorbE(e:Event):void{
		bd.fillRect(bd1.rect,0x00000000);
		if(++t<45){
			if(t>15)
				if(t>25)
					x-=5,
					y-=6;
				else
					x-=1.5,
					y-=2;
			i=-1,
			r=sqs.length-1;
			while(++i<r){
				a=Math.atan2(((h*.5)-sqs[i].y),(w*.5)-sqs[i].x),
				locs[i].x+=Math.cos(a)*14,
				locs[i].y+=Math.sin(a)*12;
				bd.copyPixels(bd1,new Rectangle(sqs[i].x,sqs[i].y,x,y),locs[i]);
			}
		}
		else
			end();
	}
	
	private static function explode():void{
		fun="explodeE";		
		b2=new Bitmap(bd2);
		bd=new BitmapData(w,h,true,0x000000);
		bd.copyPixels(bd1,bd.rect,new Point());
		b=new Bitmap(bd);
		p.addChild(b2);
		p.addChild(b);
		x=71.1111,
		y=96,
		xx=0,
		yy=0,
		i=0;
		sqs=new Vector.<Point>(45);		
		locs=new Vector.<Point>(45);		
		while(yy<5){
			sqs[i]=new Point(xx*x,yy*y);
			locs[i]=new Point(xx*x,yy*y);
			++i;
			if(++xx==9){
				xx=0;
				++yy;
			}
		}	
		t=-1;
		s.addEventListener(Event.ENTER_FRAME,explodeE);
	}
	
	private static function explodeE(e:Event):void{
		bd.fillRect(bd1.rect,0x00000000);
		if(++t<45){
			i=-1,
			r=sqs.length-1;
			while(++i<r){
				a=Math.atan2(((h*.5)-sqs[i].y),(w*.5)-sqs[i].x),
				locs[i].x+=Math.cos(a)*-9,
				locs[i].y+=Math.sin(a)*-9;
				bd.copyPixels(bd1,new Rectangle(sqs[i].x,sqs[i].y,71.12,96),locs[i]);
			}
		}
		else
			end();
	}
	
	private static function window_blind():void{
		fun="window_blindE";
		b=new Bitmap(bd1);
		p.addChild(b);
		i=16,
		r=17;
		s.addEventListener(Event.ENTER_FRAME,window_blindE);
	}
	
	private static function window_blindE(e:Event):void{
		if(--i>-1){
			t=-1;
			while(++t<r)
				bd1.copyPixels(bd2,new Rectangle(0,(t*30)-i,w,r-i),new Point(0,(t*30)-i));
		}
		else
			end();
	}
	
	private static function rotate90():void{
		fun="rotate90E";
		b=new Bitmap(bd2);
		b2=new Bitmap(bd1);
		co=new Sprite();
		co.addChild(b);
		p.addChild(b2);
		p.addChild(co);
		co.rotation-=90;
		b.y-=h;
		co.y+=h;
		a=0.2;
		s.addEventListener(Event.ENTER_FRAME,rotate90E);
	}
	
	private static function rotate90E(e:Event):void{
		a+=0.2;
		if(co.rotation<0)
			co.rotation=co.rotation+a<0?co.rotation+a:0;
		else		
			end();
	}
	
	private static function preloader():void{
		fun="preloaderE";
		b=new Bitmap(bd1);
		b2=new Bitmap(bd2);
		p.addChild(b2);
		p.addChild(b);		
		ys=new Vector.<int>(641);
		s.addEventListener(Event.ENTER_FRAME,preloaderE);
	}
	
	private static function preloaderE(e:Event):void{
		const 
				W:int=641,
				H:int=480;
			var
				X:int,
				Y:int,
				s:Boolean,
				c:int,
				i:int=-1,
				t:int=4;
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
				while(bd1.getPixel32(X,++Y)===0x000000){
					if(Y===H){
						s=true;
						break;
					}
				}
				if(s)
					continue;
				if(bd1.getPixel32(X,Y)!==0x000000){
					while(Math.random()>0.3){
						ys[X]=Y;
						bd1.setPixel32(X,Y,0x000000);
						if(++Y===H)
							break;
					}					
				}
			}				
		}
		if(c===640)
			end();
	}
	
	private static function curtain2():void{
		fun="curtain2E";
		b=new Bitmap(bd1);
		p.addChild(b);
		i=8,x=(w*.5)-i;
		s.addEventListener(Event.ENTER_FRAME,curtain2E);
	}
	
	private static function curtain2E(e:Event):void{
		if(x>=0){
			bd1.copyPixels(bd2,new Rectangle(x,0,((w*.5)-x)*2,h),new Point(x,0));
			x-=i;
		}
		else end();
	}
	
	private static function curtain():void{
		fun="curtainE";
		b=new Bitmap(bd1);
		p.addChild(b);
		yy=10,y=h-yy;
		s.addEventListener(Event.ENTER_FRAME,curtainE);
	}
	
	private static function curtainE(e:Event):void{
		if(y<0)
			end();
		else{
			bd1.copyPixels(bd2,new Rectangle(0,y,w,yy),new Point(0,y));
			y-=yy;
		}
	}
	
	private static function squares():void{
		fun="squaresE";
		b=new Bitmap(bd1);
		p.addChild(b);
		x=71.1111,
		y=96,
		xx=0,
		yy=0,
		i=0;
		sqs=new Vector.<Point>(45);
		while(yy<5){
			sqs[i]=new Point(xx*x,yy*y);
			++i;
			if(++xx==9){
				xx=0;
				++yy;
			}
		}		
		s.addEventListener(Event.ENTER_FRAME,squaresE);	
	}
	
	private static function squaresE(e:Event):void{
		if(sqs.length){
			r=int(Math.random()*sqs.length),
			x=sqs[r].x,
			y=sqs[r].y;
			bd1.copyPixels(bd2,new Rectangle(x,y,71.12,96),sqs[r]);
			sqs.splice(r,1);
		}
		else 
			end();
	}
	
	private static function rectangle():void{
		fun="rectangleE";
		b=new Bitmap(bd1);
		p.addChild(b);
		a=0,aa=0,xx=w*.5,yy=h*.5,x=xx-a,y=yy-aa,i=1;
		s.addEventListener(Event.ENTER_FRAME,rectangleE);		
	}
	
	private static function rectangleE(e:Event):void{
		if(x<=0)
			end();
		else{
			bd1.copyPixels(bd2,new Rectangle(x,y,a*2,aa*2),new Point(x,y));
			a+=10.4,aa+=8,x=xx-a,y=yy-aa;
		}
	}
	
	private static function circle():void{
		fun="circleE";
		sh=new Shape();
		sh.graphics.lineStyle(13,0);
		b=new Bitmap(bd1);
		p.addChild(b);
		b2=new Bitmap(bd2);
		p.addChild(b2);
		bd=new BitmapData(w,h,true,0x00FFFFFF);
		b3=new Bitmap(bd);
		b2.cacheAsBitmap=b3.cacheAsBitmap=true;
		b2.mask=b3;
		p.addChild(b3);
		i=int(Math.random()*360),t=400,x=w*.5,y=h*.5,d=Math.random()>0.5,yy=(d?(i+360):(i-360));
		s.addEventListener(Event.ENTER_FRAME,circleE);
	}
	
	private static function circleE(e:Event):void{	
		if(d){
			if(i<yy){
				var l:int=i+15,ra:Number;
				while(++i<l){
					ra=i*_180;;
					sh.graphics.moveTo(x,y);
					sh.graphics.lineTo(x+Math.cos(ra)*t,y+Math.sin(ra)*t);				
				}
				bd.draw(sh);
			}
			else 
				end();
		}
		else{
			if(i>yy){
				var ll:int=i-15,raa:Number;
				while(--i>ll){
					raa=i*_180;
					sh.graphics.moveTo(x,y);
					sh.graphics.lineTo(x+Math.cos(raa)*t,y+Math.sin(raa)*t);				
				}
				bd.draw(sh);
			}
			else
				end();			
		}
	}
	
	private static function bounce():void{
		fun="bounceE";
		b=new Bitmap(bd1);
		p.addChild(b);
		b2=new Bitmap(bd2);
		p.addChild(b2);
		r=(int(Math.random()*4))+1,wa=false,t=0,i=0,a=r<3?25.0:-25.0,aa=0.5,
		mo=(r==1||r==3)?"x":"y",d=a>0;
		b2.x=r==1?-w:r==3?w:0,b2.y=r==2?-h:r==4?h:0;
		s.addEventListener(Event.ENTER_FRAME,bounceE);
	}
	
	private static function bounceE(e:Event):void{
		if(mo==="x"){
			if(d){
				if(b2.x+a<0)
					b2.x+=a;
				else{
					b2.x=0;
					a*=-aa;
					++i;
					wa=true;
				}
			}
			else{
				if(b2.x+a>0)
					b2.x+=a;
				else{
					b2.x=0;
					a*=-aa;
					++i;
					wa=true;
				}
			}
		}
		else{
			if(d){
				if(b2.y+a<0)
					b2.y+=a;
				else{
					b2.y=0;
					a*=-aa;
					++i;
					wa=true;
				}
			}
			else{
				if(b2.y+a>0)
					b2.y+=a;
				else{
					b2.y=0;
					a*=-aa;
					++i;
					wa=true;
				}
			}
		}
		if(wa){
			if(++t===8){
				t=0;
				wa=false;
				a*=-aa;
			}
		}
		if(i===7)
			end();
	}
	
	private static function old():void{
		fun="oldE";
		b=new Bitmap(bd1);
		p.addChild(b);
		b2=new Bitmap(bd2);
		co=new Sprite();
		co.addChild(b2);
		p.addChild(co);
		b2.scaleX=b2.scaleY=a=aa=0.0125;	
		rr=18;
		b2.x=-b2.width*.5;
		b2.y=-b2.height*.5;
		co.x=((w-(co.width))*.5);
		co.y=((h-(co.height))*.5);
		d=Math.random()>0.5;
		s.addEventListener(Event.ENTER_FRAME,oldE);
	}
	
	private static function oldE(e:Event):void{
		if(a<1){
			co.rotation+=d?rr:-rr;
			a+=aa;
			b2.x=-b2.width*.5;
			b2.y=-b2.height*.5;
			b2.scaleX=b2.scaleY=a;
		}
		else
			end();
	}
	
	private static function fade():void{
		fun="fadeE";
		b=new Bitmap(bd1);
		p.addChild(b);
		aa=0.035,a=aa,po=new Point(),re=bd1.rect,r=Math.random()*int.MAX_VALUE,yy=w*h,t=0;
		s.addEventListener(Event.ENTER_FRAME,fadeE);		
	}
	
	private static function fadeE(e:Event):void{			
		if(++t<30)
			bd1.pixelDissolve(bd2,re,po,r,yy*a,0);
		else{
			bd1.pixelDissolve(bd2,re,po,r,yy,0);
			end();
		}
		a+=aa;
	}
	
	private static function draw():void{		
		fun="drawE";
		b=new Bitmap(bd1);
		p.addChild(b);
		q=25,r=4,xx=w/q,yy=h/r;
		i=0,x=0,y=0;
		s.addEventListener(Event.ENTER_FRAME,drawE);
	}
	
	private static function drawE(e:Event):void{		
		if(x>=w)
			x=0,
			y+=yy;
		bd1.copyPixels(bd2,new Rectangle(x,y,xx,yy),new Point(x,y));		
		bd1.copyPixels(bd2,new Rectangle((w-xx)-x,(h-yy)-y,xx,yy),new Point((w-xx)-x,(h-yy)-y));		
		if(x+xx>=w)
			if(y+yy>=h*.5)
				end();
		x+=xx;
	}
	
	private static function end():void{
		if(fun)
			s.removeEventListener(Event.ENTER_FRAME,BDTweens[fun]);
		if(b)
			b.parent.removeChild(b);
		if(b2)
			b2.parent.removeChild(b2);		
		if(b3)
			b3.parent.removeChild(b3);
		if(co)
			p.removeChild(co);
		if(co2)
			p.removeChild(co2);
		tar.visible=true;
		if(c!=null){
			c();
			c=null;
		}
		b=null;
		b2=null;
		b3=null;
		fun=null;
		p=null;
		if(bd){
			bd.dispose();
			bd=null;
		}
		if(bd1){
			bd1.dispose();
			bd1=null;
		}
		if(bd2){
			bd2.dispose();
			bd2=null;
		}
		ys=null;
		cur=null;
		locs=null;
		tar=null;
		po=null;
		re=null;
		co=null;
		co2=null;
		sh=null;
		sqs=null;
	}
	


	}
}