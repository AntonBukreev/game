/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 01.12.14
 * Time: 19:46
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.event.GameEvent;

import comopnents.COAL;

import components.ANIM_COAL;

import components.CELL_COAL;

import components.GOLD;

import flash.display.MovieClip;

public class CellCoal extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_COAL);

    public function CellCoal(line:int, column:int)
    {
        super(line, column,TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            var view:MovieClip = new components.CELL_COAL();
            randomFrame(view);
            addChild(view);
        }
        super.open();
    }

    override public function onClick():void
    {
        new AnimDestroy(this, ANIM_COAL, COAL);
        super.onClick();
    }
}
}
