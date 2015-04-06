/**
 * ...
 * @author Morozov V.
 */
package com.levelup.minigame.view.display.loaders
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.levelup.minigame.api.view.ILoader;
	import com.levelup.minigame.api.view.ILoaderRespondent;

	import flash.display.Sprite;
	import flash.events.Event;

	public class AbstractLoader extends Sprite implements ILoader
	{
		protected var pTimeMin: Number = 0.5;
		protected var pTimeMax: Number = 1.5;
		protected var pTimeFinish: Number = 1.5;

		private var _percent: int;
		private var _displayPercent: int;
		private var respondents: Vector.<ILoaderRespondent>;

		public function AbstractLoader()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}

		private function onAddToStageHandler(event: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			init();
		}

		protected function init(): void
		{
		}

		public function addRespondent(value: ILoaderRespondent): void
		{
			respondents = !respondents ? new Vector.<ILoaderRespondent> : respondents;

			if (!value.hasEventListener(LoaderEvent.PROGRESS))
			{
				value.addEventListener(LoaderEvent.PROGRESS, responseHandler);
			}

			for each (var resp: ILoaderRespondent in respondents)
			{
				if (resp == value)
				{
					return;
				}
			}

			respondents.push(value);
		}

		private function responseHandler(event: Event): void
		{
			var newPercent: int = 0;
			var responder: ILoaderRespondent;
			var n: int = (respondents) ? respondents.length : 0;
			for (var i: int = 0; i < n; i++)
			{
				responder = respondents[i];
				if (responder) newPercent += responder.percent;
			}

			updatePercent(newPercent);
		}

		public function updatePercent(value: int): void
		{
			if (value < displayPercent) value = displayPercent;
			if (value > 100) value = 100;
			_percent = value;

			var nTime: Number = value < 90 ? pTimeMax : pTimeMin;
			TweenLite.killTweensOf(this);
			TweenLite.to(this, nTime, {displayPercent: value, onComplete: checkComplete});
		}

		protected function onLoadingComplete(): void
		{
			dispatchEvent(new Event(LoaderEvent.COMPLETE));
		}

		public function checkComplete(): void
		{
			if (displayPercent >= 100) TweenLite.delayedCall(pTimeFinish, onLoadingComplete);
		}

		public function set displayPercent(value: int): void
		{
			if (value < _displayPercent) return;
			_displayPercent = value;
			setValue(value);
		}

		public function get displayPercent(): int
		{
			return _displayPercent;
		}

		public function get percent(): int { return _percent; }

		protected function setValue(value: int): void {}

		public function update(): void
		{
			responseHandler(null);
		}

		public function destroy(): void
		{
			var n: int = respondents.length;
			for (var i: int = 0; i < n; i++)
			{
				respondents[i].removeEventListener(LoaderEvent.PROGRESS, responseHandler);
			}

			respondents = null;
			TweenLite.killTweensOf(this);
		}
	}
}