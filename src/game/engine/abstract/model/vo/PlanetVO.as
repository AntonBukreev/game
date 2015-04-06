package game.engine.abstract.model.vo
{

	import game.engine.abstract.controller.MeteoritesController;

	
	import nape.geom.Vec2;
	
	public class PlanetVO extends ObjectVO
	{
		
		
		public var gravityRadius:Number=0;
		
		public function PlanetVO(x:Number = 0, y:Number = 0, rotation:Number = 0, radius:Number = 0, velosity:Vec2 = null)
		{
			super(x, y, rotation, velosity);
			this.radius = radius; 
		}
		
		override public function generate(conf:ConfVO, handler:Function = null):void
		{
			super.generate(conf);
			x = Math.random() * _conf.width;
			y = Math.random() * _conf.height;
			radius = Math.random() * _conf.planetsSizeMax + _conf.planetsSizeMin;
			width = 2.5*radius;
			height = 2.5*radius;
			gravityRadius = radius;
			mass = gravityRadius*20;
			
			if (!handler(this))
			{
				generate(_conf, handler);
			}
			type = "PlanetVO";
		}
		
		override public function onCollision(vo:ObjectVO):String
		{
			if (vo is MeteoriteVO)
			{
				MeteoritesController.instance.collisionWithPlanet(vo);
				return ObjectVO.RESET_OBJECT;
			}
			

			return "";
		}
	}
}