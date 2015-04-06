package game.engine.abstract.model.vo
{

	import game.engine.EngineEvent;
	import game.engine.NapeEngine;
	import game.engine.abstract.controller.ExplosionController;
	import game.engine.abstract.controller.MeteoritesController;
	
	import nape.geom.Vec2;
	
	import utils.M;
	
	public class MeteoriteVO extends ObjectVO
	{
		
		
		public function MeteoriteVO(x:Number = 0, y:Number = 0, rotation:Number = 0, radius:Number = 0, velosity:Vec2 = null)
		{
			super(x, y, rotation, velosity);
			this.radius = radius; 
		}
		
		override public function generate(conf:ConfVO, handler:Function = null):void
		{
			super.generate(conf);
			var radius1:int =  _conf.radius+_conf.radius * Math.random();
			var X:int = 2 * radius1 * Math.random() - radius1;
			var Y:int = M.randomSign()*Math.sqrt(radius1*radius1 - X*X);
			radius = Math.random() * _conf.meteoritesSizeMax + _conf.meteoritesSizeMin;
			mass = radius;
			var vx:int = -X/radius1 * (Math.random() * _conf.meteoritesSpeedMax + _conf.meteoritesSpeedMin) + Math.random() * 2*_conf.meteoritesSpeedMin - _conf.meteoritesSpeedMin;
			var vy:int = Y/radius1 * (Math.random() *_conf.meteoritesSpeedMax + _conf.meteoritesSpeedMin);
			velosity = new Vec2(vx, vy);
			this.x = X + _conf.width/2;
			this.y = _conf.height/2 - Y; 
			width = radius*2;
			height = radius*2;
			type = "MeteoriteVO";
		}
		
		
		override public function onCollision(vo:ObjectVO):String
		{
			if (vo is ExplosionVO)
			{
				NapeEngine.instance.dispatchEvent(new EngineEvent(EngineEvent.EVENT_CHANGE_SCORE, {score:int(radius), x:x, y:y}));
				ExplosionController.instance.addItemToXY(x,y,true);
				MeteoritesController.instance.resetVO(this);
				return ObjectVO.SHOOT_OBJECT;
			}
			return "";
		}
	} 
}