package com.levelup.minigame.view.panels.popups
{
	import com.levelup.minigame.common.params.PanelTypes;

	public class BusyPopup extends AbstractPopup
	{
		public function BusyPopup(panelName: String, panelData: Object)
		{
			super(panelName, panelData);
			panelType = PanelTypes.PANEL_BLEND;
			openSoundName = "";
		}

		override protected function expandStart(): void
		{
			view.x = bgClip.width / 2;
			view.y = bgClip.height / 2;
		}

	}
}