package game.engine
{
	import assets.Assets;
	
	import flash.Boot;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import game.engine.abstract.controller.Controller;
	import game.engine.abstract.controller.ExplosionController;
	import game.engine.abstract.controller.MeteoritesController;
	import game.engine.abstract.controller.PlanetsController;
	import game.engine.graphic.Meteorite;
	import game.engine.graphic.Planet;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class NapeEngine extends DisplayObject
	{
		
		private static var _instance:NapeEngine;
		
		public static function get instance():NapeEngine
		{
			if (_instance == null) _instance = new NapeEngine(new Key());
			return _instance;
		}
		
		private const _timeStep:Number = 1/60;
		private var _space:Space;
		
		private var _planets:PlanetsController = PlanetsController.instance;
		private var _meteorites:MeteoritesController = MeteoritesController.instance;
		private var _explosions:ExplosionController = ExplosionController.instance;
		
		private var _container:DisplayObjectContainer;
		
		private var _controllers:Array;
		
		public function NapeEngine(key:Key)
		{
			super();
			_controllers = [_planets, _meteorites, _explosions];
		}
		
		/**
		 * start engine
		 */ 
		public function init(container:DisplayObjectContainer):void
		{
			_container = container;
			
			new Boot();
			var gravity:Vec2 = new Vec2(0, 0);
			_space = new Space(gravity);
			initControllers();
		}
		
		/**
		 * for generation grapfic from engine
		 */ 
		private function graphicGenerator(name:String):DisplayObject
		{
			var mc:DisplayObject = Assets.getPage2MC(name);
			_container.addChild(mc);
			return mc;
		}
		
		/**
		 * for removing grapfic from engine
		 */ 
		private function graphicDestroyer(mc:DisplayObject):void
		{
			_container.removeChild(mc);
		}
		
		/**
		 * initialise all controllers
		 */ 
		private function initControllers():void
		{
			for each(var item:Controller in _controllers)
			{
				item.graphicGenerator = graphicGenerator;
				item.graphicDestroyer = graphicDestroyer;
				item.addToSpaceHandler = function(item:Body):void{_space.bodies.add(item);}		
				item.removeFromSpaceHandler = function(item:Body):void{_space.bodies.remove(item); item.space = null;}
				item.init();
			}
		}
		
		/**
		 * onMouseMove
		 */ 
		public function onMove(x:int, y:int):void
		{
			for each(var item:Controller in _controllers)
			{
				item.onMove(x,y);
			}
		}
		
		/**
		 * onMouseDown
		 */ 
		public function onDown(x:int, y:int):void
		{
			setTimeout(function():void
			{
				_explosions.addItemToXY(x,y);
				
			},400);		
		}
		
		/**
		 * update on enterframe event
		 */ 
		public function update():void
		{
			_space.step(_timeStep);
			for each(var item:Controller in _controllers)
			{
				item.update();
			}
		}
		
		/**
		 * destroy it
		 */ 
		public function destroy():void
		{
			for each(var item:Controller in _controllers)
			{
				item.destroy();
			}	
			
			_instance = null;
			_space = null;
			_planets = null;
			_meteorites = null;
			_explosions = null;
			_container = null;
			_controllers = null;
			
		}
	}
}
class Key{};