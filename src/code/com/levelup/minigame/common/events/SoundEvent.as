/**
 * ...
 * @author Leezarius
 */

package com.levelup.minigame.common.events
{
	import flash.events.Event;

	public class SoundEvent extends Event
	{
		public static const SOUND_ON:String = "soundOn";
		public static const SOUND_OFF:String = "soundOff";

		public function SoundEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone():Event
		{
			return new SoundEvent(type, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("SoundEvent", "type", "bubbles", "cancelable", "eventPhase");
		}

	}

}