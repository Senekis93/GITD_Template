package ui.buttons{
	import flash.text.TextField; 

	public class ButtonText extends TextField{
		

	public function ButtonText(T:String,C:int=Config.TEXT_COLOR,X:int=0,Y:int=0):void{
		selectable=false;
		autoSize="center";
		x+=X;
		y+=Y;
		text=T;
		setTextFormat(new ButtonFormat(C));
	}
	
	}
}