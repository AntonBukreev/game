/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 10.12.14
 * Time: 17:14
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_INSTRUMENTS;

public class CellInstruments extends Cell {

    public static const TYPE:int = 71;

    public function CellInstruments(line:int, column:int)
    {
        super(line, column, TYPE);
        strength = 0;
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_INSTRUMENTS());
        }
        super.open();
    }



    override public function onClick():void
    {
        super.onClick();
    }
}
}
