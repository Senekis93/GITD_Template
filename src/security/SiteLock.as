package security{
	import errors.NoInstance;
	import debug.Log;

	public class SiteLock{
		
		private static const
			kong:RegExp=/http:\/\/chat\.kongregate\.com\/gamez\/([0-9]{4})\/([0-9]{4})\/[A-z]+\/([A-z0-9\-_]+\.swf\?)kongregate_game_version\=[0-9]+/,
			fast:RegExp=/https:\/\/s3.amazonaws.com\/fastswf\/files\/.+\.swf/,
			fast2:String="http://cdn.fastswf.com", // temporary...
			local:String="file:"; 
		
		private static var
			url:String;
		
	public function SiteLock():void{
		throw new NoInstance();
	}
	
	public static function init(s:String):void{
		url=s;
		if(Config.SITELOCK)
			Log.it(isLocal()?"Local":isKong()?"Kong":isFast()?"FastSWF":url);
	}

	public static function good():Boolean{
		if(!Config.SITELOCK)
			return true;
		if(url.search(fast)==0)
			return true;
		if(url.indexOf(fast2)!==-1)
			return true;
		if(url.search(kong)==0)
			return true;
		if(url.indexOf(local)==0)
			return true;
		Log.it(url);	
		return false;
	}
	
	public static function isLocal():Boolean{
		return(url.indexOf(local)==0);
	}	
	
	public static function isFast():Boolean{		
		return((url.indexOf(fast2)!==-1)||(url.search(fast)==0));
	}
	
	public static function isKong():Boolean{
		return(url.search(kong)==0);
	}
	
	}
}