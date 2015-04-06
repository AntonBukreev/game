package com.levelup.minigame.common.managers.sound.events
{
	import flash.events.Event;

	public class SoundManagerEvent extends Event
	{
		public static const SOUND_LOADED: String = "SoundManager.SoundLoaded";
		public static const SOUND_STATE_CHANGE: String = "SoundManager.SoundStateChange";

		private var _oData: Object;

		public function SoundManagerEvent(type: String, data: Object = null, bubbles: Boolean = false, cancelable: Boolean = false)
		{
			_oData = data;
			super(type, bubbles, cancelable);
		}

		public override function clone(): Event
		{
			return new SoundManagerEvent(type, _oData, bubbles, cancelable);
		}

		public override function toString(): String
		{
			return formatToString("SoundManagerEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}

		public function get data(): Object
		{
			return _oData;
		}
	}
}