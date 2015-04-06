package game.pages.game
{
	import assets.Assets;
	
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;

	public class DotContainer extends DisplayObjectContainer
	{
		public function DotContainer()
		{
			super();
		}
		
		public function addDot(x:int, y:int):void
		{
			var dot:Dot = new Dot();
			dot.x = x-dot.width/2;
			dot.y = y-dot.height/2;
			addChild(dot);
			dot.animate();
		}	
			
	}
}