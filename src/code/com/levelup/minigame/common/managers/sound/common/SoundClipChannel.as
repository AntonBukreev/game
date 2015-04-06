package com.levelup.minigame.common.managers.sound.common
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;

	public class SoundClipChannel
	{
		private var _cSoundClip: SoundClip;
		private var _sndSound: Sound;
		private var _scChannel: SoundChannel;

		private var _nVolume: Number;
		private var _nLoopNumber: Number;
		private var _nAdjustedLoops: Number;
		private var _nPosition: Number;

		private var _cLoopTimer: Timer;

		private var _fOnLoopComplete: Function;
		private var _fOnSoundComplete: Function;

		private var _bIsPaused: Boolean;
		private var _bNonZeroStart: Boolean;

		public function SoundClipChannel(cSoundClip: SoundClip, nVolume: Number, nLoops: Number, nStartPosition: Number, fOnSoundComplete: Function, fOnLoopComplete: Function)
		{
			_cSoundClip = SoundClip(cSoundClip);
			_sndSound = _cSoundClip._sndSound;
			_nVolume = nVolume;
			_nLoopNumber = nLoops;
			_nPosition = nStartPosition;
			_fOnSoundComplete = fOnSoundComplete;
			_fOnLoopComplete = fOnLoopComplete;

			_nAdjustedLoops = 0;
			_bIsPaused = false;
			_bNonZeroStart = false;
			_scChannel = null;
			createNewChannel();
		}

		public function set volume(nValue: Number): void
		{
			if (_scChannel != null)
			{
				_scChannel.soundTransform = new SoundTransform(nValue);
			}
			_nVolume = nValue;
		}

		public function get volume(): Number
		{
			return _nVolume;
		}

		public function set onLoopComplete(fCallback: Function): void
		{
			_fOnLoopComplete = fCallback;
		}

		public function set onSoundComplete(fCallback: Function): void
		{
			_fOnSoundComplete = fCallback;
		}

		public function set loops(nValue: Number): void
		{
			if (_nLoopNumber == nValue)
			{
				return;
			}

			if (_scChannel == null)
			{
				_nLoopNumber = nValue;
			}
			else
			{
				if (_nLoopNumber == SoundDefines.INFINITE_LOOPS)
				{
					pause();
					_nLoopNumber = nValue;
					resume();
				}
				else
				{
					if (nValue == SoundDefines.DEFAULT_LOOPS)
					{
						if (_cSoundClip.getSoundType != SoundDefines.MUSIC_TYPE)
						{
							nValue = 1;
						}
						else
						{
							nValue = SoundDefines.INFINITE_LOOPS;
						}
					}
					if (nValue == SoundDefines.INFINITE_LOOPS)
					{
						_nAdjustedLoops = SoundDefines.INFINITE_LOOPS;
					}
					else
					{
						_nAdjustedLoops = nValue - _nLoopNumber;
						if (_nAdjustedLoops <= 0)
						{
							pause();
							var nNewLoops: Number = _nLoopNumber + _nAdjustedLoops;
							_nAdjustedLoops = 0;
							if (nNewLoops <= 1)
							{
								_nLoopNumber = 1;
							}
							else
							{
								_nLoopNumber = nNewLoops;
							}
							resume();
						}
					}
				}
			}
		}

		private function createNewChannel(): void
		{
			if (_scChannel != null)
			{
				_scChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
			}

			if (!_cSoundClip._bSoundLoaded)
			{
				return;
			}

			var oTransform: SoundTransform = new SoundTransform();
			oTransform.volume = _nVolume;

			if (_nPosition == SoundDefines.RANDOM_POSITION)
			{
				_nPosition = _sndSound.length * Math.random();
			}

			var nLoops: Number;
			if (_nLoopNumber == SoundDefines.DEFAULT_LOOPS)
			{
				if (_cSoundClip.getSoundType == SoundDefines.MUSIC_TYPE)
				{
					_nLoopNumber = SoundDefines.INFINITE_LOOPS;
				}
				else
				{
					_nLoopNumber = 1;
				}
			}
			if (_nLoopNumber == SoundDefines.INFINITE_LOOPS)
			{
				nLoops = int.MAX_VALUE;
			}
			else
			{
				nLoops = _nLoopNumber;
			}

			_bNonZeroStart = (_nPosition != 0);

			try
			{
				if (_bNonZeroStart)
					_scChannel = _sndSound.play(_nPosition, 1, oTransform);
				else
					_scChannel = _sndSound.play(_nPosition, nLoops, oTransform);
			} catch (error: *)
			{
				trace("play sound error");
			}

			if (_scChannel == null)
			{
				removeMe();
				return;
			}

			_cLoopTimer = new Timer(_sndSound.length - _nPosition, nLoops);
			_cLoopTimer.addEventListener(TimerEvent.TIMER, callLoopFunction);
			_cLoopTimer.start();

			_scChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);

			_bIsPaused = false;
		}

		private function callLoopFunction(oEvent: TimerEvent): void
		{
			if (_fOnLoopComplete != null)
			{
				_fOnLoopComplete();
			}
			if (_cLoopTimer != null)
			{
				if (_cLoopTimer.currentCount == _cLoopTimer.repeatCount)
				{
					deleteLoopTimer();
				}
			}
		}

		private function deleteChannel(): void
		{
			if (_scChannel != null)
			{
				_scChannel.stop();
				_scChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
				_scChannel = null;
			}
		}

		private function removeMe(): void
		{
			deleteChannel();
			_nPosition = 0;
			_cSoundClip.removeChannel(this);
		}

		private function soundComplete(oEvent: Event): void
		{
			if (_cLoopTimer != null)
			{
				if (_cLoopTimer.running)
				{
					callLoopFunction(null);
					deleteLoopTimer();
				}
			}
			if (_nAdjustedLoops != 0)
			{
				_nLoopNumber = _nAdjustedLoops;
				_nAdjustedLoops = 0;
				deleteChannel();
				createNewChannel();
				return;
			}
			if (_bNonZeroStart)
			{
				_nPosition = 0;
				if (_nLoopNumber != 1)
				{
					deleteChannel();
					if (_nLoopNumber != SoundDefines.INFINITE_LOOPS)
					{
						_nLoopNumber--;
					}
					createNewChannel();
					return;
				}
			}
			if (_fOnSoundComplete != null)
			{
				_fOnSoundComplete();
			}
			removeMe();
		}

		private function deleteLoopTimer(): void
		{
			if (_cLoopTimer != null)
			{
				_cLoopTimer.stop();
				_cLoopTimer.removeEventListener(TimerEvent.TIMER, callLoopFunction);
				_cLoopTimer = null;
			}
		}

		public function resume(bForcePlay: Boolean = true): void
		{
			if (_bIsPaused || ( bForcePlay && _scChannel == null))
			{
				_cSoundClip.addChannel(this);
				createNewChannel();
			}
		}

		public function pause(): void
		{
			if (_scChannel != null)
			{
				_bIsPaused = true;
				var nPosition: Number = _scChannel.position;
				if (_nLoopNumber != SoundDefines.INFINITE_LOOPS)
				{
					_nLoopNumber -= Math.floor(nPosition / _sndSound.length);
				}
				_nPosition = nPosition % _sndSound.length;
				deleteLoopTimer();
				deleteChannel();
			}
		}

		public function stop(): void
		{
			_bIsPaused = false;
			_nLoopNumber = SoundDefines.DEFAULT_LOOPS;
			deleteLoopTimer();
			removeMe();
		}

		/*public function get channel():SoundChannel
		 {
		 return _scChannel;
		 }*/
	}

}