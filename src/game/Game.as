package game
{
	import game.engine.abstract.model.vo.ConfVO;
	import game.pages.GamePage;
	import game.pages.StartPage;
	import game.pages.start.YourScore;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.ConfProxy;
	
	public class Game extends Sprite
	{
		
		public static var conf:ConfVO = null;
		
		private var _startPage:StartPage = new StartPage();
		private var _gamePage:GamePage = new GamePage();
		private var _yourScore:YourScore;
		
		public function Game()
		{
			super();
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddToStage);
		}

		/**
		 * prepearing graphic
		 */ 
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddToStage);
			_startPage.width = width;
			_startPage.height = height;
			addChild(_startPage);
			addChild(_gamePage);
			loadConf();
			
			_startPage.addEventListener(GameEvents.EVENT_OPEN_GAME_PAGE, onOpenGamePage);
			_gamePage.addEventListener(GameEvents.EVENT_OPEN_START_PAGE, onOpenStartPage);
		}
		
		/**
		 * open game page
		 */ 
		private function onOpenGamePage(e:GameEvents):void
		{
			_gamePage.init();	
			if (_yourScore)
			{
				removeChild(_yourScore);
			}
		}
		
		/**
		 * close game page open start page
		 */ 
		private function onOpenStartPage(e:GameEvents):void
		{
			_gamePage.destroy();
			_startPage.init();	
			showYourScore(e.data.toString());
		}
		
		private function showYourScore(score:String):void
		{
			_yourScore = new YourScore(score)
			addChild(_yourScore);
		}
		
		
		/**
		 * start loading conf file
		 */ 
		protected function loadConf():void
		{
			var confUrl:String = ConfProxy.DEFAULT_CONF_PATH;
			var conf:ConfProxy = new ConfProxy();
			conf.load(confUrl, onLoadConf);
		}
		
		/**
		 * on load conf, start game
		 */ 
		private function onLoadConf(data:ConfVO):void
		{
			conf = data;
			_startPage.init();
		}
		
		
	}
}