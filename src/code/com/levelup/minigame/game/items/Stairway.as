/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 01.12.14
 * Time: 18:37
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.items {
import components.STAIRWAY;

import flash.display.MovieClip;

public class Stairway extends STAIRWAY
{
    public function Stairway()
    {
        super();

        mouseChildren = false;
        mouseEnabled = false;

        randomFrame(this);
    }

    protected function randomFrame(mc:MovieClip):void
    {
        var count:int = mc.totalFrames;
        var frame:int = Math.floor(Math.random()*(count-0.1))+1;
        mc.gotoAndStop(frame);
    }
}
}
