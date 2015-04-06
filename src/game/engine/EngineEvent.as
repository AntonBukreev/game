package game.engine
{
	import starling.events.Event;
	
	
	public class EngineEvent extends Event
	{
		
		public static var EVENT_CHANGE_SCORE:String = "EVENT_CHANGE_SCORE";
		public static var EVENT_ADD_DOT:String = "EVENT_ADD_DOT";
		public var data:Object;
		
		public function EngineEvent(type:String, data:Object)
		{
			this.data = data;
			super(type, true);
		}
	}
}