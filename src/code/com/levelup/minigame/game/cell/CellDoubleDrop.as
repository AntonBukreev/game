/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 16:06
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_DOUBLE_DROP;

public class CellDoubleDrop extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_DOUBLEDROP);

    public function CellDoubleDrop(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function onClick():void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_DOUBLE_DROP));
        super.onClick();
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_DOUBLE_DROP());
        }
        super.open();
    }
}
}
