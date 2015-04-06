/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.panels.ui.items
{
	import com.levelup.minigame.common.managers.CommonManager;
	import com.levelup.minigame.common.managers.sound.SoundManager;
	import com.levelup.minigame.common.managers.sound.common.SoundDefines;
	import com.levelup.minigame.common.managers.sound.events.SoundManagerEvent;
	import com.levelup.minigame.data.user.userEvents.UserEvent;
	import com.levelup.minigame.view.display.controls.SettingControl;

	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;

	public class UserControls extends UserInterfaceItem
	{
		private const FULL_SCREEN_CONTROL_NAME: String = "fsControl";
		private const SOUND_CONTROL_NAME: String = "soundControl";

		private var fsControl: SettingControl;
		private var soundControl: SettingControl;

		public function UserControls(uiItemName: String, uiItemClip: MovieClip)
		{
			super(uiItemName, uiItemClip);
		}

		override protected function createControls(): void
		{
			super.createControls();
			fsControl = new SettingControl(getChildrenMovieClip(FULL_SCREEN_CONTROL_NAME));
			soundControl = new SettingControl(getChildrenMovieClip(SOUND_CONTROL_NAME), SoundDefines.SOUND_TYPE);
		}

		override public function init(): void
		{
			super.init();

			fsControl.addEventListener(SettingControl.CHANGE_STATE, changeFSHandler);

			soundControl.addEventListener(SettingControl.CHANGE_STATE, changeSoundHandler);
			SoundManager.dispatcher.addEventListener(SoundManagerEvent.SOUND_STATE_CHANGE, soundChangeHandler);

			if (!CommonManager.userData.config.isEnabled)
				CommonManager.userData.config.addEventListener(UserEvent.UPDATE_CONFIG, configUpdateHandler);
			else
				configUpdateHandler(null);
		}

        private function fullScreenRedraw(event:FullScreenEvent):void
        {
            fsControl.state = event.fullScreen;
        }

		private function configUpdateHandler(event: UserEvent): void
		{
			CommonManager.userData.config.removeEventListener(UserEvent.UPDATE_CONFIG, configUpdateHandler);
			SoundManager.setSoundState();
			setControlState();
		}

		private function setControlState(): void
		{
			soundControl.state = !SoundManager.getSoundTypeState(SoundDefines.SOUND_TYPE);
			//musicControl.state = !CommonManager.instance.soundManager.getSoundTypeState(SoundManager.MUSIC_TYPE);
		}

		override public function set show(value: Boolean): void
		{
			super.show = value;
			if (value) setControlState();
		}

		private function changeSoundHandler(event: Event): void
		{
			SoundManager.playSound("click");

			var ctrl: SettingControl = event.target as SettingControl;
			if (ctrl.state) SoundManager.turnSoundTypeOn(ctrl.type);
			else           SoundManager.turnSoundTypeOff(ctrl.type);
		}

		private function soundChangeHandler(event: SoundManagerEvent): void
		{
			setControlState();
		}

		private function changeFSHandler(event: Event): void
		{
			SoundManager.playSound("click");

            uiItemClip.stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullScreenRedraw);

			var ctrl: SettingControl = event.target as SettingControl;
            if (!ctrl.state)
            {
                uiItemClip.stage.align = "";
                uiItemClip.stage.scaleMode = StageScaleMode.NO_SCALE;
                uiItemClip.stage.displayState = StageDisplayState.FULL_SCREEN;

            }
            else
            {
                uiItemClip.stage.displayState = StageDisplayState.NORMAL;
            }
		}
	}
}