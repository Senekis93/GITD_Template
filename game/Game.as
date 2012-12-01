package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
    import flash.events.Event;   
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;	
	import audio.MusicPlayer;
	import data.Save;
	import debug.Log;
	import events.StateEvent;
	import kong.Highscores;
	import ui.buttons.ButtonCreator;

	public class Game extends Sprite{		

	public function Game():void{
		// TODO START CODING HERE!!!
		
		/********************************************************************************
		*	@Instructions:	  															*
		*																				*
		*	Remove the code/functions below and start building your game here.          *
		*																				*
		*	This is your entry point / Main class.                                      *
		*																				*
		*	Add your classes and subfolders to this (game) folder and your				*
		*	assets to the gamelib one for better organisation.							*
		*																				*
		*	If you have animations enabled, make sure to render something when the		*
		*	game is created, so the transition doesn't display a blank screen or 		*
		*	throws an error. 															*
		*																				*
		*	Then make a public start() function; it will be automatically called when	*
		*	the animation is over. Start your game logic there.							*
		*																				*
		*																				*
		*	@UsefulInfo:																*
		*																				*
		*	Dispatch StateEvent.GAMEBACK to quit to the main menu.						*
		*																				*
		*	Use QuickKong.submit("Name",value); to submit a score						*
		*	or Highscores.submitAll(); to use your custom method.						*
		*	You can also use Highscores.submit(...objects); see the kong.Highscores		*
		*	file for more information.													*
		*																				*
		*	Use MusicPlayer.play(MusicPlayer.MAIN_TRACK) to play the music or			*
		*	MusicPlayer.stop() to turn it off.											*
		*																				*
		*	SOL data can be accessed like Save.file.data.property;						*
		*																				*
		*	While developing the game, set Config.GAME_ONLY to true in order to			*
		*	skip all the screens and animations.										*
		*																				*
		*	You can use Log.it(...args) for a better trace function.					*
		*																				*
		*	You can get a default button like this: 									*
		*	ButtonCreator.b("Text",x,y,Config.BUTTON_COLOR?,width?,height?,alpha?);		*
		*																				*
		*	Use Save.write(); to flush the contents of the SOL file.					*
		*																				*
		********************************************************************************/
		draw();	// delete this line.
	}

/* DELETE */	
private var time:int;	
private function draw():void{var s:Shape=new Shape();s.graphics.beginFill(Config.TEXT_COLOR);s.graphics.drawRect(0,0,640,480);s.graphics.endFill();addChild(s);var t:TextField=new TextField();t.width=0;t.autoSize="left";t.selectable=false;t.defaultTextFormat=new TextFormat("_sans",23,Config.BUTTON_COLOR,true);t.text="Replace this with your game.\n\n\n\n\n\n\n\n\n\nReturning to main menu...";addChild(t);t.x=(640-t.width)*.5;t.y=15;}
public function start():void{addEventListener(Event.REMOVED_FROM_STAGE,die);addEventListener(Event.ENTER_FRAME,count);}
private function count(e:Event):void{if(++time===60){Log.it("Autoquit, as there's no actual game included.");dispatchEvent(new StateEvent(StateEvent.GAMEBACK));}}
private function die(e:Event):void{removeEventListener(Event.REMOVED_FROM_STAGE,die);removeEventListener(Event.ENTER_FRAME,count);removeChildren();}
/* DELETE*/

	}
}