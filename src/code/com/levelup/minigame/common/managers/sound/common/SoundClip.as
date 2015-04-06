package com.levelup.minigame.common.managers.sound.common
{
	import br.com.stimuli.loading.BulkLoader;

	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.levelup.minigame.common.managers.assets.AssetManager;
	import com.levelup.minigame.common.managers.assets.types.IAsset;
	import com.levelup.minigame.common.managers.sound.SoundManager;
	import com.levelup.minigame.common.managers.sound.events.SoundManagerEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;

	public class SoundClip extends EventDispatcher
	{
		private var _sSoundName: String;
		internal var _sndSound: Sound;
		private var _iSoundType: int;
		private var _nVolume: Number;
		private var _bMute: Boolean;
		private var _bIsExternal: Boolean;
		private var _dctAllChannels: Dictionary;

		private var _bMultiChannel: Boolean;
		internal var _bSoundLoaded: Boolean;

		private var soundTween: TweenMax;

		public function SoundClip()
		{
			_sndSound = null;
			_dctAllChannels = new Dictionary();
			_bSoundLoaded = false;
			_bIsExternal = false;
		}

		public function attachExternalSound(sLinkageID: String, sURL: String, iSoundType: int, nVolume: Number, bMultiChannel: Boolean, sCheckLoad: String): void
		{
			_sSoundName = sLinkageID;
			_bIsExternal = true;

			_iSoundType = iSoundType;
			_bMultiChannel = bMultiChannel;

			_nVolume = nVolume / 100;
			_bMute = !SoundManager.getSoundTypeState(iSoundType);

			var cAsset: IAsset = AssetManager.createAsset(sLinkageID, sURL, (sCheckLoad == "1"), true, BulkLoader.TYPE_SOUND);
			cAsset.addEventListener(LoaderEvent.COMPLETE, onSoundLoaded);
			cAsset.addEventListener(LoaderEvent.FAIL, onSoundLoadError);
			cAsset.addEventListener(LoaderEvent.PROGRESS, assetProgressHandler);
		}

		private function assetProgressHandler(event: Event): void
		{
			dispatchEvent(new Event(LoaderEvent.PROGRESS));
		}

		private function onSoundLoadError(event: Event): void
		{
			event.target.removeEventListener(LoaderEvent.COMPLETE, onSoundLoaded);
			event.target.removeEventListener(LoaderEvent.FAIL, onSoundLoadError);
			event.target.removeEventListener(LoaderEvent.PROGRESS, assetProgressHandler);

			dispatchEvent(new SoundManagerEvent(SoundManagerEvent.SOUND_LOADED, { sSoundName: _sSoundName, bSuccess: false }));

			_sndSound = null;
		}

		private function onSoundLoaded(event: Event): void
		{
			event.target.removeEventListener(LoaderEvent.COMPLETE, onSoundLoaded);
			event.target.removeEventListener(LoaderEvent.FAIL, onSoundLoadError);
			event.target.removeEventListener(LoaderEvent.PROGRESS, assetProgressHandler);

			dispatchEvent(new SoundManagerEvent(SoundManagerEvent.SOUND_LOADED, { sSoundName: _sSoundName, bSuccess: true}));

			_sndSound = (event.target as IAsset).data as Sound;
			_bSoundLoaded = true;
			setVol(_nVolume);
			resumeSound(true);
		}

		public function setVol(nVolume: Number): void
		{
			_nVolume = nVolume;

			nVolume = calculateVolume(nVolume);
			for (var cChannel: * in _dctAllChannels)
			{
				if (soundTween)
				{
					soundTween.complete();
					soundTween = null;
				}
				cChannel.volume = nVolume;
			}
		}

		private function calculateVolume(nVolume: Number): Number
		{
			if (_bMute)
			{
				nVolume = 0;
			}
			else
			{
				nVolume = nVolume * SoundManager.getSoundTypeVolume(_iSoundType);

				if (nVolume < 0) nVolume = 0;
				if (nVolume > 1) nVolume = 1;
			}
			return nVolume;
		}

		public function playSound(vol: Number = SoundDefines.DEFAULT_VOLUME, nLoopNumber: Number = SoundDefines.DEFAULT_LOOPS, nStartPosition: Number = 0, fOnSoundComplete: Function = null, fOnLoopComplete: Function = null): SoundClipChannel
		{
			if (vol == SoundDefines.DEFAULT_VOLUME) vol = calculateVolume(_nVolume);
			else                                    vol = calculateVolume(vol);

			if (!_sndSound || vol == 0)
			{
				if (fOnSoundComplete != null) fOnSoundComplete();
				if (!_sndSound) return null;
			}

			if (!_bMultiChannel)
			{
				var cSingleChannel: SoundClipChannel = getSingleChannel();
				if (cSingleChannel != null)
				{
					if (nLoopNumber > 0 || (nLoopNumber == SoundDefines.DEFAULT_LOOPS && _iSoundType != SoundDefines.MUSIC_TYPE))
					{
						cSingleChannel.stop();
					}
					else
					{
						cSingleChannel.loops = nLoopNumber;
						cSingleChannel.volume = vol;
						cSingleChannel.onLoopComplete = fOnLoopComplete;
						cSingleChannel.onSoundComplete = fOnSoundComplete;
						fadeSound(cSingleChannel, 0, vol, 3);
						return cSingleChannel;
					}
				}
			}

			var cNewChannel: SoundClipChannel = new SoundClipChannel(this, vol, nLoopNumber, nStartPosition, fOnSoundComplete, fOnLoopComplete);
			fadeSound(cNewChannel, 0, vol, 2);
			addChannel(cNewChannel);

			return cNewChannel;
		}

		private function fadeSound(channel: SoundClipChannel, fromVol: int, toVol: int, time: int, isStop: Boolean = false): void
		{
			if (_bMute || getSoundType != SoundDefines.MUSIC_TYPE)
			{
				channel.volume = toVol;
				fadeComplete(channel, isStop);
				return;
			}

			soundTween = TweenMax.fromTo(channel, time, {volume: fromVol}, {volume: toVol, onComplete: fadeComplete, onCompleteParams: [channel, isStop]});
		}

		private function fadeComplete(value: SoundClipChannel, isStop: Boolean): void
		{
			if (isStop) value.stop();
		}

		private function getSingleChannel(): SoundClipChannel
		{
			for (var cChannel: * in _dctAllChannels)
			{
				return cChannel;
			}
			return null;
		}

		public function stopSound(): void
		{
			for (var cChannel: * in _dctAllChannels)
			{
				fadeSound(cChannel, cChannel.volume, 0, 1, true);
			}
		}

		public function removeChannel(cSoundChannel: SoundClipChannel): void
		{
			delete _dctAllChannels[cSoundChannel];
		}

		public function addChannel(cSoundChannel: SoundClipChannel): void
		{
			_dctAllChannels[cSoundChannel] = 1;
		}

		public function resumeSound(bForcePlay: Boolean = false): void
		{
			for (var cChannel: * in _dctAllChannels)
			{
				cChannel.resume(bForcePlay);
			}
		}

		public function mute(): void
		{
			_bMute = true;
			setVol(_nVolume);
		}

		public function unMute(): void
		{
			_bMute = false;
			setVol(_nVolume);
		}

		public function get getSoundType(): Number { return _iSoundType; }
	}
}