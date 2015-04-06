/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 11.12.14
 * Time: 12:47
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_BARREL;
import components.EXPLOSION;

public class CellBarrel extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_BARREL);

    public function CellBarrel(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_BARREL());
        }
        super.open();
    }

    override public function onClick():void
    {
        isExplosion = true;

        if (parent)
        {
            var field:Array = (parent as Container).cellField;
            var n:int = 1;
            for (var i:int = line+n;i >= line-n;i--)
                for (var j:int = column+n; j >= column-n;j--)
                {
                    if (i>0 && i <field.length)
                        if (field[i] && j>=0 && j <field[i].length)
                            if (!(i==line && j==column))
                            {
                                var t:int = Math.abs(column-j)+Math.abs(line-i);
                                (field[i][j] as Cell).explosion(t);
                            }
                }

            dispatchEvent(new GameEvent(GameEvent.EVENT_EXPLOSED));

            TweenLite.to(getChildAt(0),0.5,{alpha:0, onComplete:super.onClick})
            new AnimExplosion(this);
        }
    }
}
}
