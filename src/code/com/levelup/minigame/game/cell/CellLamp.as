/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 12:47
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_LAMP;

public class CellLamp extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_LAMP);

    public function CellLamp(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_LAMP());
        }
        super.open();
    }

    override public function onClick():void
    {

        dispatchEvent(new GameEvent(GameEvent.EVENT_LAMP));
        super.onClick();
    }
}
}
