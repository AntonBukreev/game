package game.pages.game
{
	import assets.Assets;
	
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;
	
	public class Dot extends DisplayObjectContainer
	{
		public function Dot()
		{
			super();
			
			var dot:MovieClip = Assets.getPage2MC(Assets.mcDot);
			addChild(dot);
			
		}
		
		public function animate():void
		{
			TweenLite.to(this, 0.5, {x:x+width/2, y:y+height/2,alpha:0, scaleX:0.5, scaleY:0.5, onComplete:onComplete});
		}
		
		private function onComplete():void
		{
			parent.removeChild(this);
		}
	}
}