package com.levelup.minigame.data.user.userEvents {

	import flash.events.Event;

	public class UserEvent extends Event
	{
		private var _data:Object;

		public static const UPDATE_INVENTORY:String = "update.inventory.event";
		public static const UPDATE_INVENTORY_ITEM:String = "update.inventory.item.event";
		
		public static const UPDATE_CONFIG:String = "update.config.event";
		

		public function UserEvent(type:String, data:Object = null) 
		{
			super(type);
			_data = data;
		}

		public override function clone():Event { return new UserEvent(type, _data); }

		public function get data():Object { return _data; }
		public function set data(value:Object):void { _data = value; }
	}
}