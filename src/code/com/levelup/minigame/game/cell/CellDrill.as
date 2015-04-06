/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 11.12.14
 * Time: 18:23
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimDestroy;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.event.GameEvent;

import components.ANIM_DRILL;

import components.CELL_DRILL;
import components.EXPLOSION;

public class CellDrill extends Cell
{

    public static const TYPE:int = int(InventoryConst.ID_BOOST_DRILL);

    public function CellDrill(line:int, column:int)
    {
        super(line, column, TYPE);

    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_DRILL());
        }
        super.open();
    }

    override public function onClick():void
    {
        isExplosion = true;

        if (parent)
        {
            new AnimDestroy(this, ANIM_DRILL);
            var field:Array = (parent as Container).cellField;

            for (var i:int = line+3;i > line;i--)
            {
                if (i>=0 && i <field.length)
                {
                    var t:int = Math.abs(line-i);
                    (field[i][column] as Cell).explosion(t,false);
                }
            }

            dispatchEvent(new GameEvent(GameEvent.EVENT_EXPLOSED));

            TweenLite.to(getChildAt(0),0.5,{alpha:0, onComplete:super.onClick})
                    //new AnimExplosion(this);

        }
    }
}
}
