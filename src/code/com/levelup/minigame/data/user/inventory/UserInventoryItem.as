/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user.inventory
{
	import com.encryption.EncryptedInt;
	import com.levelup.minigame.common.managers.CommonManager;

	import flash.events.EventDispatcher;

	public class UserInventoryItem extends EventDispatcher
	{
		private var _id:String;
		private var _change: Function;
		private var _count:EncryptedInt;

		public function UserInventoryItem(id:String, change: Function) 
		{
			this._id = id;
			this._change = change;
			
			_count = new EncryptedInt();
		}

		public function get id():String { return _id; }

		public function get count():int { return _count.val; }
		public function set count(value:int):void 
		{
			_count.val = value;
			_change(id, value);
		}

	}
}