package game.engine.abstract.controller
{
	import assets.Assets;
	
	import game.engine.abstract.model.i.iBody;
	import game.engine.abstract.model.vo.ExplosionVO;
	import game.engine.graphic.Explosion;
	import game.engine.graphic.GraphicBody;

	public class ExplosionController extends Controller 
	{
		public function ExplosionController(key:Key)
		{
		}
		
		private static var _instance:ExplosionController;
		private var _secondExplosion:Boolean = false;
		
		public static function get instance():ExplosionController
		{
			if (_instance == null) _instance = new ExplosionController(new Key());
			return _instance;
		}
		
		override public function  init():void
		{
		
		}
		
		override public function get generateItems():Array
		{
			items = [];
			return items;
		}
		
		override public function generateItem(x:int=0, y:int=0):iBody
		{
			var obj:ExplosionVO = new ExplosionVO(x,y);
			obj.generate(conf);
			var name:String = _secondExplosion ? Assets.mcGreen : Assets.mcBlue;
			return new Explosion(obj, generateGraphic(name));
		}
		
		override public function update():void
		{
			for each(var item:GraphicBody in items)
			{
				item.update();
			}
		}
		
		override public function resetItem(item:iBody):void
		{
			if (item)
			{
				destroyView(item);
			}
		}
		
		public function addItemToXY(x:int, y:int, secondExplosion:Boolean = false):void
		{
			_secondExplosion = secondExplosion;
			var item:Explosion = generateItem(x,y) as Explosion;
			items.push(item);
			addToSpaceHandler(item);
		}
		
		override public function destroy():void
		{
			super.destroy();
			_instance = null;
		}
		
	}
}
class Key{};