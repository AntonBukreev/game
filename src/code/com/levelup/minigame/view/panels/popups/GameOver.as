/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 01.12.14
 * Time: 19:10
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups
{
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.language.LanguageManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;

import flash.events.MouseEvent;

public class GameOver extends AbstractPopup
{

    private var _keys:int = 0;
    private var _money:int =0;
    private var _depth:int =0;

    private var btnContinue:BtnClip;
    public function GameOver(panelName:String, panelData:Object)
    {
        _keys = panelData.keys;
        _money = panelData.money;
        _depth = panelData.depth;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
        super.initView();
        getChildrenMovieClip("mcKeys").gotoAndStop(_keys>0?1:2);
        getChildrenMovieClip("mcKeys")["tfKeys"].text = _keys.toString();
        getChildrenTextField("tfMoney").text = _money.toString();
        getChildrenTextField("tfDepth").text = _depth.toString();

        getChildrenTextField("tfBestMoney").text = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_MONEY).count.toString();
        getChildrenTextField("tfBestDepth").text = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_DEPTH).count.toString();

        getChildrenMovieClip("mcResult").gotoAndStop(_keys>0?1:2);
        btnContinue = new BtnClip(getChildrenMovieClip("mcContinue"));
        getChildrenMovieClip("mcContinue").addEventListener(MouseEvent.CLICK, onClickContinue)
        LanguageManager.parse(this);
    }

    private function onClickContinue(event:MouseEvent):void {
        PanelsManager.switchCurrentScene(PanelNames.SCENE_LOBBY);
        remove();
    }



    override public function destroy():void
    {
        getChildrenMovieClip("mcContinue").removeEventListener(MouseEvent.CLICK, onClickContinue);
        btnContinue.destroy();

        super.destroy();
    }

}
}
