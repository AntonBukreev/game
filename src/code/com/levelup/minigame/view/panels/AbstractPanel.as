/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.panels
{
	import com.levelup.minigame.api.view.IPanel;
	import com.levelup.minigame.common.managers.language.LanguageManager;
	import com.levelup.minigame.common.managers.panels.PanelsManager;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	public class AbstractPanel extends Sprite implements IPanel
	{
		protected var panelName: String;
		protected var panelData: Object;
		protected var panelType: String;
		protected var inFocus: Boolean;

		public function AbstractPanel(panelName: String, panelData: Object)
		{
			this.panelName = panelName;
			this.panelData = panelData;

			init();

			super();
		}

		protected function init(): void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			initView();
		}

		protected function initView(): void
		{
			LanguageManager.parse(this);
		}

		private function onAddedToStageHandler(event: Event): void
		{
			openPanel();
		}

		protected function openPanel(): void { }

		public function remove(): void
		{
			PanelsManager.removePanel(panelName);
		}

		public function destroy(): void
		{
			panelData = null;
		}

		public function show(): void { visible = inFocus = true; }

		public function hide(): void { visible = inFocus = false;}

		override public function get name(): String { return panelName; }

		public function get type(): String { return panelType; }

		public function get displayObj(): DisplayObject { return this; }

		public function set data(value: Object): void { panelData = value; }

		public function get data(): Object { return panelData; }

		public function set isInFocus(value: Boolean): void { inFocus = value; }

		public function get isInFocus(): Boolean { return inFocus; }
	}
}