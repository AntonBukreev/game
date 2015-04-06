/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 16:05
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_ELECTRIC_HAMMER;

public class CellElectricHammer extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_ELECTRIC_HAMMER);

    public function CellElectricHammer(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function onClick():void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_ELECTRIC_HUMMER));
        super.onClick();
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_ELECTRIC_HAMMER());
        }
        super.open();
    }
}
}
