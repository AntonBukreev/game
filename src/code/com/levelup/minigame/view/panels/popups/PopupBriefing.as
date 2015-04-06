/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 08.12.14
 * Time: 11:33
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups
{
import com.facebook.graph.core.FacebookLimits;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.view.panels.popups.Btn.BtnClip;
import com.levelup.minigame.view.panels.popups.PopupBriefing.RerollBoost;
import com.levelup.minigame.view.panels.scene.GameScene.Mission;

import flash.display.MovieClip;

import flash.events.MouseEvent;

import org.osmf.media.PluginInfoResource;

public class PopupBriefing extends AbstractPopup
{

    private const BUY_REROLL:int = 5;
    private var buyIndex:int = 1;
    private var random:Array;
    private var showIndex:int;
    private var missionIndex:int;

    private var _closeCallBack:Function;
    private var _btn:BtnClip;

    public function PopupBriefing(panelName:String, panelData:Object)
    {
        missionIndex = panelData.missionIndex;
        _closeCallBack = panelData.closeCallBack;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
        super.initView();

        getChildrenSimpleButton("btnReroll").addEventListener(MouseEvent.CLICK, onReroll);

        _btn = new BtnClip(getChildrenMovieClip("btnPlay"));
        _btn.addEventListener(MouseEvent.CLICK, onPlay);
        getChildrenTextField("tfBuy").text = price.toString();

        initBoosts();

        getChildrenMovieClip("mcMissionIcon").gotoAndStop(missionIndex+1);
        getChildrenTextField("tfMissionCount").text = CommonManager.gameData.missionCount(missionIndex).toString();
    }

    private function get price():int
    {
        return buyIndex*BUY_REROLL;
    }

    private function initBoosts():void
    {
        random = sortRandom(CommonManager.userData.boosts);
        showIndex = 3;

        for(var i:int = 0;i<showIndex;i++)
        {
            var item:RerollBoost = new RerollBoost(random[i]);
            item.x = i * 111;
            item.y = 0;
            getChildrenMovieClip("mcContainer").addChild(item);
        }
    }

    private function sortRandom(arr:Array):Array
    {
        var out:Array = [];
        for each(var item:Object in arr)
        {
            var index:int = getFreeRandomPosition(out, arr.length-1);
            out[index] = item;
        }
        return out;
    }

    private function getFreeRandomPosition(out:Array,max:int):int
    {
        do
        {
           var index:int = Math.round(Math.random()*max);
        } while(out[index]!=null)
        return index;
    }

    private function onPlay(event:MouseEvent):void
    {

      remove();
    }

    private function onReroll(event:MouseEvent):void
    {
       if (price <= CommonManager.userData.money && !allLocked)
       {
           CommonManager.userData.money -= price;
           buyIndex +=1;
           getChildrenTextField("tfBuy").text = price.toString();
           changeBoosts();
           CommonManager.userData.save();
       }
    }

    private function changeBoosts():void
    {
        var container:MovieClip = getChildrenMovieClip("mcContainer");
        for (var i:int=0; i < container.numChildren; i++)
        {
            if (container.getChildAt(i) is RerollBoost)
            {
                var item:RerollBoost = container.getChildAt(i) as RerollBoost;
                if (!item.lock)
                {
                    var newItem:RerollBoost = new RerollBoost(random[freeRandomIndex]);
                    newItem.x = item.x;
                    newItem.y = item.y;
                    getChildrenMovieClip("mcContainer").addChild(newItem);
                    getChildrenMovieClip("mcContainer").removeChild(item);
                    addIndex();
                }
            }
        }
    }

    private function addIndex():void
    {
        showIndex+=1;
        if (showIndex >= random.length)
            showIndex = 0;
    }

    private function get freeRandomIndex():int
    {
        var container:MovieClip = getChildrenMovieClip("mcContainer");
        for (var i:int=0; i < container.numChildren; i++)
        {
            if (container.getChildAt(i) is RerollBoost)
            {
                var item:RerollBoost = container.getChildAt(i) as RerollBoost;
                if ( item.boost.id == (random[showIndex] as BoostVO).id )
                {
                    addIndex();
                    return freeRandomIndex;
                }
            }
        }
            return showIndex;
    }

    private function get allLocked():Boolean
    {
        var container:MovieClip = getChildrenMovieClip("mcContainer");
        for (var i:int=0; i < container.numChildren; i++)
        {
            if (container.getChildAt(i) is RerollBoost)
            {
                var item:RerollBoost = container.getChildAt(i) as RerollBoost;
                if (!item.lock) return false;
            }
        }
        return true;
    }

    override public function remove():void
    {
        var selectedBoosts:Array=[];

        var container:MovieClip = getChildrenMovieClip("mcContainer");
        for (var i:int=0; i < container.numChildren; i++)
        {
            if (container.getChildAt(i) is RerollBoost)
            {
                var item:RerollBoost = container.getChildAt(i) as RerollBoost;
                selectedBoosts.push(item.boost);
            }
        }

        var mission:String = "0";

        _closeCallBack(selectedBoosts);
        super.remove();
    }

    override public function destroy():void
    {
        getChildrenSimpleButton("btnReroll").removeEventListener(MouseEvent.CLICK, onReroll);
        _btn.removeEventListener(MouseEvent.CLICK, onPlay);
        _btn.destroy();
        super.destroy();
    }

}
}
