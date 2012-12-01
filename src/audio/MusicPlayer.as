package audio{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;  
	import errors.NoInstance;

	public class MusicPlayer{
		
		private static var
			track:Sound,
			chan:SoundChannel;		
			
		[Embed(source="../../lib/audio/main_track.mp3")]private static const SAMPLE:Class;	
		private static const
			TRACKS:Vector.<Class>=new <Class>[SAMPLE];
			
		public static const
			MAIN_TRACK:int=0;
		

	public function MusicPlayer():void{
		throw new NoInstance();
	}

	public static function play(i:int):void{
		stop();
		chan=new SoundChannel();
		track=new TRACKS[i]as Sound;
		chan=track.play();
		chan.addEventListener(Event.SOUND_COMPLETE,loop);
	}
	
	private static function loop(e:Event):void{
		chan.removeEventListener(Event.SOUND_COMPLETE,loop);
		chan=track.play();
		if(!chan.hasEventListener(Event.SOUND_COMPLETE))
			chan.addEventListener(Event.SOUND_COMPLETE,loop);
	}

	public static function stop():void{
		if(chan){
			chan.removeEventListener(Event.SOUND_COMPLETE,loop);
			chan.stop();
			chan=null;
		}		
		track=null;
	}
	
	}
}