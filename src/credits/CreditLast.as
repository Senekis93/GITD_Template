package credits{
	import flash.text.TextField;

	public class CreditLast extends TextField{

	public function CreditLast():void{
		styleSheet=new LastStyle();
		width=0;
		autoSize="left";
		selectable=false;
	}
	
	}
}