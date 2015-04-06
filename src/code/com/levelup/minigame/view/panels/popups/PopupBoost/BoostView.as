/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 05.12.14
 * Time: 16:11
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.PopupBoost {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.language.LanguageManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;


import components.BOOST_10;

import components.BOOST_11;

import components.BOOST_12;

import components.BOOST_13;

import components.BOOST_14;

import components.BOOST_15;

import components.BOOST_16;
import components.BOOST_17;
import components.BOOST_18;
import components.BOOST_19;
import components.BOOST_5;
import components.BOOST_6;
import components.BOOST_7;
import components.BOOST_8;
import components.BOOST_9;

import components.BOOST_VIEW;

import flash.display.DisplayObjectContainer;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import flash.utils.getDefinitionByName;

public class BoostView extends BOOST_VIEW
{
    private var _boost:BoostVO;
    private var _btn:BtnClip;
    public function BoostView(boost:BoostVO)
    {
        _boost = boost;
        super();

        _btn = new BtnClip(this.mcAction);
        this.mcAction.addEventListener(MouseEvent.CLICK, onUpgrade);
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);

        update();
    }

    private function update():void
    {
        CommonUtility.removeAllChildren(this.mcContainer);

        for (var i:int=0; i<=_boost.count; i++)
        {
            if(i<4)
            {
            var ico:DisplayObjectContainer = BoostFactory.getBoost(_boost.id)
            ico.x = (i+1)*3;
            ico.y = -(i+1)*3;
            ico["mcStart"].gotoAndStop(_boost.level+1);
            this.mcContainer.addChild(ico);
            }
        }
        if (_boost.level >= 5)
        {
            this.mcAction.visible = _boost.count > 0;
            this.mcAction.tfTitle.text = LanguageManager.getString("sell");
            this.mcAction.tfCount.mouseEnabled = false;
            this.mcAction.tfCount.text = CommonManager.gameData.boostSellPrice(_boost).toString();
        }
        else
        {
        this.mcAction.visible = _boost.count > 0;
        this.mcAction.tfTitle.text = LanguageManager.getString("upgrade");
        this.mcAction.tfCount.mouseEnabled = false;
        this.mcAction.tfCount.text = CommonManager.gameData.boostUpgradePrice(_boost).toString();
        }
    }

    private function destroy(event:Event):void
    {
        _btn.destroy();
        _btn = null;
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        this.mcAction.removeEventListener(MouseEvent.CLICK, onUpgrade);
    }

    private function onUpgrade(event:MouseEvent):void
    {
        var price:int;
        if (_boost.level >= 5)
        {
            price = CommonManager.gameData.boostSellPrice(_boost);
            CommonManager.userData.money += price;
            _boost.count-= 1;
            CommonManager.userData.save();
            update();
        }
        else
        {
            price = CommonManager.gameData.boostUpgradePrice(_boost);
            if (CommonManager.userData.money >= price)
            {
                CommonManager.userData.money -= price;
                _boost.level+= 1;
                _boost.count-= 1;
                CommonManager.userData.save();
                update();
            }
        }
    }
}
}
