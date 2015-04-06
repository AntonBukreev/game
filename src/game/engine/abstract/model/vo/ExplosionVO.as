package game.engine.abstract.model.vo
{
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	import game.engine.EngineEvent;
	import game.engine.NapeEngine;
	import game.engine.abstract.controller.ExplosionController;
	import game.engine.abstract.controller.MeteoritesController;
	
	import nape.geom.Vec2;
	
	public class ExplosionVO extends ObjectVO
	{
		public function ExplosionVO(x:Number=0, y:Number=0)
		{
			super(x, y, 0, null);
		}
		
		override public function generate(conf:ConfVO, handler:Function = null):void
		{
			super.generate(conf);
			
			radius = Math.random() * _conf.explosionSizeMax + _conf.explosionSizeMin;
			mass = radius;
			
			width = radius*2.5;
			height = radius*2.5;
			
			type = "ExplosionVO";
		}
		
		override public function onCollision(vo:ObjectVO):String
		{
			
			if (vo is MeteoriteVO)
			{
				NapeEngine.instance.dispatchEvent(new EngineEvent(EngineEvent.EVENT_CHANGE_SCORE,  {score:int(vo.radius), x:vo.x, y:vo.y}));
				ExplosionController.instance.addItemToXY(vo.x,vo.y,true);	
				MeteoritesController.instance.resetVO(vo);	
				return ObjectVO.SHOOT_OBJECT;
			}
			
			
			return "";
		}
	}
	
	
}