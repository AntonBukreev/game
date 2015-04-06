/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 03.12.14
 * Time: 19:32
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.event.GameEvent;

import comopnents.IRON;

import components.ANIM_IRON;

import components.CELL_GOLD;
import components.CELL_IRON;
import components.CELL_IRON_BROKEN;

import components.GOLD;

import flash.display.MovieClip;

public class CellIron extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_IRON);
    private var view:MovieClip;

    public function CellIron(line:int, column:int)
    {
        super(line, column,TYPE);
        strength = 2;
    }

    override public function open():void
    {
        if (!isOpen)
        {
            view = new components.CELL_IRON();
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
            var view1:MovieClip = new CELL_IRON_BROKEN();
            view1.gotoAndStop(view.currentFrame);
            addChild(view1);
        }

        if (strength <= 0)
        {
            dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT, type));
            new AnimDestroy(this, ANIM_IRON, IRON);
        }

        checkRemove();
    }
}
}
