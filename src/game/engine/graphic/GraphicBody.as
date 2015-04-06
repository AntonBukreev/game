package game.engine.graphic
{
	import game.engine.EngineEvent;
	import game.engine.abstract.model.i.iBody;
	import game.engine.abstract.model.vo.MeteoriteVO;
	import game.engine.abstract.model.vo.ObjectVO;
	
	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;
	
	public class GraphicBody extends Body implements iBody
	{
		public var mGraphic:MovieClip;
		
		protected var _vo:ObjectVO;
		
		public function set vo(value:ObjectVO):void
		{
			_vo = value; 
			position.x = value.x;
			position.y = value.y;
			rotation = value.rotation;
			mass = value.mass;
			velocity = value.velosity;
		}
		public function get vo():ObjectVO
		{
			_vo.x = position.x;
			_vo.y = position.y;
			_vo.rotation = rotation;
			_vo.velosity = _vo.velosity;
			return _vo; 
		}
		
		public function GraphicBody(vo:ObjectVO, type:BodyType=null, graphic:*=null)
		{
			super(type);
			this.vo = vo;
			
			graphic.width = _vo.width;
			graphic.height = _vo.height;
			this.mGraphic = graphic;
		}
		
		/**
		 * update graphic position on enterframe
		 */ 
		public function update():void
		{
			mGraphic.rotation = rotation;
			var l:Number = Math.sqrt(_vo.width*_vo.width + _vo.height*_vo.height)/2;
			var dy:Number = -l*Math.cos(Math.PI/4-rotation);
			var dx:Number = -l*Math.sin(Math.PI/4-rotation);
			mGraphic.x = position.x + dx;
			mGraphic.y = position.y + dy;  
			
			checkCollision(this); 
		}
		
		/**
		 * check crashes
		 */ 
		public function checkCollision(item:*):void
		{
			for(var i:int = 0; i < this.arbiters.length; i++)
			{
				var arb:Arbiter = this.arbiters.at(i);
				if (arb.isCollisionArbiter()) 
				{
					//trace(this.vo.type," crash with ", (arb.body2 as GraphicBody).vo.type);
					this.onCollision(arb.body2 as iBody);
					//(arb.body2 as GraphicBody).onCollision(this);
				}
			}
		}
		
		public function onCollision(item:iBody):void
		{
			vo.onCollision(item.vo);
		}
		
		public function destroy():void
		{
			_vo = null;
			mGraphic = null;
		}
	}
}  