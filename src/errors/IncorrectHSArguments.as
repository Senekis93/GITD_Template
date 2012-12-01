package errors{   

	public class IncorrectHSArguments extends Error{

	public function IncorrectHSArguments():void{
		message="Objects passed to the submit() method must have the following properties: name, value."
	}
	
	}
}