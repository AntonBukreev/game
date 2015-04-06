/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 10.12.14
 * Time: 16:53
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell
{
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.event.GameEvent;

import components.ANIM_CONCRETE;

import components.ANIM_GROUND;

import components.CELL_CONCRETE;
import components.CELL_CONCRETE_BROKEN;
import components.CELL_EMERALDS;

import flash.display.MovieClip;

public class CellConcrete extends Cell
{
    public static const TYPE:int = 70;
    private var view:MovieClip;
    public function CellConcrete(line:int, column:int)
    {
        super(line, column, TYPE);
        strength = 2;
    }

    override public function open():void
    {
        if (!isOpen)
        {
            view = new CELL_CONCRETE();
            randomFrame(view);
            addChild(view);
        }
        super.open();
    }

    override public function onClick():void
    {
        decrement();

        if (strength<2)
        {
            var view1:MovieClip = new CELL_CONCRETE_BROKEN();
            view1.gotoAndStop(view.currentFrame);
            addChild(view1);
        }

        if (strength <= 0)
        {
            new AnimDestroy(this, ANIM_CONCRETE);
            dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT, type));
        }
        checkRemove();
    }
}
}
