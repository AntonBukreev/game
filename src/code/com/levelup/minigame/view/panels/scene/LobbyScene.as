/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.view.panels.scene
{
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.managers.shared.SharedObjectManager;
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.config.ConfigConsts;
import com.levelup.minigame.data.user.config.ConfigItem;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostFactory;
import com.levelup.minigame.view.panels.scene.LobbyScene.CollectionsPanel;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

public class LobbyScene extends AbstractScene
{
    private var collection:CollectionsPanel;
    private var btnChest:BtnClip;
    private var btnUpgrade:BtnClip;
    private var btnBoosts:BtnClip;
    private var btnPlay:BtnClip;

    public function LobbyScene(panelName: String, panelData: Object)
    {
        super(panelName, panelData);
    }

    override protected function initView(): void
    {
        SoundManager.instance.onLobbyScene();

        super.initView();
        sceneClip["btnPlay"].addEventListener(MouseEvent.CLICK, onClickPlay);
        sceneClip["mcOpenChest"].addEventListener(MouseEvent.CLICK, onClickChest);
        sceneClip["btnOpenBoost"].addEventListener(MouseEvent.CLICK, onClickBoost);
        sceneClip["btnDell"].addEventListener(MouseEvent.CLICK, onClickDell);
        sceneClip["mcUpgrade"].addEventListener(MouseEvent.CLICK, onBuyPick);
        sceneClip.addEventListener(GameEvent.EVENT_UPDATE_VIEW, onUpdateView);
        btnUpgrade = new BtnClip(sceneClip["mcUpgrade"]);
        btnChest = new BtnClip( sceneClip["mcOpenChest"]);
        btnBoosts = new BtnClip( sceneClip["btnOpenBoost"]);
        btnPlay = new BtnClip(sceneClip["btnPlay"]);
        updateText();

        collection = new CollectionsPanel(sceneClip["mcCollections"]);
    }

    private function onUpdateView(event:GameEvent):void {
        updateText();
    }

    private function onClickDell(event:MouseEvent):void
    {
        SharedObjectManager.clearData();
    }

    private function onBuyPick(event:MouseEvent):void
    {
        var lastLevel:int = CommonManager.userData.level;

        if (CommonManager.gameData.nextPick.price <= CommonManager.userData.money)
        {
            CommonManager.userData.money -= CommonManager.gameData.nextPick.price;
            CommonManager.userData.pickLevel += 1;
            CommonManager.userData.save();

        }

        var currentLevel:int = CommonManager.userData.level;
        if (currentLevel > lastLevel)
        {
            CommonManager.userData.prize += 1;
            CommonManager.userData.save();
        }

        updateText();
    }

    private function updateText():void
    {
        if (sceneClip)
        {
            (sceneClip["mcOpenChest"] as MovieClip).useHandCursor = true;
            (sceneClip["mcOpenChest"] as MovieClip).buttonMode = true;
            sceneClip["mcOpenChest"]["tfCount0"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_WOOD).count.toString();
            sceneClip["mcOpenChest"]["tfCount1"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_IRON).count.toString();
            sceneClip["mcOpenChest"]["tfCount2"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_GOLD).count.toString();

            sceneClip["tfMoney"].text = CommonManager.userData.money.toString();
            sceneClip["mcUpgrade"]["tfHits"].text = CommonManager.gameData.nextPick.hits;
            sceneClip["mcUpgrade"]["tfCurrentHits"].text = CommonManager.gameData.currentPick.hits;
            sceneClip["mcUpgrade"]["tfMoney"].text =CommonManager.gameData.nextPick.price;
            sceneClip["mcUpgrade"]["mcCurrentHummer"].gotoAndStop(CommonManager.userData.pickLevel+1);
            sceneClip["mcUpgrade"]["mcHummer"].gotoAndStop(CommonManager.userData.pickLevel+2);



            var currentLevel:int = CommonManager.userData.level;
            sceneClip["tfLevel"].text = currentLevel+1;
            // sceneClip["tfExp"].text = CommonManager.userData.experience;

            var expNextLevel:int = CommonManager.gameData.getLevelExp(currentLevel+1);
            var expCurrentLevel:int = CommonManager.gameData.getLevelExp(currentLevel);

            var frame:int = int(100*(CommonManager.userData.experience - expCurrentLevel)/(expNextLevel-expCurrentLevel));
            sceneClip["mcProgress"].gotoAndStop(frame);


            var prize:int = CommonManager.userData.prize;
            if (prize >0)
            {
                setTimeout(function():void
                {
                    PanelsManager.addPanel(PanelNames.POPUP_PRIZE, {closeHandler:onClosePrize});
                },1000);
            }

            updateLastBoost();
        }
    }

    private function onClosePrize():void {
        updateText();
    }

    private function updateLastBoost():void
    {
        var item:ConfigItem = CommonManager.userData.config.getDataById(ConfigConsts.ID_LAST_BOOST);
        var vo:BoostVO = CommonManager.userData.getBoostById(item.value.toString()) as BoostVO;
        var boost:DisplayObjectContainer = BoostFactory.getBoost(vo.id);
        CommonUtility.removeAllChildren(sceneClip["btnOpenBoost"]["mcContainer"]);
        sceneClip["btnOpenBoost"]["mcContainer"].addChild(boost);
        boost["mcStart"].gotoAndStop(vo.level+1);
    }

    private function onClickBoost(event:MouseEvent):void
    {
        PanelsManager.addPanel(PanelNames.POPUP_BOOST,{closeHandler:onCloseBoost});
    }

    private function onCloseBoost():void {
        updateText();
    }

    private function onClickChest(event:MouseEvent):void
    {
        PanelsManager.addPanel(PanelNames.POPUP_CHEST, {closeHandler:onCloseChest});
    }

    private function onCloseChest():void
    {
        updateText();
    }

    private function onClickPlay(event:MouseEvent):void
    {
        PanelsManager.switchCurrentScene(PanelNames.SCENE_GAME);
    }

    override public function show(): void
    {
        super.show();
        initUI();
    }


    private static function initUI(): void
    {
    }


    override public function destroy(): void
    {
        btnPlay.destroy();
        btnChest.destroy();
        btnUpgrade.destroy();
        btnBoosts.destroy();
        collection.destroy();
        sceneClip["btnOpenBoost"].removeEventListener(MouseEvent.CLICK, onClickBoost);
        sceneClip["mcOpenChest"].removeEventListener(MouseEvent.CLICK, onClickChest);
        sceneClip["btnPlay"].removeEventListener(MouseEvent.CLICK, onClickPlay);
        sceneClip["mcUpgrade"].removeEventListener(MouseEvent.CLICK, onBuyPick);
        sceneClip["btnDell"].removeEventListener(MouseEvent.CLICK, onClickDell);
        super.destroy();
    }
}
}