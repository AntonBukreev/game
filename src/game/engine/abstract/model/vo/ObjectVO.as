package game.engine.abstract.model.vo
{
	import nape.geom.Vec2;

	public class ObjectVO
	{
		public static const RESET_OBJECT:String = "RESET_OBJECT";
		public static const SHOOT_OBJECT:String = "SHOOT_OBJECT";
		
		
		public var x:Number=0;
		public var y:Number=0;
		public var rotation:Number=0;
		public var mass:Number=1;
		public var velosity:Vec2 = new Vec2(0,0);
		
		public var width:Number=0;
		public var height:Number=0;
		public var radius:Number=0;
		
		public var type:String = "ObjectVO";
		
		protected var _conf:ConfVO;
		
		public function ObjectVO(x:Number = 0, y:Number = 0, rotation:Number = 0, velosity:Vec2 = null)
		{
			this.x = x;
			this.y = y;
			this.rotation = rotation;
			if (velosity != null)
			{
				this.velosity = velosity;
			}
		}
		
		public function generate(conf:ConfVO, handler:Function = null):void
		{
			this._conf = conf;
		}
		
		public function onCollision(vo:ObjectVO):String
		{
			return "";
		}
		
		
		public function isOut():Boolean
		{
			var X:int = x - _conf.width/2;
			var Y:int = y - _conf.height/2;
			var dist:int = Math.sqrt(X*X + Y*Y);
			if (dist > 2*_conf.radius) return true;
			return false;
		}
	}
}