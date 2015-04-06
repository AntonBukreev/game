package game.pages.game
{
	import assets.Assets;
	
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import game.GameEvents;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Bird extends DisplayObjectContainer
	{
		private var _bird:DisplayObject;
		private var _container:DisplayObjectContainer;
		private var _animComplete:Boolean = true;
		
		private var _positionX:int;
		private var _positionY:int;
		
		public function Bird(positionX:int, positionY:int, assetName:String)
		{
			super();
			this.x = _positionX = positionX;
			this.y = _positionY = positionY;
			this.rotation = 0;
			
			
			_container = new Sprite();
			this.addChild(_container)
			_bird = Assets.getPage2MC(assetName);
			_bird.scaleX = _bird.scaleY = 0.5;
			_bird.x = -_bird.width/2;
			_bird.y = -_bird.height/2;
			_container.addChild(_bird);	
		}
		
		
		/**
		 * on mouse move
		 */ 
		public function onMove(x:int, y:int):void
		{
			var dx:Number = Math.abs((this.x+25-x));
			var r:Number = Math.atan((this.y+25-y)/dx);
			
			if (this.x < 300)
			{
				r = -r;
			}
			_container.rotation = r;
		}	
		
		/**
		 * on mouse down
		 */ 
		public function onDown(x:int, y:int):void
		{
			
			if (_animComplete)
			{
				_animComplete = false;
				
				var tline:TimelineLite = new TimelineLite();
				tline.append(TweenLite.to(this, 0.2, {x: x, y: y, scaleX:2, scaleY:2, ease:Back.easeIn}));
				tline.append(TweenLite.to(this, 0.2, {x: x, y: y, scaleX:0.1, scaleY:0.1, onComplete: onAnimComplete} ));
			}
			
			
		}	
		
		private function onAnimComplete():void
		{
			this.x = _positionX;
			this.y = _positionY;
			TweenLite.to(this, 0.2, {scaleX:1, scaleY:1, onComplete: onShowAnimComplete});
		}
		
		private function onShowAnimComplete():void
		{
			_animComplete = true;	
		}
		
		/**
		 * destroy
		 */ 
		public function destroy():void
		{
			_container.removeChild(_bird);
			_bird = null;
			_container = null;
		}	
			
			
	}
}