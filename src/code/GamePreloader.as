/**
 * ...
 * @author Morozov V.
 */

package {
	import com.greensock.events.LoaderEvent;
	import com.levelup.minigame.api.view.ILoaderRespondent;
	import com.levelup.minigame.common.params.LoaderConstants;
	import com.levelup.minigame.view.display.loaders.MainLoader;
	import com.text.utils.WModeFix;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	import flash.utils.getDefinitionByName;

	public class GamePreloader extends MovieClip implements ILoaderRespondent
	{
		public static var mainLoader:MainLoader;
		private var loadPercent:int;

		public var main:*;

		public function GamePreloader()
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");

			init();
		}
		
		private function init (): void
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP;
			stage.quality = StageQuality.HIGH;
			stage.tabChildren = stage.showDefaultContextMenu = false;
			WModeFix.stage = this.stage;
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			loadProgressBar();
		}
		
		private function loadProgressBar():void
		{
			mainLoader = new MainLoader();

			mainLoader.addRespondent(this);
			mainLoader.addEventListener(LoaderEvent.COMPLETE, onLoadingCompleteHandler);
			addChild(mainLoader);
		}

		public function get percent():int { return loadPercent; }

		private function progress(e:ProgressEvent):void
		{
			loadPercent = (e.bytesLoaded * 100 / e.bytesTotal) * LoaderConstants.APP_MAIN;
			dispatchEvent(new Event(LoaderEvent.PROGRESS));
		}

		private function ioError(e:IOErrorEvent):void
		{
			trace(e.text);
		}

		private function checkFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}

		private function loadingFinished():void
		{
			loadPercent = LoaderConstants.APP_MAIN * 100;
			dispatchEvent(new Event(LoaderEvent.PROGRESS));

			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);

			startup();
		}

		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Game") as Class;
			main = new mainClass();
			dispatchEvent(new Event('ready', true));
			addChild(main as DisplayObject);
		}

		private function onLoadingCompleteHandler(event:Event):void
		{
			mainLoader.removeEventListener(LoaderEvent.COMPLETE, onLoadingCompleteHandler);
			mainLoader.destroy();
			removeChild(mainLoader);
			mainLoader = null;
		}
	}
}