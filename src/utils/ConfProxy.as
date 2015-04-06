package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.engine.abstract.model.vo.ConfVO;
	
	
	
	public class ConfProxy extends MovieClip
	{
		public function ConfProxy()
		{}
		
		public static var DEFAULT_CONF_PATH:String = "conf/conf.xml";
		public var loader:XmlLoader = new XmlLoader();
		public var data:ConfVO;
		
		private var _completeHandler:Function;
		
		public function load(url:String='', handler:Function = null):void
		{
			_completeHandler = handler;
			if (!url || url.length<1)
			{
				url = DEFAULT_CONF_PATH;
			}
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.loadData(url);
		}
		
		private function onComplete(e:Event):void
		{
			data = new ConfVO(loader.data);
			if (_completeHandler != null) 
			{
				_completeHandler(data);
			}
		}
		
	}
}