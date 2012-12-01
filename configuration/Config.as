package{
	import flash.display.Sprite;
    import flash.events.Event;   
	import errors.NoInstance;

	public class Config{		
		public static const
		// TODO Edit files inside of the lib folder.
		// TODO EDIT THE VALUES BELOW!!
		/********************************************************************************/
		/*            Modify the values below to configure the template        			*/		
		/*		   																	    */
		/**		  		      @GeneralInfo:		 					 	    		   **/		
		/*																	 			*/
		/** @Author: To give you credit for the game.									*/
			AUTHOR:String=		 "YourName"						, 
		/** @Edition: Displayed in the right click menu.								*/	
			GITD_EDITION:uint=	 27								,
		/** @Link: To load GiTD thread when people click the GiTD icon in the credits	*/
			GITD_LINK:String=	 "http://www.kongregate.com/forums/4/topics/297634"		,
		/** @Art: For your artist's credits. Strings below here can be empty ("").		*/	
			ART_CREDITS:String=	 "http://myArtistsWebsite.net"	,
		/** @Artist: Your artist name. / Site where you got the graphics from.			*/		
			ARTIST:String=		 "Artist Name"						,
		/** @Username: Used for links and credits.										*/
			KONG_NAME:String=	 "KongUserName"					,
		/** @Music: Link to the website of the one who made the music.					*/
			MUSIC_CREDITS:String="http://musicianWebsite.org"	,
		/**	@Musician: The name of the author of the music.								*/	
			MUSICIAN:String=	 "MusicianName"					,
		/** @Tester: Link to your betatester's website / Kong profile.					*/
			TEST_CREDITS:String= "http://someonesWebsite.tv"	,						
		/**	@Betatester: His/her name or username.										*/
			TESTER:String=		 "Some guy"						,	
		/** @Website: Your website, if any.												*/
			WEBSITE:String=		 "http://myWebsiteLink.net"		,
		/*																	 			*/	
		/**				      @Display:									    		   **/
		/*																	 			*/
		/** @BG: Background color for the default screens.								*/
			BACKGROUND_COLOR:uint=		0xFF00294E		,
		/** @Border: Color for some fields borders / dividers.							*/
			BORDER_COLOR:uint=			0xFF000000		,
		/** @Buttons: Button background color.											*/
			BUTTON_COLOR:uint=			0xFF0058A4		,
		/** @Custom: Set to true if you want to use your own picture as the menu bg.	*/	
			CUSTOM_BACKGROUND:Boolean=	true				,
		/** @Text: Fields and buttons color.											*/
			TEXT_COLOR:uint=			0xFF000000		,
		/*																	 			*/	
		/**				      @Options: 								    		   **/
		/*																	 			*/
		/*																	  			*/		
		/** @Animations: Set to true to skip all tweens.								*/
			DISABLE_ANIMATIONS:Boolean=		false		,
		/** @Game: Enable to skip all screens and jump straight into the game.			*/	
			GAME_ONLY:Boolean=				false		, 
			// TODO Set GAME_ONLY to false before publishing.
		/** @Kong: Enable to be able to use Kong's API.									*/
			KONG_API:Boolean=				false		,	
		/** @Controls: Enable to use the controls section of the options menu.			*/	
			SHOW_CONTROLS:Boolean=			false		,
		/** @Credits: Control wheter the credits button will be displayed or not.		*/
			SHOW_CREDITS:Boolean=			true		,	
		/** @Options: Same as above, but for the options button.						*/	
			SHOW_OPTIONS:Boolean=			true		,
		/** @Intro: Disable if you don't want to display your intro animation.			*/	
			SHOW_INTRO:Boolean=				true		,
		/** @Sitelock: Enable to use the SiteLock class.								*/	
			SITELOCK:Boolean=				true		,
		/** @Debugger: Enable/disable TheMiner (C) http://www.sociodox.com/theminer/	*/	
			MINER:Boolean=					false		;	
		/*																				*/		
		/********************************************************************************/
			
			
		public function Config():void{
			throw new NoInstance();
		}			
		
		public static function get EDITION():String{
			const 
				e:String=GITD_EDITION.toString(),
				l:int=e.length,
				f:String=e.substring(l-1,l);
			if(f==="1")
				return e+"st";
			if(f==="2")
				return e+"nd";
			if(f==="3")
				return e+"rd";
			return e+"th";
		}
		
	}
}