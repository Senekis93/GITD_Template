package errors{   

	public class NotString extends Error{

	public function NotString():void{
		message="The name property must be a non empty string."
	}
	
	}
}