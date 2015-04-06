package game.engine.abstract.controller
{
	import assets.Assets;
	
	import game.engine.abstract.model.i.iBody;
	import game.engine.abstract.model.vo.PlanetVO;
	import game.engine.graphic.Meteorite;
	import game.engine.graphic.Planet;
	
	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	
	import utils.M;
	
	public class PlanetsController extends Controller
	{
		public function PlanetsController(key:Key)
		{}
		
		private static var _instance:PlanetsController;
		
		public static function get instance():PlanetsController
		{
			if (_instance == null) _instance = new PlanetsController(new Key());
			return _instance;
		}
		
		public override function get itemsCount():int
		{
			return conf.planetsCount;
		}
		
		public override function update():void
		{
			super.update();
			setGravity(items, MeteoritesController.instance.items);
		}
		
		private function setGravity(staticList:Array, dynamicList:Array):void
		{
			for each(var dynamic:iBody in dynamicList)
			{
				var f:Vec2 = new Vec2(0,0);
				for each(var static:iBody in checkGravityRadius(staticList, dynamic))
				{
					f = appendForse(f, setForce(static, dynamic));
				}
				dynamic.applyWorldForce(f);
			}
		}
		
		private function appendForse(v1:Vec2, v2:Vec2):Vec2
		{
			return new Vec2( v1.x+v2.x , v1.y + v2.y);
		}
		
		private function setForce(static:iBody, dynamic:iBody):Vec2
		{
			var G:Number = 2000;
			var D:Number = distance(static,dynamic);
			var F:Number = G*(static.vo.mass*dynamic.vo.mass)/D/D;
			
			var dx:int = dynamic.vo.x - static.vo.x;
			var dy:int = static.vo.y - dynamic.vo.y;
				
			var Fx:Number = -F*dx/D
			var Fy:Number = F*dy/D
			
			return new Vec2(Fx,Fy);
		}
		
		private function checkGravityRadius(staticList:Array, dynamic:iBody):Array
		{
			var out:Array = [];

			for each(var planet:iBody in staticList)
			{
				if (distance(planet, dynamic) < (planet.vo as PlanetVO).gravityRadius*3)
				{
					out.push(planet);
				}
			}
			return out;
		}
		
		public function distance(b1:iBody, b2:iBody):int
		{
			var x:int = b1.vo.x - b2.vo.x; 
			var y:int = b1.vo.y - b2.vo.y;
			return Math.sqrt(x*x + y*y);
		}
		
		public override function generateItem(x:int=0, y:int=0):iBody
		{
			var obj:PlanetVO = new PlanetVO();
			obj.generate(conf, isFinePosition);
			return new Planet(obj, generateGraphic(Assets.mcPlanet));
		}
		
		private function isFinePosition(vo:PlanetVO):Boolean
		{
			var minGap:int = 40;
			if (vo.x < vo.radius || vo.y < vo.radius || vo.x > conf.width-vo.radius || vo.y > conf.height-vo.radius) return false;
			
			for each(var planet:Planet in items)
			{
				var distance:Number = M.pow(planet.position.x - vo.x) + M.pow(planet.position.y - vo.y);
				if (distance <= M.pow((planet.vo as PlanetVO).gravityRadius + vo.radius + minGap)) return false;
			}
			return true;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_instance = null;
		}
		
	}
}

class Key{};