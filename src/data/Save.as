package data{
	import flash.net.SharedObject;
	import errors.NoInstance;

	public class Save{
		
		public static const
			file:SharedObject=SharedObject.getLocal(Config.AUTHOR+"/save/GiTD"+Config.GITD_EDITION.toString(),"/");

	public function Save():void{
		throw new NoInstance();
	}
	
	public static function start():void{
		if(file.data.x)
			return;
		file.data.music=false;
		file.data.quality=3;
		file.data.sampleKey=68;
		//file.data.x=true;		// TODO Enable after configuring the save file.
		write();
	}
	
	public static function write():void{
		file.flush();
	}
	
	}
}