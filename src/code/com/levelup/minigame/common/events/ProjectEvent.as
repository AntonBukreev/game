/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.common.events
{
	import flash.events.Event;

	public class ProjectEvent extends Event
	{
		public static const GAME_STARTED:String = "game.started";
		public static const EXIT_GAME:String = "exit.game";
		
		public static const TUTOR_LINE_END:String = "end.tutor.line";

		public static const APPLICATION_IS_READY:String = "application.is.ready";
		public static const USER_LOGGED_IN:String = "user.logged.in";
		public static const CHANGE_LANG:String = "change.lang";
		
		public static const CLOSE_RESULT_WINDOW:String = "close.result.window";
		public static const CELL_SELECT:String = "cell.select";
        public static const CELL_DUEL_SELECT:String = "cell.duel.select";
		public static const CELL_ROLL_OVER:String = "cell.roll.over";
		
		public static const PANEL_ADD:String = "panel.add";
		public static const PANEL_DEL:String = "panel.del";
		public static const PANEL_SHOW:String = "panel.show";
		public static const PANEL_HIDE:String = "panel.hide";

		public static const GIFT_WALL_POST_COMPLETE:String = "gift.wall.post.complete";

		private var _data:Object;

		public function ProjectEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		public function get data():Object
		{
			return _data;
		}
	}
}