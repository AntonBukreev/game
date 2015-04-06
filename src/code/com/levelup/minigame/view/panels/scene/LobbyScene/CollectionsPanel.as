/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 08.12.14
 * Time: 18:23
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene.LobbyScene {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.config.ConfigConsts;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;

import flash.display.DisplayObjectContainer;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

import mx.messaging.messages.CommandMessage;

public class CollectionsPanel
{
    private var _view:DisplayObjectContainer;
    private var index:int=0;
    private var btnSell:BtnClip;

    public function CollectionsPanel(view:DisplayObjectContainer)
    {
        _view = view;

        CommonUtility.removeAllChildren(_view["mcContainer"]);
        if (_view["btnLeft"])
            _view["btnLeft"].addEventListener(MouseEvent.CLICK, onLeft);
        if (_view["btnRight"])
            _view["btnRight"].addEventListener(MouseEvent.CLICK, onRight);
        if (_view["btnSell"])
        {
            _view["btnSell"].addEventListener(MouseEvent.CLICK,onSell);
            btnSell = new BtnClip(_view["btnSell"]);
        }
        update();
    }

    public function update():void
    {
        CommonUtility.removeAllChildren(_view["mcContainer"]);
        var collection:Array = InventoryConst.COLLECTIONS[index];
        var showSell:Boolean = false;
        for (var i:int = 0; i < collection.length;i++)
        {
            var id:String = collection[i];
            var item:DisplayObjectContainer = CollectionFactory.getCollection(id);

            _view["tfCount"+i].text = CommonManager.userData.userInventory.getItemById(id).count;
            if (CommonManager.userData.userInventory.getItemById(id).count==0)
            {
                item = CollectionFactory.getCollectionBack(id);
            }
            else
            {
                showSell = true;
            }
            _view["mcContainer"].addChild(item);
            item.y = i*88;
            item.x = 0;
        }
        if (_view["btnSell"])
            _view["btnSell"].visible = showSell;

        _view["mcStars"].gotoAndStop(CommonManager.gameData.getStars(index)+1);

    }

    private function onSell(event:MouseEvent):void
    {
        var prizeId:String = CommonManager.gameData.collectionPriceItem(index);
        var count:int = CommonManager.gameData.collectionPriceCount(index);
        if (count>0)
        {
            var collection:Array = InventoryConst.COLLECTIONS[index];
            for (var i:int = 0; i < collection.length;i++)
            {
                var id:String = collection[i];
                if (CommonManager.userData.userInventory.getItemById(id).count > 0)
                    CommonManager.userData.userInventory.getItemById(id).count-=1;
            }

            if (CommonManager.gameData.isBoosts(prizeId))
                CommonManager.userData.config.getDataById(ConfigConsts.ID_LAST_BOOST).value = prizeId;

            CommonManager.userData.userInventory.getItemById(prizeId).count += count;
            CommonManager.userData.save();
            update();
            PanelsManager.addPanel(PanelNames.POPUP_OPEN_CHEST_PRIZE,{id:prizeId, count:count});
            _view.dispatchEvent(new GameEvent(GameEvent.EVENT_UPDATE_VIEW,true));
        }
    }

    private function onRight(event:MouseEvent):void
    {
        index += 1;
        if (index >= InventoryConst.COLLECTIONS.length) index = 0;
        update();
    }

    private function onLeft(event:MouseEvent):void
    {
        index -= 1;
        if (index < 0) index = InventoryConst.COLLECTIONS.length-1;
        update();
    }

    public function destroy():void
    {
        if (btnSell)
            btnSell.destroy();
        if (_view["btnLeft"])
            _view["btnLeft"].removeEventListener(MouseEvent.CLICK, onLeft);
        if (_view["btnRight"])
            _view["btnRight"].removeEventListener(MouseEvent.CLICK, onRight);
        if (_view["btnSell"])
            _view["btnSell"].removeEventListener(MouseEvent.CLICK,onSell);
    }

    public function showCollection(id:String):void
    {
        index = find(id);
        update();
    }

    private function find(collectionId:String):int
    {
        for (var i:int=0; i < InventoryConst.COLLECTIONS.length; i++)
            for each(var id:String in InventoryConst.COLLECTIONS[i])
                if (id == collectionId ) return i;

        return index;
    }
}
}
