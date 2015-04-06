/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.common.managers
{
	import com.levelup.minigame.api.view.IUserInterfaceItem;
	import com.levelup.minigame.common.params.UIItemNames;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class UserInterfaceManager
	{
		private static var uiClip:Sprite;
		private static var isAdvShow: Boolean;
		public static var uiItems:Dictionary;

		public static function init(clip:Sprite):void
		{
			uiClip = clip;

			uiItems = new Dictionary();

			createItems();
			initItems();
		}
		
		private static function initItems (): void
		{
			for each (var item: IUserInterfaceItem in uiItems)
			{
				item.init();
			}
		}

		private static function createItems():void
		{
            /*
			addItem(UIItemNames.CONTROLS_GAME, UserGameControls, uiClip["gameControlsClip"]);
			addItem(UIItemNames.CONTROLS_LOBBY, UserLobbyControls, uiClip["lobbyControlsClip"]);
			addItem(UIItemNames.CONTROLS_TO_LOBBY, UserToLobbyControls, uiClip["toLobbyControlsClip"]);
			addItem(UIItemNames.USER_INFO, UserInfo, uiClip["userInfoClip"]);
              */
			if(isAdvShow) showAdvertising(isAdvShow);
		}

		private static function addItem(name:String, classValue:Class, clip:MovieClip):void
		{
			uiItems[name] = new classValue(name, clip);
		}

		public static function showItem(name:String, flag:Boolean):void
		{
			if (!getUiItemByName(name)) return;

			getUiItemByName(name).show = flag;
		}

		public static function showAdvertising (value: Boolean): void
		{
			for each (var uiItem: IUserInterfaceItem in uiItems)
			{
				uiItem.showAdvertising = value;
			}
			isAdvShow = value;
		}
		
		public static function getUiItemByName(name:String):IUserInterfaceItem
		{
			if (!uiItems || !uiItems[name]) return null;

			return uiItems[name] as IUserInterfaceItem;
		}
	}
}