package game.pages
{
	
	import assets.Assets;
	
	import com.greensock.TweenLite;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.GameEvents;
	
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	
	public class StartPage extends Sprite
	{
		
		private var _bg:MovieClip;
		private var _playBtn:Button;
		private var _timer:Timer = new Timer(250);
		
		/**
		 * constructor
		 */ 
		public function StartPage()
		{
			super();
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/**
		 * on add to stage
		 */ 
		private function onAddToStage(e:Event):void
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddToStage);
			_bg = Assets.getPage1MC(Assets.mcBackGround);
			addChild(_bg);
		}
		
		/**
		 * start
		 */ 
		public function init():void
		{
			_playBtn = new Button(Assets.getTexture(Assets.mcStartBtn));
			_playBtn.x = -_playBtn.width;
			_playBtn.y = height/2 - _playBtn.height/2;
			_playBtn.addEventListener( starling.events.Event.TRIGGERED, hideStartBtn);
			this.addChild(_playBtn);	
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onTimer)
		}
		
		/**
		 * some fps bug in start second
		 */ 
		protected function onTimer(event:TimerEvent):void
		{
			if (_timer.currentCount>1)
			{
				_timer.stop();
				showStartBtn();
			}
		}		
		
		/**
		 * show start btn
		 */ 
		public function showStartBtn():void
		{
			_playBtn.x = -_playBtn.width;
			_playBtn.y = height/2 - _playBtn.height/2;
			TweenLite.to(_playBtn, 1, {x:   280});
		}
		
		/**
		 * hide start btn
		 */ 
		public function hideStartBtn(e:Event = null):void
		{
			_playBtn.removeEventListener( starling.events.Event.TRIGGERED, hideStartBtn);
			_playBtn.y = height/2 - _playBtn.height/2;
			TweenLite.to(_playBtn, 1, {x:   860, onComplete: destroyBtn});
			dispatchEvent(new GameEvents(GameEvents.EVENT_OPEN_GAME_PAGE));
		}
		
		public function destroyBtn():void
		{
			this.removeChild(_playBtn);
			_playBtn = null;
		}	
			
	}
}