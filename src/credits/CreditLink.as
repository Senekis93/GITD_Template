package credits{
	import flash.text.TextField;

	public class CreditLink extends TextField{

	public function CreditLink():void{
		styleSheet=new LinkStyle();
		width=0;
		autoSize="left";
		multiline=selectable=false;
	}
	
	}
}