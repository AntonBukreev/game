/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 12.12.14
 * Time: 15:14
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.anim.AnimLighning;

import components.CELL_COIL;
import components.EXPLOSION;

public class CellCoil extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_COIL);

    public function CellCoil(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_COIL());
        }
        super.open();
    }

    override public function onClick():void
    {
        isExplosion = true;

        if (parent)
        {
            var field:Array = (parent as Container).cellField;


            for (var j:int = column+9; j >= column-9;j--)
            {
                if (line>=0 && line <field.length)
                    if (j>=0 && j <field[line].length)
                        if (j!=column)
                        {
                            (field[line][j] as Cell).explosion(0, false);
                        }
            }

            TweenLite.to(getChildAt(0),0.5,{alpha:1, onComplete:super.onClick})
            new AnimLighning(this);
        }

    }
}
}
