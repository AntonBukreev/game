package game.pages
{
	import assets.Assets;
	
	import flash.Boot;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import game.Game;
	import game.GameEvents;
	import game.engine.EngineEvent;
	import game.engine.NapeEngine;
	import game.engine.abstract.controller.MeteoritesController;
	import game.engine.abstract.controller.PlanetsController;
	import game.engine.abstract.model.vo.ConfVO;
	import game.pages.game.Bird;
	import game.pages.game.BirdsController;
	import game.pages.game.DotContainer;
	import game.pages.game.ScoreChangeText;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	

	public class GamePage extends Sprite
	{
		
		private var _engine:NapeEngine;
		private var _birdController:BirdsController;
		
		private var _scoreTF:TextField;
		private var _shootsTF:TextField;
		
		private var _shootCount:int = 10;
		private var _scoreCount:int = 0;
		private var _dots:DotContainer;
		
		
		public function GamePage()
		{
			super();
		}
		
		/**
		 * start
		 */
		public function init():void
		{
			if (!_engine)
			{
				_shootCount = 10;
				_scoreCount = 0;
				_scoreTF = new TextField(100,20,"score");
				_shootsTF = new TextField(100,20,"shoots");
				updateText();
				
				_dots = new DotContainer();
				addChild(_dots);
				
				_birdController = new BirdsController(stage);

				_engine =  NapeEngine.instance;
				_engine.init(this);
				_engine.addEventListener(EngineEvent.EVENT_CHANGE_SCORE, onChangeScore);
				_engine.addEventListener(EngineEvent.EVENT_ADD_DOT, onAddDot);
				addEventListener(starling.events.Event.ENTER_FRAME, update) 
				stage.addEventListener(starling.events.TouchEvent.TOUCH, onMouse);
			}
		}
		
		/**
		 * update effects
		 */ 
		private function onAddDot(e:EngineEvent):void
		{
			_dots.addDot(e.data.x,e.data.y);
		}
		
		/**
		 * update score
		 */ 
		private function onChangeScore(e:EngineEvent):void
		{
			_scoreCount += int(e.data.score);
			showChangeScoreLabele(e.data.x, e.data.y, e.data.score);
			updateText();
		}
		
		private function showChangeScoreLabele(x:int,y:int,score:int):void
		{
			var text:ScoreChangeText = new ScoreChangeText(x,y,score.toString());
			addChild(text);
			text.animate();
		}
		
		/**
		 * listen mouseClick and mouseMove events
		 */ 
		private function onMouse(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			
			switch(touch.phase)
			{
				case TouchPhase.HOVER:
				{
					_engine.onMove(touch.globalX, touch.globalY);
					_birdController.onMove(touch.globalX, touch.globalY);
					break;
				}
					
				case TouchPhase.BEGAN:
				{
					if (_shootCount > 0)
					{
						_engine.onDown(touch.globalX, touch.globalY);
						_birdController.onDown(touch.globalX, touch.globalY);
					
						_shootCount -= 1;
						updateText();
						
						//end game
						if(_shootCount == 0)
						{
							setTimeout(
								function():void
								{
									dispatchEvent(new GameEvents(GameEvents.EVENT_OPEN_START_PAGE, _scoreCount));
								},
								3000);
						}
					}
					break;
				}
					
			}  
		}	
		
		
		/**
		 * updating engine on enterframe event
		 */ 
		private function update(e:Event):void
		{
			_engine.update();
		}
		
		/**
		 * update score
		 */ 
		private function updateText():void
		{
			addChild(_scoreTF);
		
			_scoreTF.fontName = "Myriad Pro";
			_scoreTF.text = "Score: " + _scoreCount;
			_scoreTF.fontSize = 16;
			_scoreTF.bold = true;
			_scoreTF.color = 0xffffff;
			_scoreTF.alpha = 0.5;
			_scoreTF.x = Game.conf.width/2-_scoreTF.width/2;
			_scoreTF.y = 15;
			
			addChild(_shootsTF);
			
			_shootsTF.fontName = "Myriad Pro";
			_shootsTF.text = "Shoots: " + _shootCount;
			_shootsTF.fontSize = 16;
			_shootsTF.bold = true;
			_shootsTF.color = 0xffffff;
			_shootsTF.alpha = 0.5;
			_shootsTF.x = Game.conf.width/2-_scoreTF.width/2;
			_shootsTF.y = 0;
		}	
			
		
		/**
		 * destroy it
		 */ 
		public function destroy():void
		{
			removeChild(_dots);
			_birdController.destroy();
			removeChild(_scoreTF);
			removeChild(_shootsTF);
			_engine.destroy();
			_engine.removeEventListener(EngineEvent.EVENT_CHANGE_SCORE, onChangeScore);
			_engine.removeEventListener(EngineEvent.EVENT_ADD_DOT, onAddDot);
			removeChild(_engine);
			_engine = null;
			removeEventListener(starling.events.Event.ENTER_FRAME, update) 
			stage.removeEventListener(starling.events.TouchEvent.TOUCH, onMouse);
		}

	}
}