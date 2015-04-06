/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 10.12.14
 * Time: 13:15
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.event.GameEvent;

import components.ANIM_EMERALD;

import components.CELL_EMERALDS;
import components.CELL_EMERALDS_BROKEN;
import components.EMERALD;

import flash.display.MovieClip;

public class CellEmeralds extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_EMERALD);
    private var view:MovieClip;

    public function CellEmeralds(line:int, column:int)
    {
        super(line, column, TYPE);
        strength = 2;
    }

    override public function open():void
    {
        if (!isOpen)
        {
            view = new components.CELL_EMERALDS();
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
            var view1:MovieClip = new CELL_EMERALDS_BROKEN();
            view1.gotoAndStop(view.currentFrame);
            addChild(view1);
        }

        if (strength <= 0)
        {
            new AnimDestroy(this, ANIM_EMERALD,EMERALD);
            dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT, type));
        }

        checkRemove();
    }


}
}
