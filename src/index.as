package
{
	import flash.display.Sprite;
	
	import game.Game;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="760", height="670")]
	public class index extends Sprite
	{
		private var statsLayer:Stats = new Stats();
		private var gameLayer:Starling;
		
		/**
		 * start
		 */ 
		public function index()
		{
			//stat remove it
			//addChild(statsLayer);
			//starling
			gameLayer = new Starling(Game, stage);
			gameLayer.antiAliasing = 1;
			gameLayer.start();
		}		
	
	}
}