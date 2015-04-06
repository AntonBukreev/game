package game.pages.start
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import game.Game;
	
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	
	public class YourScore extends DisplayObjectContainer
	{
		public function YourScore(score:String)
		{
			super();
			var scoreTF:TextField = new TextField(300,100,"your score");
			addChild(scoreTF);
			scoreTF.fontName = "Myriad Pro";
			scoreTF.text = "YOUR SCORE\n" + score;
			scoreTF.fontSize = 32;
			scoreTF.bold = true;
			scoreTF.color = 0xffffff;
			scoreTF.alpha = 0.5;
			scoreTF.x = Game.conf.width/2-scoreTF.width/2+10;
			scoreTF.y = -100;
			
			TweenLite.to(scoreTF,0.5,{delay:1, y:Game.conf.height/2-scoreTF.height/2-130, ease:Bounce.easeOut});
		}
	}
}