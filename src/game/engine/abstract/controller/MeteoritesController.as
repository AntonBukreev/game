package game.engine.abstract.controller
{
	import assets.Assets;
	
	import flash.external.ExternalInterface;
	
	import game.Game;
	import game.engine.abstract.model.i.iBody;
	import game.engine.abstract.model.vo.MeteoriteVO;
	import game.engine.abstract.model.vo.ObjectVO;
	import game.engine.graphic.Meteorite;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;
	
	import utils.M;

	public class MeteoritesController extends Controller 
	{
		public function MeteoritesController(key:Key)
		{}
		
		private static var _instance:MeteoritesController;
		public static function get instance():MeteoritesController
		{
			if (_instance == null) _instance = new MeteoritesController(new Key());
			return _instance;
		}
		
		public override function get itemsCount():int
		{
			return conf.meteoritesCount;
		}
		
		public override function update():void
		{
			super.update();	
		}
		
		override public function onIsOut(item:iBody):void
		{
			resetVO(item.vo);
		}
		
		public override function generateItem(x:int=0, y:int=0):iBody
		{
			var obj:MeteoriteVO = new MeteoriteVO();
				obj.generate(conf);
				return new Meteorite(obj, generateGraphic(Assets.mcPig));
		}
		

		override public function destroy():void
		{
			super.destroy();
			_instance = null;
		}
		
		
		
		
		public function collisionWithPlanet(vo:ObjectVO):void
		{
			var item:Meteorite = findItemByVO(vo);
			item.startDestroy();
		}
	}
}

class Key{};