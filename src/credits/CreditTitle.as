package credits{
	import flash.text.TextField;

	public class CreditTitle extends TextField{

	public function CreditTitle():void{
		defaultTextFormat=new TitleFormat();
		width=0;
		autoSize="left";
		multiline=selectable=false;
	}
	
	}
}