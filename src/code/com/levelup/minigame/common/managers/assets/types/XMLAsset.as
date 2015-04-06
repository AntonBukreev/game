/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.common.managers.assets.types
{
	import br.com.stimuli.loading.loadingtypes.XMLItem;

	import com.levelup.minigame.common.managers.assets.AssetManager;

	public class XMLAsset extends Asset
	{
		public function XMLAsset(assetName: String, checkLoadFlag: Boolean, path: String = "", loadCallBack: Function = null)
		{
			super(assetName, checkLoadFlag, path, loadCallBack);

			this.priority = (checkLoadFlag ? 10000 : 1100);
		}

		override protected function init(): void
		{
			if (!pathUrl || pathUrl == "") return;

			loaderItem = AssetManager.mainLoader.add(pathUrl, { id: assetName, maxTries: 5, priority: priority}) as XMLItem;

			super.init();
		}

		override protected function finishLoading(): void
		{
			resultData = loader.getContent(assetName);
			super.finishLoading();
		}
	}
}