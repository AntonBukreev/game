/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 08.12.14
 * Time: 15:12
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.PopupBriefing {
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostFactory;

import components.BOOST_REROLL;

import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class RerollBoost extends components.BOOST_REROLL
{
    private var _boost:BoostVO;



    public function get lock():Boolean
    {
        return this.mcLock.visible;
    }

    public function  set lock(value:Boolean):void
    {
         this.mcLock.visible = value;
    }


    public function RerollBoost(boost:BoostVO)
    {
        _boost = boost;
        super();

        this.mcLock.visible = false;
        //this.mcLevel.gotoAndStop(_boost.level+1);
        var ico:DisplayObjectContainer = BoostFactory.getBoost(_boost.id)
        this.mcContainer.addChild(ico);
        ico["mcStart"].gotoAndStop(_boost.level+1);

        this.mouseChildren = false;
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
        this.addEventListener(MouseEvent.CLICK, onClick);

        mouseChildren = false;
        useHandCursor = true;
        buttonMode = true;
    }

    private function onClick(event:MouseEvent):void
    {
        lock = !lock;
    }

    private function destroy(event:Event):void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        this.removeEventListener(MouseEvent.CLICK, onClick);
    }


    public function get boost():BoostVO {
        return _boost;
    }

    public function set boost(value:BoostVO):void {
        _boost = value;
    }
}
}
