/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.common.managers.panels
{
	import com.greensock.TweenMax;
	import com.levelup.minigame.api.view.IPanel;
	import com.levelup.minigame.common.events.ProjectEvent;
	import com.levelup.minigame.common.managers.*;
	import com.levelup.minigame.common.params.PanelNames;
	import com.levelup.minigame.common.params.PanelTypes;

    import com.levelup.minigame.view.panels.popups.*;
	import com.levelup.minigame.view.panels.scene.*;

	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

import popups.PopupBusy;

import scenes.ViewSceneLobby;

public class PanelsManager extends EventDispatcher
	{
		public static const updater: EventDispatcher = new EventDispatcher();

		private static var _placeTarget:Sprite;

		private static var uiContainer:Sprite;
		private static var sceneContainer:Sprite;
		private static var popupContainer:Sprite;
		private static var blendContainer:Sprite;
		private static var errorContainer:Sprite;

		private static var blendCounter:int;
		private static var panels: Array = [];
		private static var _currentScene: String;
		private static var resReadyFlag: Boolean = false;
		private static var popupStack: Array = [];
		private static var popupException: Array = [];

		private static function createPanel(name:String, data:Object):IPanel
		{
			var panel: IPanel;
			switch (name)
			{

                case PanelNames.SCENE_START:		            panel = new StartScene(name, data); break;
				case PanelNames.SCENE_LOBBY: 				    panel = new LobbyScene (name, data); break;
                case PanelNames.SCENE_GAME: 				    panel = new GameScene (name, data); break;

				case PanelNames.POPUP_BUSY: 				    panel = new BusyPopup(name, data); break;
                case PanelNames.POPUP_CHEST: 				    panel = new PopupChest(name, data); break;
                case PanelNames.POPUP_BOOST: 				    panel = new PopupBoost(name, data); break;
                case PanelNames.POPUP_GAME_OVER: 				panel = new GameOver(name, data); break;
                case PanelNames.POPUP_PRIZE: 				    panel = new PopupPrize(name, data); break;
                case PanelNames.POPUP_BRIEFING: 				panel = new PopupBriefing(name, data); break;
                case PanelNames.POPUP_OPEN_CHEST_PRIZE: 		panel = new PopupOpenChestPrize(name, data); break;
                case PanelNames.POPUP_TUTORIAL: 		        panel = new PopupTutorial(name, data); break;
                case PanelNames.POPUP_SETTINGS: 		        panel = new PopupSettings(name, data); break;


			}
			
			return panel;
		}

        public static function getDefinitionByName(name:String):Class
        {
            switch(name)
            {
                case PanelNames.SCENE_START:            return scenes.START;
                case PanelNames.SCENE_LOBBY:            return scenes.ViewSceneLobby;
                case PanelNames.SCENE_GAME:             return scenes.GameScene;

                case PanelNames.POPUP_BUSY:             return popups.PopupBusy;
                case PanelNames.POPUP_CHEST:            return popups.PopupChest;
                case PanelNames.POPUP_BOOST:            return popups.PopupBoost;
                case PanelNames.POPUP_GAME_OVER:        return popups.PopupGameOver;
                case PanelNames.POPUP_PRIZE:            return popups.PopupPrize;
                case PanelNames.POPUP_BRIEFING:         return popups.PopupBriefing;
                case PanelNames.POPUP_OPEN_CHEST_PRIZE: return popups.PopupOpenChestPrize;
                case PanelNames.POPUP_TUTORIAL:         return popups.PopupTutorial;
                case PanelNames.POPUP_SETTINGS:         return popups.PopupSettings;
            }
            return Sprite;
        }


		public static function addPanel(name:String, data:Object = null, show:Boolean = true, onBottom:Boolean = false):void
		{
			if (!resReady && show)
			{
				TweenMax.delayedCall(1, addPanel, [name, data, show, onBottom]);
				return;
			}
			
			if (getPanelByName(name))
			{
				showPanel(name, data, onBottom);
				return;
			}
			
			panels.push(createPanel(name, data));
			updater.dispatchEvent(new ProjectEvent(ProjectEvent.PANEL_ADD, { name: name } ));
			
			if (show) showPanel(name, data, onBottom);
		}

		public static function showPanel(name:String, data:Object = null, onBottom:Boolean = false):void
		{
			if (!getPanelByName(name)) 
			{
				return;
			}

			var panel:IPanel = getPanelByName(name);
			
			if (data) panel.data = data;

			if (panel.type == PanelTypes.PANEL_UI)    uiContainer.addChild(panel.displayObj);
			if (panel.type == PanelTypes.PANEL_BLEND) blendContainer.addChild(panel.displayObj);
			if (panel.type == PanelTypes.PANEL_SCENE)
			{
				_currentScene = panel.name;
				sceneContainer.addChild(panel.displayObj);
			}

			if (panel.type == PanelTypes.PANEL_ERROR)
			{
				errorContainer.addChild(panel.displayObj);
				if(ExternalInterface.available) ExternalInterface.call("appOnTop", 1);
			}

			if (panel.type == PanelTypes.PANEL_POPUP)
			{
				if(!checkException(name) && (popupContainer.numChildren != 0 || !CommonManager.applicationIsReady))
				{
					popupStack.push({name: name, data: data, onBottom: onBottom});
					return;
				}

				if (!onBottom)
					popupContainer.addChild(panel.displayObj);
				else
					popupContainer.addChildAt(panel.displayObj, 0);

				if(ExternalInterface.available) ExternalInterface.call("appOnTop", 1);
			}
			
			for each(var othPanel: IPanel in panels)
			{
				othPanel.isInFocus = false;
			}
			
			panel.show();
			updater.dispatchEvent(new ProjectEvent(ProjectEvent.PANEL_SHOW, { name: name } ));
		}

		private static function checkException (name: String): Boolean
		{
			for each(var n: String in popupException)
			{
				if(n == name) return true;
			}

			return false;
		}

		public static function hidePanel(name:String):void
		{
			var panel: IPanel = getPanelByName(name);
			if (!panel) return;

			panel.hide();
			updater.dispatchEvent(new ProjectEvent(ProjectEvent.PANEL_HIDE, { name: name } ));
			checkStackPopup();
		}

		public static function removePanel(name:String):void
		{
			if (!getPanelByName(name)) return;

			var isPopup: Boolean = false;
			var panel:IPanel = getPanelByName(name);
			panel.destroy();
			if(panel.displayObj && panel.displayObj.parent) panel.displayObj.parent.removeChild(panel.displayObj);

			var cnt: int = panels.length;
			for (var i: int; i < cnt; i++)
			{
				if (panels[i] && panels[i].name == name)
				{
					panels.splice(i, 1);
				}
			}

			for each (panel in panels)
			{
				if (panel.type == PanelTypes.PANEL_POPUP)
				{
					isPopup = true;
					break;
				}
			}

			cnt = panels.length;
			if (cnt > 0) (panels[cnt - 1] as IPanel).isInFocus = true;
			if(!isPopup && ExternalInterface.available) ExternalInterface.call("appOnTop", 0);

			updater.dispatchEvent(new ProjectEvent(ProjectEvent.PANEL_DEL, { name: name } ));
			checkStackPopup();
		}

		public static function switchCurrentScene(newPanel:String, data:Object = null, removeOldPanel:Boolean = true):void
		{
			if(newPanel == _currentScene) return;
			switchPanel(newPanel, _currentScene, data, removeOldPanel);
		}

		public static function switchPanel(newPanel:String, oldPanel:String, data:Object = null, removeOldPanel:Boolean = true):void
		{
			addPanel(newPanel, data);

			if (removeOldPanel) removePanel(oldPanel);
			else   				hidePanel(oldPanel);
		}

		public static function getPanelByName(name:String):IPanel
		{
			for each (var panel: IPanel in panels)
			{
				if (panel.name == name) return panel;
			}
			
			return null;
		}

		public static function blendOn():void
		{
			if (!CommonManager.applicationIsReady) return;

			if (blendContainer.numChildren == 0) addPanel(PanelNames.POPUP_BUSY);
			blendCounter++;
		}

		public static function blendOff():void
		{
			TweenMax.delayedCall(1, destroyBlend);
		}
		
		private static function destroyBlend (): void
		{
			blendCounter--;
			if (blendCounter <= 0)
			{
				removePanel(PanelNames.POPUP_BUSY);
				blendCounter = 0;
				TweenMax.killDelayedCallsTo(destroyBlend);
			}
		}

		private static function checkStackPopup (): void
		{
			if(popupStack.length < 1) return;
			var data: Object = popupStack.shift();
			showPanel(data.name, data.data, data.onBottom);
		}

		public static function set resReady (value: Boolean): void { resReadyFlag = value; }
		public static function get resReady (): Boolean { return resReadyFlag ; }

		public static function set placeTarget(value: Sprite): void
		{
			_placeTarget = value;

			sceneContainer = _placeTarget.addChild(new Sprite()) as Sprite;
			uiContainer = _placeTarget.addChild(new Sprite()) as Sprite;
			popupContainer = _placeTarget.addChild(new Sprite()) as Sprite;
			blendContainer = _placeTarget.addChild(new Sprite()) as Sprite;
			errorContainer = _placeTarget.addChild(new Sprite()) as Sprite;

            appReadyHandler();
		}

        public static function get placeTarget(): Sprite { return _placeTarget; }
		public static function get currentScene(): String { return _currentScene; }

        private static function appReadyHandler():void
        {
            checkStackPopup();
        }
	}
}