/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 28.11.14
 * Time: 12:14
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
public class CellEmpty extends Cell
{
    public static const TYPE:int = 0;

    public function CellEmpty(line:int, column:int, isOpen:Boolean = false)
    {
        this.isOpen = isOpen;
        super(line, column,TYPE);

        graphics.beginFill(0x0,0);
        graphics.drawRect(0,0,SIZE,SIZE);
        graphics.endFill();
    }

    override public function open():void
    {
        super.open();
    }
}
}
