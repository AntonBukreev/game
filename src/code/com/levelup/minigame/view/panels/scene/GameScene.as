/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 24.11.14
 * Time: 16:41
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene
{
import com.greensock.TweenLite;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.common.managers.sound.events.SoundEvent;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.view.panels.popups.Btn.BtnSwitch;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostFactory;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostView;
import com.levelup.minigame.view.panels.scene.GameScene.Mission;
import com.levelup.minigame.view.panels.scene.LobbyScene.CollectionsPanel;

import flash.display.DisplayObjectContainer;

import flash.display.MovieClip;

import flash.events.MouseEvent;

public class GameScene extends AbstractScene
{

    private var gameField:GameField;
    private var mission:Mission;
    private var moneyCount:int=0;
    private var depth:int=0;

    private var collection:CollectionsPanel;

    private var soundBtn:BtnSwitch;
    private var musicBtn:BtnSwitch;

    private var _mcFreeze:MovieClip;
    private var _mcDoubleDrop:MovieClip;

    public function GameScene(panelName:String, panelData:Object)
    {
        super(panelName, panelData);
    }

    override protected function initView(): void
    {
        SoundManager.instance.onGameScene();

        super.initView();
        gameField = new GameField(CommonManager.gameData.currentHits);
        gameField.x = 175;
        gameField.y = 0;
        sceneClip.addChildAt(gameField,0);
        sceneClip["mcBackPanels"].mouseEnabled = false;
        _mcDoubleDrop = sceneClip["mcBackPanels"]["mcDoubleDrop"];
        _mcDoubleDrop.visible = false;
        _mcFreeze = sceneClip["mcBackPanels"]["mcFreez"];
        _mcFreeze.visible = false;

        gameField.addEventListener(GameEvent.EVENT_STEP, onChangeStep);
        gameField.addEventListener(GameEvent.EVENT_FINISH, onFinish);
        gameField.addEventListener(GameEvent.EVENT_COLLECT, onCollect);
        gameField.addEventListener(GameEvent.EVENT_CHANGE_DEPTH, onChangeDepth);
        gameField.addEventListener(GameEvent.EVENT_COLLECT_COLLECTION, onCollecrCollection);
        gameField.addEventListener(GameEvent.EVENT_COLLECT_CHEST, onCollectChest);
        gameField.addEventListener(GameEvent.EVENT_DOUBLE_DROP, onDoubleDrop);
        gameField.addEventListener(GameEvent.EVENT_FREEZE, onFreeze);
        gameField.addEventListener(GameEvent.EVENT_CANCEL_DOUBLE_DROP, onDoubleDropCanceled);
        gameField.addEventListener(GameEvent.EVENT_UNFREEZE, onFreezeCanceled);


        mission = new Mission(sceneClip["mcMission"]);

        sceneClip["tfSteps"].text = CommonManager.gameData.currentHits;
        sceneClip["mcHummer"].gotoAndStop(CommonManager.userData.pickLevel+1);

        PanelsManager.addPanel(PanelNames.POPUP_BRIEFING, {closeCallBack:closeBriefingCallBack, missionIndex:mission.index});

        collection = new CollectionsPanel(sceneClip["mcCollections"]);

        sceneClip["btnTutorial"].addEventListener(MouseEvent.CLICK, onTutorial);
        sceneClip["btnSettings"].addEventListener(MouseEvent.CLICK, onSettings);

        soundBtn = new BtnSwitch(sceneClip["btnSound"]);
        soundBtn.addEventListener(MouseEvent.CLICK, onClickSound);
        soundBtn.selected = SoundManager.instance.soundOn;
        SoundManager.instance.addEventListener(SoundEvent.CHANGE_SOUND, onChangeSound)

        musicBtn = new BtnSwitch(sceneClip["btnMusic"]);
        musicBtn.addEventListener(MouseEvent.CLICK, onClickMusic);
        musicBtn.selected = SoundManager.instance.musicOn;
        SoundManager.instance.addEventListener(SoundEvent.CHANGE_MUSIC, onChangeMusic)
    }

    private function onChangeSound(event:SoundEvent):void
    {
       soundBtn.selected = SoundManager.instance.soundOn;
    }

    private function onChangeMusic(event:SoundEvent):void
    {
        musicBtn.selected = SoundManager.instance.musicOn;
    }

    private function onClickMusic(event:MouseEvent):void
    {
        SoundManager.instance.musicOn = !SoundManager.instance.musicOn;
    }

    private function onClickSound(event:MouseEvent):void
    {
       SoundManager.instance.soundOn = !SoundManager.instance.soundOn;
    }

    private function onFreezeCanceled(event:GameEvent):void
    {
        if(_mcFreeze.visible)
        TweenLite.to(_mcFreeze,0.5,{alpha:0, onComplete:onHideFreeze})
    }

    private function onDoubleDropCanceled(event:GameEvent):void
    {
        if(_mcDoubleDrop.visible)
        TweenLite.to(_mcDoubleDrop,0.5,{alpha:0, onComplete:onHideDoubleDrop})
    }

    private function onFreeze(event:GameEvent):void
    {
        if (!_mcFreeze.visible)
        {
            _mcFreeze.alpha = 0;
            _mcFreeze.visible = true;
            TweenLite.to(_mcFreeze,0.5,{alpha:1})
        }

    }

    private function onHideDoubleDrop():void
    {
        if (_mcDoubleDrop)
        _mcDoubleDrop.visible = false;
    }

    private function onDoubleDrop(event:GameEvent):void
    {
        if (!_mcDoubleDrop.visible)
        {
            _mcDoubleDrop.alpha = 0;
            _mcDoubleDrop.visible = true;
            TweenLite.to(_mcDoubleDrop,0.5,{alpha:1})
        }

    }

    private function onHideFreeze():void {
        if (_mcFreeze)
        _mcFreeze.visible = false;
    }

    private function onSettings(event:MouseEvent):void
    {
        gameField.pause = true;
        PanelsManager.addPanel(PanelNames.POPUP_SETTINGS,{closeHandler:onClose});
    }

    private function onTutorial(event:MouseEvent):void
    {
        gameField.pause = true;
       PanelsManager.addPanel(PanelNames.POPUP_TUTORIAL,{closeHandler:onClose});
    }

    private function onClose():void {
        gameField.pause = false;
    }

    private function onCollectChest(event:GameEvent):void
    {
        var id:String = event.data.toString();
        CommonManager.userData.userInventory.getItemById(id).count += 1;

    }

    private function onCollecrCollection(event:GameEvent):void
    {
        var id:String = event.data.toString();
        CommonManager.userData.userInventory.getItemById(id).count += 1;
        collection.showCollection(id);
    }

    private function onChangeDepth(event:GameEvent):void
    {
        depth = int(event.data);
        sceneClip["tfDepth"].text = depth;

        mission.updateDepth(depth);
    }

    private function onCollect(event:GameEvent):void
    {
        var type:int = int(event.data);
        var stepMoney:int = CommonManager.gameData.getMoneyByItem(type);
        moneyCount += gameField.isDouble?stepMoney*2:stepMoney;
        sceneClip["tfMoney"].text = moneyCount.toString();

        mission.updateCollect(type);
    }

    private function onFinish(event:GameEvent):void
    {
        checkBest();
        var lastLevel:int = CommonManager.userData.level;

        CommonManager.userData.money += moneyCount;
        CommonManager.userData.experience += CommonManager.gameData.getExperience(moneyCount, depth);
        var currentLevel:int = CommonManager.userData.level;
        if (currentLevel > lastLevel)
        {
            CommonManager.userData.prize += 1;
        }

        var winKeys:int = mission.gameOver();
        CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count += winKeys;

        PanelsManager.addPanel(PanelNames.POPUP_GAME_OVER, {keys:winKeys, money:moneyCount, depth:depth});

        CommonManager.userData.save();
    }

    private function checkBest():void
    {
        var bestMoney:int = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_MONEY).count;
        var bestDepth:int = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_DEPTH).count;

        if (bestMoney < moneyCount)
            CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_MONEY).count = moneyCount;
        if (bestDepth < depth)
            CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_DEPTH).count = depth;
    }


    private function closeBriefingCallBack(boosts:Array):void
    {
      for (var i:int=0;i < boosts.length;i++)
      {
          var vo:BoostVO = (boosts[i] as BoostVO);
          var boost:DisplayObjectContainer = BoostFactory.getGameBoost(vo.id);
          boost["mcStars"].gotoAndStop(vo.level);
          (sceneClip["mcBoost"+i] as MovieClip).addChild(boost);
      }

      gameField.setBoost(boosts);
    }

    private function onChangeStep(event:GameEvent):void
    {
        sceneClip["tfSteps"].text = event.data;
    }

    override public function destroy(): void
    {
        soundBtn.removeEventListener(MouseEvent.CLICK, onClickSound);
        SoundManager.instance.removeEventListener(SoundEvent.CHANGE_SOUND, onChangeSound);
        musicBtn.removeEventListener(MouseEvent.CLICK, onClickMusic);
        SoundManager.instance.removeEventListener(SoundEvent.CHANGE_MUSIC, onChangeMusic);

        collection.destroy();

        soundBtn.destroy();
        musicBtn.destroy();

        gameField.removeEventListener(GameEvent.EVENT_COLLECT_CHEST, onCollectChest);
        gameField.removeEventListener(GameEvent.EVENT_COLLECT_COLLECTION, onCollecrCollection);
        gameField.removeEventListener(GameEvent.EVENT_STEP, onChangeStep);
        gameField.removeEventListener(GameEvent.EVENT_FINISH, onFinish);
        gameField.removeEventListener(GameEvent.EVENT_COLLECT, onCollect);
        gameField.removeEventListener(GameEvent.EVENT_CHANGE_DEPTH, onChangeDepth);
        gameField.removeEventListener(GameEvent.EVENT_DOUBLE_DROP, onDoubleDrop);
        gameField.removeEventListener(GameEvent.EVENT_FREEZE, onFreeze);
        gameField.removeEventListener(GameEvent.EVENT_CANCEL_DOUBLE_DROP, onDoubleDropCanceled);
        gameField.removeEventListener(GameEvent.EVENT_UNFREEZE, onFreezeCanceled);

        sceneClip["btnTutorial"].removeEventListener(MouseEvent.CLICK, onTutorial);
        sceneClip["btnSettings"].removeEventListener(MouseEvent.CLICK, onSettings);

        gameField.destroy();
        _mcDoubleDrop = null;
        _mcFreeze = null;
        super.destroy();
    }
}
}
