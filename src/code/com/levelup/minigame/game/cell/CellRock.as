/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 02.12.14
 * Time: 18:39
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import components.CELL_ROCK;

import flash.display.MovieClip;

public class CellRock extends Cell
{
    public static const TYPE:int = 4;

    public function CellRock(line:int, column:int)
    {
        super(line, column, TYPE);

        //хрен разобьешь
        strength = 1000;
    }

    override public function open():void
    {
        if (!isOpen)
        {
            var view:MovieClip = new components.CELL_ROCK();
            randomFrame(view);
            addChild(view);
        }
        super.open();
    }
}
}
