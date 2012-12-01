package kong{
	import ug.QuickKong;
	import data.Save;
	import debug.Log;
	import errors.IncorrectHSArguments;
	import errors.NoInstance;
	import errors.NotString;
	

	public class Highscores{

	public function Highscores():void{
		throw new NoInstance();
	}

	public static function submitAll():void{
		if(!Config.KONG_API)
			return;
		// TODO Submit scores	QuickKong.submit("Name",value);	
		// Example: QuickKong.submit("Coins",Save.file.data.coins);
		// Make sure to submit scores at other points, like at the end of a level.	
	}
	
	public static function submit(...o):void{
		if(!Config.KONG_API)
			return;
		/** @Example:
			Highscores.submit(
			{name:"Test",value:1},
			{name:"SomeStat",value:100},
			{name:"Coins",value:Save.file.data.coins},
			{name:"Achievements",value:achievements}
			); */
		var
			i:int=-1,
			e:int=o.length,
			c:Object;
		while(++i<e){
			c=o[i];
			if(c.name&&c.value){
				if(c.name is String&&c.name.length)
					QuickKong.submit(c.name,c.value);
				else
					throw new NotString();
			}
			else
				throw new IncorrectHSArguments();
		}
	}
	
	
	}
}