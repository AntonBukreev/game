/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 01.12.14
 * Time: 19:44
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell
{
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.game.event.GameEvent;

import components.ANIM_GOLD;

import components.CELL_GOLD;

import components.GOLD;

import flash.display.MovieClip;

public class CellGold extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_GOLD);

    public function CellGold(line:int, column:int)
    {
        super(line, column,TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            var view:MovieClip = new components.CELL_GOLD();
            randomFrame(view);
            addChild(view);
        }
        super.open();
    }

    override public function onClick():void
    {
        new AnimDestroy(this, ANIM_GOLD, GOLD);
        super.onClick();
    }
}
}
