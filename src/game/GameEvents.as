package game
{
	import starling.events.Event;
	
	public class GameEvents extends Event
	{
		public var data:Object;
		
		public function GameEvents(type:String, data:Object=null)
		{
			this.data = data;
			super(type, true);
		}
		
		public static var EVENT_OPEN_GAME_PAGE:String = "EVENT_OPEN_GAME_PAGE";
		public static var EVENT_OPEN_START_PAGE:String = "EVENT_OPEN_START_PAGE";
	}
}