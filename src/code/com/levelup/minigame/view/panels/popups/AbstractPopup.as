/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.panels.popups
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
    import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.common.params.PanelTypes;
	import com.levelup.minigame.view.panels.AbstractPanel;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

    import popups.PopupDisable;

import sounds.SOUND_CLICK;

public class AbstractPopup extends AbstractPanel
	{
		protected var position: Point;
		protected var view: Sprite;
		protected var bgClip: Sprite;
		protected var openSoundName: String;

        private var closeBtn: SimpleButton;

		public function AbstractPopup(panelName: String, panelData: Object)
		{
			panelType = PanelTypes.PANEL_POPUP;
			openSoundName = "popupOpenSnd";

			super(panelName, panelData);
		}

		override protected function init(): void
		{
			//bgClip = AssetManager.getItemByLinkage(AssetNames.POPUP_ASSET, PanelNames.POPUP_DISABLE) as Sprite;
            bgClip = new PopupDisable();
			addChildAt(bgClip, 0);

			super.init();

			closeBtn = getChildrenSimpleButton("closeBtn");
			if (closeBtn) closeBtn.addEventListener(MouseEvent.CLICK, closeClickHandler);
		}

		override protected function initView(): void
		{
			//view = AssetManager.getItemByLinkage(AssetNames.POPUP_ASSET, panelName) as Sprite;

            var viewClass:Class = PanelsManager.getDefinitionByName(panelName) as Class;
            view = new viewClass() as Sprite;
			addChild(view);

			if (!position) position = new Point(Math.round((bgClip.width - view.width) / 2), Math.round((bgClip.height - view.height) / 2));

			view.x = position.x;
			view.y = position.y;

			super.initView();
		}

		override protected function openPanel(): void
		{
			if (!view)
			{
				remove();
				return;
			}
			expandStart();
			playOpenSound();
		}

		protected function expandStart(): void
		{
			//TweenLite.to(view, 0.5, {x: position.x, y: position.y, ease: Back.easeOut, onComplete: expandComplete});
			TweenMax.fromTo(view, 0.3, {scaleX: 0.1, scaleY: 0.1,  x: bgClip.width / 2, y: bgClip.height / 2 }, {scaleX: 1, x: position.x, y: position.y, scaleY: 1, /*ease: Back.easeOut,*/ onComplete: expandComplete});
		}

		protected function expandComplete(): void
		{
			TweenLite.killTweensOf(view);
		}

		override public function remove(): void
		{
			if (data && data.hasOwnProperty("removeCallBack") && data.removeCallBack != null) data.removeCallBack();
			super.remove();
		}

		protected function closeClickHandler(event: MouseEvent): void
		{
            SoundManager.instance.sound(SOUND_CLICK);
			remove();
		}

		protected function playOpenSound(): void
		{
			//SoundManager.playSound(openSoundName);
		}

		public function getChildrenMovieClip(name: String): MovieClip
		{
			return view.getChildByName(name) as MovieClip;
		}

		public function getChildrenTextField(name: String): TextField
		{
			return view.getChildByName(name) as TextField;
		}

		public function getChildrenSimpleButton(name: String): SimpleButton
		{
			return view.getChildByName(name) as SimpleButton;
		}

		public function elementOnTop(name: String): void
		{
			view.addChild(view.getChildByName(name));
		}

		public function hardRemove(): void
		{
			super.remove();
		}

		override public function destroy(): void
		{
			if (closeBtn) closeBtn.removeEventListener(MouseEvent.CLICK, closeClickHandler);

			removeChild(view);
			view = null;

			if (bgClip)
			{
				removeChild(bgClip);
				bgClip = null;
			}

			super.destroy();
		}
	}
}