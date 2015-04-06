/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.panels.scene
{
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.PanelTypes;
	import com.levelup.minigame.view.panels.AbstractPanel;

	import flash.display.Sprite;
    import flash.utils.getDefinitionByName;

    import scenes.ViewSceneLobby;

public class AbstractScene extends AbstractPanel
	{
		public var sceneClip: Sprite;

		public function AbstractScene(panelName: String, panelData: Object)
		{
			super(panelName, panelData);
			panelType = PanelTypes.PANEL_SCENE;
		}

		override protected function initView(): void
		{
            var viewClass:Class = PanelsManager.getDefinitionByName(panelName) as Class;
            sceneClip = new viewClass() as Sprite;
			//sceneClip = AssetManager.getItemByLinkage(AssetNames.SCENES_ASSET, panelName) as Sprite;

			addChild(sceneClip);

			super.initView();
		}

		override public function destroy(): void
		{
			removeChild(sceneClip);
			sceneClip = null;
		}
	}
}