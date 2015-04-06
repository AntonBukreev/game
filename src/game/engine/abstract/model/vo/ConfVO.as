package game.engine.abstract.model.vo
{
	
	public class ConfVO extends Object
	{
		
		public var explosionSizeMin:int;
		public var explosionSizeMax:int;
		public var explosionTimeBorn:int;
		public var explosionTimeLife:int;		
		public var planetsCount:int;
		public var planetsSizeMax:int;
		public var planetsSizeMin:int;
		public var meteoritesCount:int;
		public var meteoritesSpeedMax:int;
		public var meteoritesSpeedMin:int;
		public var meteoritesSizeMax:int;
		public var meteoritesSizeMin:int;
		
		public var width:int = 760;
		public var height:int = 670;
		private var _radius:int;
		
		public function get radius():int
		{
			return _radius;
		}
		
		public function setRadius():void
		{
			_radius = Math.sqrt((width*width/4)+(height*height/4));
		}
		
		public function ConfVO(xml:XML = null)
		{
			super();
			
			setRadius();
			
			if (xml)
			{
				_setData(xml);
			}
			else
			{
				setDefault();
			}
		}
		
		private function _setData(xml:XML):void
		{
			try
			{
				explosionSizeMin = int(xml.explosion.size.min);
				explosionSizeMax = int(xml.explosion.size.max);
				explosionTimeBorn = int(xml.explosion.time.born);
				explosionTimeLife = int(xml.explosion.time.life);
				
				planetsCount = int(xml.planets.count);
				planetsSizeMax = int(xml.planets.size.max);
				planetsSizeMin = int(xml.planets.size.min);
				
				meteoritesCount = int(xml.meteorites.count);
				meteoritesSpeedMax = int(xml.meteorites.speed.max);
				meteoritesSpeedMin = int(xml.meteorites.speed.min);
				meteoritesSizeMax = int(xml.meteorites.size.max);
				meteoritesSizeMin = int(xml.meteorites.size.min);
			}
			catch(e:*)
			{
				setDefault();
			}
		}
		
		private function setDefault():void 
		{
			explosionSizeMin = 10;
			explosionSizeMax = 50;
			explosionTimeBorn = 500;
			explosionTimeLife = 500;
			
			meteoritesCount = 1;
			meteoritesSpeedMax = 50;
			meteoritesSpeedMin = 10;
			meteoritesSizeMax = 20;
			meteoritesSizeMin = 5;
			
			planetsCount = 1;
			planetsSizeMax = 50;
			planetsSizeMin = 20;
		}
	}
}