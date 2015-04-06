/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 26.11.14
 * Time: 17:45
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.config.ConfigConsts;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;

import flash.events.MouseEvent;

public class PopupChest extends AbstractPopup
{
    private var _closeHandler:Function;

    private var btn1:BtnClip;
    private var btn2:BtnClip;
    private var btn3:BtnClip;

    public function PopupChest(panelName:String, panelData:Object)
    {
        _closeHandler = panelData.closeHandler;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
      super.initView();

        view["tfKeysCount"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count.toString();

        view["tfCount0"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_WOOD).count.toString();
        view["tfCount1"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_IRON).count.toString();
        view["tfCount2"].text = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_GOLD).count.toString();

        view["btn1"].addEventListener(MouseEvent.CLICK,onBuyWood);
        view["btn2"].addEventListener(MouseEvent.CLICK,onBuyIron);
        view["btn3"].addEventListener(MouseEvent.CLICK,onBuyGold);

        btn1 = new BtnClip(view["btn1"]);
        btn2 = new BtnClip(view["btn2"]);
        btn3 = new BtnClip(view["btn3"]);

        updateBtns();
    }

    private function updateBtns():void
    {
        var keysCount:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count;

        var wood:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_WOOD).count;
        var iron:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_IRON).count;
        var gold:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_GOLD).count;

        view["btn1"].visible = keysCount >= 1 && wood >0;
        view["btn2"].visible = keysCount >= 3 && iron >0;
        view["btn3"].visible = keysCount >= 5 && gold >0;
    }

    private function onBuyGold(event:MouseEvent):void {

        var needKeys:int = 5;
        var keysCount:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count;
        if (keysCount >= needKeys)
        {
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_GOLD).count -=1;
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count -= needKeys;
            getBoost(CommonManager.gameData.openGoldChest);
        }
    }

    private function onBuyIron(event:MouseEvent):void
    {
        var needKeys:int = 3;
        var keysCount:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count;
        if (keysCount>=needKeys)
        {
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_IRON).count -=1;
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count -= needKeys;
            getBoost(CommonManager.gameData.openIronChest);
        }
    }

    private function onBuyWood(event:MouseEvent):void {

        var needKeys:int = 1;
        var keysCount:int = CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count;
        if (keysCount>=needKeys)
        {
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_WOOD).count -=1;
            CommonManager.userData.userInventory.getItemById(InventoryConst.ID_CHEST_KEY).count -= needKeys;
            getBoost(CommonManager.gameData.openWoodChest);
        }
    }

    private function getBoost(id:String):void
    {
        var count:int = 1;
        if (id == InventoryConst.ID_MONEY)
        {
            count = CommonManager.gameData.getCoinsByChest();
        }
            CommonManager.userData.userInventory.getItemById(id).count+=count;

        if (CommonManager.gameData.isBoosts(id))
            CommonManager.userData.config.getDataById(ConfigConsts.ID_LAST_BOOST).value = id;

        CommonManager.userData.save();
        PanelsManager.addPanel(PanelNames.POPUP_OPEN_CHEST_PRIZE,{id:id, count:count});
        if (_closeHandler!=null)
        _closeHandler();

        remove();
    }

    override public function destroy():void
    {
        view["btn1"].removeEventListener(MouseEvent.CLICK,onBuyWood);
        view["btn2"].removeEventListener(MouseEvent.CLICK,onBuyIron);
        view["btn3"].removeEventListener(MouseEvent.CLICK,onBuyGold);

        btn1.destroy();
        btn2.destroy();
        btn3.destroy();
        btn1 = null;
        btn2 = null;
        btn3 = null;

        _closeHandler = null;
        super.destroy();
    }
}
}
