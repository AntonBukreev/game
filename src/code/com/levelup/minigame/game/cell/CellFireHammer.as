/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 16:02
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_FIRE_HAMMER;

public class CellFireHammer extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_FIRE_HAMMER);

    public function CellFireHammer(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function onClick():void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_FIRE_HUMMER));
        super.onClick();
    }


    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_FIRE_HAMMER());
        }
        super.open();
    }
}
}
