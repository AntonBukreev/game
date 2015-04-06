package game.pages.game
{
	import com.greensock.TweenLite;
	
	import starling.text.TextField;
	
	public class ScoreChangeText extends TextField
	{
		public function ScoreChangeText(x:int,y:int,score:String)
		{
			super(100, 100, text);
			
			this.fontName = "Myriad Pro";
			this.text = "+" + score;
			this.fontSize = 23;
			this.bold = true;
			this.color = 0x00ff00;
			this.alpha = 1;
			
			this.x = x;
			this.y = y;
		}
		
		public function animate():void
		{
			
			this.x -= this.width/2 ;
			this.y -= this.height/2 - 20;
			
			TweenLite.to(this, 1, {y:this.y-110, alpha:0.1, scaleX:1.5, scaleY:1.5, onComplete:onComplete});
		}
		
		private function onComplete():void
		{
			parent.removeChild(this);
		}
	}
}