package credits{
	import flash.text.TextField;

	public class CreditEntry extends TextField{

	public function CreditEntry():void{
		defaultTextFormat=new EntryFormat();
		width=0;
		autoSize="left";
		multiline=selectable=false;
	}
	
	}
}