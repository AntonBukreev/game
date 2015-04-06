/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 26.11.14
 * Time: 17:50
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostView;

import components.BOOST_VIEW;

import flash.events.MouseEvent;

public class PopupBoost extends AbstractPopup
{
    private var currentIndex:int=0;

    private var boosts:Array=[];
    private var _closeHandler:Function;

    public function PopupBoost(panelName:String, panelData:Object)
    {
        _closeHandler = panelData.closeHandler;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
        super.initView();

        view["btnLeft"].addEventListener(MouseEvent.CLICK,onLeft);
        view["btnRight"].addEventListener(MouseEvent.CLICK,onRight);

        boosts = CommonManager.userData.allBoosts;
        updateList();
    }

    private function updateList():void
    {
        CommonUtility.removeAllChildren(view["mcContainer"]);
        for (var i:int = currentIndex;i < boosts.length && i-currentIndex < 3; i++)
        {
           var boost:BoostVO = boosts[i];
           var ico:BoostView = new BoostView(boost);
            ico.y = 0;
            ico.x = (i-currentIndex)*110;
           getChildrenMovieClip("mcContainer").addChild(ico);
        }
    }

    private function onRight(event:MouseEvent):void
    {
        if (currentIndex < boosts.length-3)
        {
            currentIndex += 1;
            updateList();
        }
    }

    private function onLeft(event:MouseEvent):void
    {
          if (currentIndex>0)
          {
              currentIndex -= 1;
              updateList();
          }
    }

    override public function remove():void
    {
        if (_closeHandler!=null) _closeHandler();
        super.remove();
    }


    override public function destroy():void
    {
        view["btnLeft"].removeEventListener(MouseEvent.CLICK,onLeft);
        view["btnRight"].removeEventListener(MouseEvent.CLICK,onRight)
        super.destroy();
    }
}
}
