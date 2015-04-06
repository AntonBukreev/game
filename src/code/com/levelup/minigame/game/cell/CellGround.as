/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 27.11.14
 * Time: 15:03
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.event.GameEvent;

import components.ANIM_GROUND;

import components.CELL_GROUND;
import components.GROUND;

import flash.display.MovieClip;

import flash.events.MouseEvent;

public class CellGround extends Cell
{
    public static const TYPE:int = 1;

    public function CellGround(line:int, column:int)
    {
        super(line, column, TYPE);
    }



    override public function open():void
    {
        if (!isOpen)
        {
            var view:MovieClip;
            if (line<=1)
                view = new components.CELL_GROUND_0();
            else
                view = new components.CELL_GROUND();
            randomFrame(view);

            addChild(view);
        }
        super.open();
    }


    override public function onClick():void
    {
        new AnimDestroy(this, ANIM_GROUND);
        super.onClick();
    }




}
}
