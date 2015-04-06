/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 09.12.14
 * Time: 17:34
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups
{
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostFactory;
import com.levelup.minigame.view.panels.scene.LobbyScene.CollectionFactory;

import flash.display.DisplayObjectContainer;

public class PopupOpenChestPrize extends AbstractPopup
{

    private var  _id:String;
    private var  _count:int;

    public function PopupOpenChestPrize(panelName:String, panelData:Object)
    {
        _id = panelData.id;
        _count = panelData.count;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
        super.initView();

        getChildrenMovieClip("mcCollection").visible = false;
        getChildrenMovieClip("mcMoney").visible = false;
        getChildrenMovieClip("mcBoost").visible = false;

        var item:DisplayObjectContainer;

        if (CommonManager.gameData.isCollection(_id))
        {
            item = CollectionFactory.getCollection(_id);
            CommonUtility.removeAllChildren(getChildrenMovieClip("mcCollection"));
            getChildrenMovieClip("mcCollection").addChild(item);
            getChildrenMovieClip("mcCollection").visible = true;
        }
        if (CommonManager.gameData.isBoosts(_id))
        {
            item = BoostFactory.getBoost(_id);
            item["mcStart"].visible = false;
            getChildrenMovieClip("mcBoost")["anim0"].visible = false;
            getChildrenMovieClip("mcBoost")["anim1"].visible = false;
            getChildrenMovieClip("mcBoost")["anim2"].visible = false;
            getChildrenMovieClip("mcBoost")["anim" + CommonManager.gameData.getBoostColor(_id)].visible = true;
            CommonUtility.removeAllChildren(getChildrenMovieClip("mcBoost")["mcContainer"]);
            getChildrenMovieClip("mcBoost").gotoAndStop(1);
            getChildrenMovieClip("mcBoost")["mcContainer"].addChild(item);
            getChildrenMovieClip("mcBoost").visible = true;
        }
        if (_id == InventoryConst.ID_MONEY)
        {
            item = getChildrenMovieClip("mcMoney")
            item["tfCount"].text = _count;
            item.visible = true;
        }
    }

    override protected  function expandComplete():void
    {
        super.expandComplete();
        if (CommonManager.gameData.isBoosts(_id))
            getChildrenMovieClip("mcBoost").gotoAndPlay(1);
    }
}
}
