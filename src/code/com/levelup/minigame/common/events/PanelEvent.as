/**
 * Created by IntelliJ IDEA.
 * User: SDudorov
 * Date: 17.04.12
 * Time: 11:23
 */
package com.levelup.minigame.common.events
{
	import flash.events.Event;

	public class PanelEvent extends Event
	{
		public static const REMOVED:String = "removed";

		public var panelName:String;

		public function PanelEvent(type:String, panelName:String)
		{
			super(type);

			this.panelName = panelName;
		}
	}
}
