package game.pages.game
{
	import assets.Assets;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Stage;

	public class BirdsController
	{
		private var _birds:Array = [];
		private var _currentIndex:int = 0;
		private var _container:DisplayObjectContainer;
		
		public function BirdsController(container:DisplayObjectContainer)
		{
			_birds = [];
			_currentIndex = 0;
			_container= container;
			
			_birds.push(new Bird( 45,  45, Assets.mcBird0));
			_birds.push(new Bird(container.stage.width - 45,  45, Assets.mcBird1));
			_birds.push(new Bird(container.stage.width - 45,  container.stage.height - 45, Assets.mcBird2));
			_birds.push(new Bird( 45,  container.stage.height - 45, Assets.mcBird3));
			
			for each (var bird:Bird in _birds)
			{
				container.addChild(bird);	
			}
			
		}
		
		/**
		 * on Mouse Move
		 */ 
		public function onMove(x:int, y:int):void
		{
			for each (var bird:Bird in _birds)
			{
				bird.onMove(x,y);
			}
		}
		
		/**
		 * on Mouse Down
		 */ 
		public function onDown(x:int, y:int):void
		{
			if (_currentIndex >= _birds.length)
				_currentIndex = 0;
			
			var bird:Bird = _birds[_currentIndex];
			bird.onDown(x,y);
			
			_currentIndex += 1;
		}
		
		/**
		 * destroy
		 */ 
		public function destroy():void
		{
			
			for each (var bird:Bird in _birds)
			{
				bird.destroy();
			}
			
			_birds = [];
		}
	}
}

