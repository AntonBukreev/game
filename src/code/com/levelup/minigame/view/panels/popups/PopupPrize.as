/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 04.12.14
 * Time: 17:17
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.data.user.config.ConfigConsts;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.view.panels.popups.PopupBoost.BoostFactory;

import flash.display.DisplayObjectContainer;

import flash.display.MovieClip;

import flash.utils.getDefinitionByName;

public class PopupPrize extends AbstractPopup
{
    private var _closeHandler:Function;
    public function PopupPrize(panelName:String, panelData:Object)
    {
        _closeHandler = panelData.closeHandler;
        super(panelName, panelData);

        if (CommonManager.userData.prize >0)
        {
        var boost:BoostVO = CommonManager.gameData.getBoostPrize();
            if (boost.level ==0)
                boost.level = 1;
            else
                boost.count += 1;

        CommonManager.userData.config.getDataById(ConfigConsts.ID_LAST_BOOST).value = boost.id;

        CommonManager.userData.prize-=1;
        CommonManager.userData.save();

            getChildrenMovieClip("mcContainer").gotoAndStop(1);
            var item:DisplayObjectContainer = BoostFactory.getBoost(boost.id);
            item["mcStart"].visible = false;

            getChildrenMovieClip("mcContainer")["anim0"].visible = false;
            getChildrenMovieClip("mcContainer")["anim1"].visible = false;
            getChildrenMovieClip("mcContainer")["anim2"].visible = false;
            getChildrenMovieClip("mcContainer")["anim" + boost.color].visible = true;

            getChildrenMovieClip("mcContainer")["mcContainer"].addChild(item);
        }
    }

    override protected  function expandComplete():void
    {
        super.expandComplete();
        getChildrenMovieClip("mcContainer").gotoAndPlay(1);
    }

    override public function remove():void
    {
        if (_closeHandler!=null) _closeHandler();
        super.remove();
    }

}
}
