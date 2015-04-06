package game.engine.graphic
{
	import game.engine.EngineEvent;
	import game.engine.NapeEngine;
	import game.engine.abstract.controller.MeteoritesController;
	import game.engine.abstract.model.vo.MeteoriteVO;
	
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class Meteorite extends GraphicBody
	{
		private var _destroyTimer:Number=-1;
		private var _dotTime:Number=-1;
		private const DOT_TIME:int = 50;
		private const DESTROY_TIME:int = 500;
		private const MIN_SIZE:int = 5;
		private var _circle:Circle
		
		override public function Meteorite(vo:MeteoriteVO, graphic:*)
		{
			super(vo, BodyType.DYNAMIC, graphic);
			allowRotation = true;
			_circle = new Circle(_vo.radius);
			shapes.add(_circle);
		}
		
		override public function update():void
		{
			if (_destroyTimer>0)
			{
				
				var time:int = (new Date().time - _destroyTimer);
				if (time > DESTROY_TIME)
				{
					MeteoritesController.instance.resetVO(vo);
				}
				else
				{
					var delta:int = DESTROY_TIME - time;
						
					mGraphic.width = vo.width * delta /DESTROY_TIME;
					mGraphic.height = vo.height * delta /DESTROY_TIME;
					
					mGraphic.rotation = rotation;
						
						
					var l:Number = Math.sqrt(mGraphic.width*mGraphic.width + mGraphic.height*mGraphic.height)/2;
					var dy:Number = -l*Math.cos(Math.PI/4-rotation);
					var dx:Number = -l*Math.sin(Math.PI/4-rotation);
						mGraphic.x = position.x + dx;
						mGraphic.y = position.y + dy;  
				}	
				
			}
			else
			{
			
				super.update();
				var dotTime:Number = (new Date().time - _dotTime);
				if (dotTime > DOT_TIME)	
				{
					_dotTime = new Date().time;
					NapeEngine.instance.dispatchEvent(new EngineEvent(EngineEvent.EVENT_ADD_DOT, {x:position.x, y:position.y}));
				}
			}
			
			
		}
		
		public function startDestroy():void
		{
			if (_destroyTimer<=0)
			{
				_destroyTimer = (new Date()).time;
				
				var collisionGroup:int = 0x000000010;
				var collisionMask:int =  0x000000010;
				shapes.add(new Circle(_vo.radius,null,null,new InteractionFilter(collisionGroup, collisionMask)));
				shapes.remove(_circle);
				
			}
		}
	}
}