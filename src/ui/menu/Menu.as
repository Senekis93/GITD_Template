package ui.menu{
	import flash.display.Bitmap;
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.events.MouseEvent;
	import audio.MusicPlayer;
	import data.Save;
	import display.menu.MenuBackground;
	import ui.buttons.MenuButtons;

	public class Menu extends Sprite{	
		[Embed(source="../../../lib/graphics/mute.png")]private const Mute:Class;
		[Embed(source="../../../lib/graphics/sound.png")]private const Sound:Class;
		
		private var
			m:Bitmap;

	public function Menu():void{
		addEventListener(Event.ADDED_TO_STAGE,go);
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		addEventListener(Event.REMOVED_FROM_STAGE,die);
		addChild(new MenuBackground());	
	}	

	private function die(e:Event):void{
	stage.removeEventListener(MouseEvent.CLICK,toogle);	
	removeEventListener(Event.REMOVED_FROM_STAGE,die);
	removeChildren();
	m=null;
	}
	
	public function addUI():void{
		addChild(new MenuButtons());
		var s:Boolean=Save.file.data.music;
		if(s)m=new Sound();
		else m=new Mute();
		addChild(m);
		m.y=5,m.x=635-m.width;
		stage.addEventListener(MouseEvent.CLICK,toogle);
	}
	
	private function toogle(e:MouseEvent):void{
		const X:int=e.stageX,Y:int=e.stageY;
		if(X>m.x){
			if(X<m.x+m.width){
				if(Y>m.y){
					if(Y<m.y+m.height){
						removeChild(m);
						if(Save.file.data.music){
							MusicPlayer.stop();
							Save.file.data.music=false;
							m=new Mute();
						}
						else{
							MusicPlayer.play(MusicPlayer.MAIN_TRACK);
							Save.file.data.music=true;
							m=new Sound();
						}
						addChild(m);
						m.y=5,m.x=635-m.width;
						Save.file.flush();
					}
				}
			}
		}		
	}
	
	}
}