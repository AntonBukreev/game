/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user
{
	import com.adobe.utils.DictionaryUtil;

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class AbstractDataEntity extends EventDispatcher
	{
		protected var _items:Dictionary;

		public function AbstractDataEntity() 
		{
			_items = new Dictionary();
		}

		public function get items (): Dictionary { return _items; }
	}
}