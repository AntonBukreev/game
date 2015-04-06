/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.display.loaders
{
	import gui.main.PreloaderMainClip;

	public class MainLoader extends AbstractLoader
	{
		private var preloaderClip: PreloaderMainClip;

		public function MainLoader()
		{
			//pTimeMax = 1;
			//pTimeMin = 3;
			super();
		}

		override protected function init(): void
		{
			preloaderClip = new PreloaderMainClip();
			addChild(preloaderClip);
			setValue(0);
		}

		override protected function setValue(value: int): void
		{
            trace(value,"%");
            preloaderClip.tfProgress.text = value+"%";
			preloaderClip.progressBarClip.gotoAndStop(value + 1);
		}

		override public function destroy(): void
		{
			removeChild(preloaderClip);
			preloaderClip = null;
		}
	}
}