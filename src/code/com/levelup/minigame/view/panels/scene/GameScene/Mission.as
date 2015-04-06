/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 10.12.14
 * Time: 18:05
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene.GameScene {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.view.panels.scene.GameScene.MissionConsts;

import flash.display.MovieClip;

public class Mission
{
    private var _view:MovieClip;
    public var index:int;
    private var maxCount:int;
    private var currentCount:int = 0;
    public function Mission(view:MovieClip, indexMission:int=-1)
    {
        _view = view;

        if (indexMission <0)
            indexMission = MissionConsts.randomMissionIndex;
        index = indexMission;
        maxCount = CommonManager.gameData.missionCount(index);

        _view.gotoAndStop(index+1);
        _view["tfCount"].text = currentCount+"/"+maxCount;

    }

    public function updateCollect(type:int):void
    {
        if (index>0)
        if (MissionConsts.MISSIONS[index] == type)
        {
            currentCount += 1;
            _view["tfCount"].text = currentCount+"/"+maxCount;
        }
    }

    public function updateDepth(depth:int):void
    {
        if (index==0)
        {
        if (currentCount < depth)
            currentCount = depth;
        _view["tfCount"].text = currentCount+"/"+maxCount;
        }
    }


    public function gameOver():int
    {
        if (currentCount >= maxCount)
          return  CommonManager.gameData.missionComplete();

        return 0;
    }
}
}
