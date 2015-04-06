package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class XmlLoader extends MovieClip
	{
		public function XmlLoader()
		{}
		/**
		 * xml data
		 */ 
		public var data:XML = null;
		
		/**
		 * loader
		 */ 
		private var xmlLoader:URLLoader = new URLLoader();
		
		
		/**
		 * load xml file by url
		 */ 
		public function loadData(url:String ):void
		{
			try
			{
				var request:URLRequest = new URLRequest(url);
				xmlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
				xmlLoader.load(request);
			}
			catch(e:*)
			{
				showError(e);
			}
		}
		/**
		 * on loading complete
		 */ 
		private function onLoadComplete(e:Event):void
		{
			try
			{
				xmlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
				data = new XML(e.target.data);
				var event:Event = new Event(Event.COMPLETE,true);
				dispatchEvent(event);
				xmlLoader.close();
			}
			catch(e:*)
			{
				showError(e);
			}
		}
		
		/**
		 * on error
		 */ 
		private function showError(e:*):void
		{
			trace(e);
		}
		
	}
}