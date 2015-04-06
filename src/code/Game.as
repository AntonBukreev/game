/**
 * ...
 * @author Morozov V.
 */

package {
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.core.*;
import br.com.stimuli.loading.BulkLoader;

import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.levelup.minigame.api.view.ILoaderRespondent;
import com.levelup.minigame.common.managers.*;
import com.levelup.minigame.common.managers.assets.AssetManager;
import com.levelup.minigame.common.managers.assets.types.IAsset;
import com.levelup.minigame.common.managers.language.LanguageManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.*;


import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.events.UncaughtErrorEvent;
import flash.system.Capabilities;
import flash.system.System;
import flash.utils.Timer;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import sounds.SOUND_CLICK;

[SWF(width="800", height="600", frameRate="45", backgroundColor="#000000")]

public class Game extends Sprite implements ILoaderRespondent
{
    public static var APP_WIDTH:int;
    public static var APP_HEIGHT:int;

    private static const CHECK_DELAY:Number = 0.5;

    private var infoTimer:Timer = new Timer(1000);

    public function Game():void
    {
		super();
		
        XML.ignoreWhitespace = true;

        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void
    {
        infoTimer.addEventListener(TimerEvent.TIMER, onInfoTime);
        infoTimer.start();


        removeEventListener(Event.ADDED_TO_STAGE, init);
        loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, handleGlobalErrors);

        APP_WIDTH = stage.stageWidth;
        APP_HEIGHT = stage.stageHeight;

        initCommonClasses();
    }

    private function onInfoTime(event:TimerEvent):void
    {
        trace("----------------------------------");
        trace("timer",infoTimer.currentCount,"s");
        trace("totalMemory",System.totalMemory/1024,"kB");
        trace("----------------------------------");
    }

    private static function handleGlobalErrors(event:UncaughtErrorEvent):void
    {
        var txt:String = "UncaughtError! " + event.error.toString() + "\n";
        if (event.error is Error && Capabilities.isDebugger)
            txt += (event.error as Error).getStackTrace();
        if (event.error is ErrorEvent)
            txt += (event.error as ErrorEvent).text;
        //CommonManager.log(txt, Capabilities.isDebugger, LogErrorType.GLOBAL_ERROR);
    }

    private function initCommonClasses():void
    {
        PanelsManager.placeTarget = this;

        //GamePreloader.mainLoader.addRespondent(this);
        //GamePreloader.mainLoader.addEventListener(LoaderEvent.COMPLETE, onLoadingCompleteHandler, false, 0, true);

        //AssetManager.createAsset("config", FilesPath.PROJECT_CONFIG + "?" + getTimer(), true, false, BulkLoader.TYPE_XML, onConfigLoaded);
        onConfigLoaded(null);
    }

    private function onConfigLoaded(asset: IAsset):void
    {
        /*
         if (!asset.data) return;

         var xmlData:XML = XML(asset.data);

         SoundManager.initialize(xmlData.sounds);
         trace(xmlData.assets);
         */
        checkResourceLoad();
    }



    private function checkResourceLoad(cnt:int = 0):void
    {
        dispatchEvent(new Event(LoaderEvent.PROGRESS));

        TweenMax.killDelayedCallsTo(checkResourceLoad);
        var loadRes:int = AssetManager.isMustLoadAll();
        if (loadRes == 0)
        {
            //GamePreloader.mainLoader.displayPercent = 100;

            allResLoad();
            startGame();
            return;
        }
        else if (loadRes == 2 && cnt > 20)
        {
            trace("!!!!! Not Res Load!!! Wrong Res Data");

            AssetManager.startLoad();
        }

        TweenMax.delayedCall(CHECK_DELAY, checkResourceLoad, [++cnt]);
    }

    private function allResLoad():void
    {
        PanelsManager.resReady = true;
        new LanguageManager();
        createScenes();
    }

    private static function createScenes():void
    {
        PanelsManager.addPanel(PanelNames.SCENE_START, null, false);
    }

    private function onLoadingCompleteHandler(event:Event):void
    {
        startGame();
    }

    public function get percent():int
    {
        return AssetManager.allMustLoadAllPercent * LoaderConstants.APP_RESOURCE;
    }

    private function startGame():void
    {
        CommonManager.start(this);

        PanelsManager.showPanel(PanelNames.SCENE_START);

        stage.addEventListener(MouseEvent.CLICK, onClickHandler);
    }

    private static function onClickHandler(event:MouseEvent):void
    {
        if (event.target is SimpleButton)
        {
            var name:String = event.target.name;
            if (name.search("ns_") >= 0) return;
            SoundManager.instance.sound(SOUND_CLICK);
        }
    }
}
}