/**
 * ...
 * @author Morozov V.
 */
package com.levelup.minigame.common.managers
{
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.data.game.GameData;
import com.levelup.minigame.data.user.UserData;

import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;

	public class CommonManager extends EventDispatcher
	{
		public static var userData:UserData = new UserData();
		public static var gameData:GameData = new GameData();
		public static var eventManager:EventProjectManager = new EventProjectManager();

		private static var _applicationIsReady:Boolean = false;

		public static function get applicationIsReady():Boolean { return _applicationIsReady; }

        public static function start(stage:DisplayObjectContainer):void
        {
            _applicationIsReady = true;
            SoundManager.start(stage);
        }
	}
}