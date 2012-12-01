package{
    import flash.events.Event;
	import flash.events.ContextMenuEvent;
    import flash.display.Sprite;	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;	
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;	
	import ug.QuickKong;
	import animation.BDTweens;
	import audio.MusicPlayer;
	import credits.Credits;
	import data.Save;
	import debug.Log;
	import display.logo.Intro;
	import events.StateEvent;
	import kong.Highscores;
	import security.SiteLock;
	import ui.menu.Menu; 	
	import ui.options.Options;
	import utils.Utils;
	
		
	[Frame(factoryClass="Preloader")]
	[SWF(width="640",height="480",frameRate="30",backgroundColor="#A2A2A2")]
		
	public class GiTD_Template extends Sprite{
		
		[Embed(source="../LEGAL.txt",mimeType="application/octet-stream")]private static const License:Class;
		
		private const
			VERSION:Number=2.03;
		
		private var 
			intro:Intro,
			menu:Menu,
			game:Game,
			cred:Credits,
			options:Options;
		
	

	public function GiTD_Template():void{			
		if(stage)
			go(null);
		else 
			addEventListener(Event.ADDED_TO_STAGE,go);	
	}

	private function go(e:Event):void{
		removeEventListener(Event.ADDED_TO_STAGE,go);
		customMenu();
		Save.start();
		BDTweens.init(stage);		
		SiteLock.init(stage.loaderInfo.url);
		if(SiteLock.isKong()||SiteLock.isLocal())
			if(Config.KONG_API)
				QuickKong.connectToKong(stage,kong);
		if(Config.GAME_ONLY){
				jumpToGame();
				return;
			}	
		addLogo();	
		info();
	}
	
	
	private function customMenu():void{
		var 
			m:ContextMenu=new ContextMenu(),
			l:ContextMenuItem=new ContextMenuItem("By "+Config.AUTHOR),
			g:ContextMenuItem=new ContextMenuItem("Made for the "+Config.EDITION+" edition of the GiTD contest.");
		m.hideBuiltInItems();
		m.customItems=[g,l];
		l.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,menuLink);
		g.enabled=false;
		l.separatorBefore=true;
		contextMenu=m;
	}
	
	private function menuLink(e:ContextMenuEvent):void{
		if(Config.WEBSITE!==""||Config.KONG_NAME!=="")
			navigateToURL(new URLRequest(Config.WEBSITE!==""?
			Config.WEBSITE:"http://www.kongregate.com/games/"+Config.KONG_NAME),"_blank"); 
	}
	
	private function kong():void{
		Highscores.submitAll();
		Log.it("Kong API connected, do stuff here.");
	}
	
	private function addLogo():void{
		intro=new Intro(StateEvent.MENU);
		addChild(intro);
		intro.addEventListener(StateEvent.MENU,addMenu);
		if(!Config.SHOW_INTRO)
			addMenu(null);
	}
	
	private function addMenu(e:Event):void{
		if(false/*Save.file.data.firstTime&&Config.SHOW_OPTIONS*/){
			firstConfig();
			Save.file.data.firstTime=false;
			Log.it("Configuration screen is displayed the first time that the player launches the game.");
		}
		else{
			menu=new Menu();
			BDTweens.animate(intro,menu,this,enableMenu);
			if(intro)
				removeIntro();		
		}
	}
	
	private function firstConfig():void{
		options=new Options();
		BDTweens.animate(intro,options,this,optionsReady);
		if(intro)
			removeIntro();		
	}
	
	private function enableMenu():void{		
		menu.addUI();
		menu.addEventListener(StateEvent.GAME,addGame);		
		menu.addEventListener(StateEvent.CREDITS,displayCredits);
		menu.addEventListener(StateEvent.OPTIONS,showOptions);
	}
	
	private function addGame(e:StateEvent):void{	
		if(!SiteLock.good()){
			if(Config.WEBSITE!==""||Config.KONG_NAME!=="")
				navigateToURL(new URLRequest(Config.WEBSITE!==""?
				Config.WEBSITE:"http://www.kongregate.com/games/"+Config.KONG_NAME),"_blank");
			return;
		}
		game=new Game();
		BDTweens.animate(menu,game,this,gameReady);
		removeMenu();
	}
	
	private function jumpToGame():void{
		if(!SiteLock.good()){
			if(Config.WEBSITE!==""||Config.KONG_NAME!=="")
				navigateToURL(new URLRequest(Config.WEBSITE!==""?
				Config.WEBSITE:"http://www.kongregate.com/games/"+Config.KONG_NAME),"_blank");
			return;
		}
		game=new Game();
		addChild(game);
		game.addEventListener(StateEvent.GAMEBACK,returnFromGame);
		game.start();
	}
	
	private function gameReady():void{
		game.addEventListener(StateEvent.GAMEBACK,returnFromGame);
		game.start();
	}
	
	private function returnFromGame(e:StateEvent):void{		
		menu=new Menu();
		BDTweens.animate(game,menu,this,enableMenu);
		removeGame();
	}
	
	
	private function removeGame():void{
		game.removeEventListener(StateEvent.GAMEBACK,returnFromGame);
		game=null;
	}
	
	private function displayCredits(e:StateEvent):void{
		cred=new Credits();
		BDTweens.animate(menu,cred,this,creditsReady);
		removeMenu();
	}
	
	private function creditsReady():void{
		cred.build();
		cred.addEventListener(StateEvent.CREDBACK,returnFromCreds);	
	}
	
	private function returnFromCreds(e:StateEvent):void{
		menu=new Menu();
		BDTweens.animate(cred,menu,this,enableMenu);
		removeCredits();
	}
	
	private function removeCredits():void{
		cred.removeEventListener(StateEvent.CREDBACK,returnFromCreds);
		cred=null;
	}
	
	private function removeMenu():void{
		menu.removeEventListener(StateEvent.GAME,addGame);
		menu.removeEventListener(StateEvent.CREDITS,displayCredits);
		menu.removeEventListener(StateEvent.OPTIONS,showOptions);
		menu=null;
	}
	
	private function showOptions(e:StateEvent):void{
		options=new Options();
		BDTweens.animate(menu,options,this,optionsReady);
		removeMenu();
	}
	
	private function optionsReady():void{
		options.start();
		options.addEventListener(StateEvent.OPTBACK,backFromOptions);
	}
	
	private function backFromOptions(e:StateEvent):void{
		menu=new Menu();
		BDTweens.animate(options,menu,this,enableMenu);
		removeOptions();
	}
	
	private function removeOptions():void{
		options.removeEventListener(StateEvent.OPTBACK,backFromOptions);
		options=null;
	}
	
	private function removeIntro():void{
		intro.removeEventListener(StateEvent.MENU,addMenu);
		intro=null;
	}
	
	public static function get ABOUT():String{
		return(new License()as ByteArray).toString();
	}
	
	private function info():void{
		Log.it("GiTD Template "+VERSION.toFixed(2)+
		"\nVisit http://www.kongregate.com/forums/4/topics/287037 for questions/updates."+
		"\nRead LEGAL.txt or trace(GiTD_Template.ABOUT) for more information.");
	}
	
	}
}