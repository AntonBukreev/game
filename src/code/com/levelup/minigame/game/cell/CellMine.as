/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 12.12.14
 * Time: 18:17
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_MINE;
import components.EXPLOSION;

import flash.utils.Timer;

public class CellMine extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_MINE);

    public function CellMine(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_MINE());
        }
        super.open();
    }

    private var freeCells:Array = [];
    override public function onClick():void
    {
        isExplosion = true;

        var field:Array = (parent as Container).cellField;

        var t:int;
        var i:int = line;
        var r:int = int(Math.random()*2.9+3);
        for (var j:int = column+r;j >= column-r;j--)
        {
            if (i>0 && i <field.length)
                if (j>=0 && j <field[i].length)
                    if (!(i==line && j==column))
                    {
                        t = Math.abs(column-j);
                        (field[i][j] as Cell).explosion(t);
                    }
        }

        j = column;
        for (i = line;i < line+r;i++)
        {
            if (i>0 && i <field.length)
                if (j>=0 && j <field[i].length)
                    if (!(i==line && j==column))
                    {
                        t = Math.abs(line-i);
                        (field[i][j] as Cell).explosion(t);
                    }
        }


        dispatchEvent(new GameEvent(GameEvent.EVENT_EXPLOSED));
        TweenLite.to(getChildAt(0),1,{alpha:0, onComplete: super.onClick})
        new AnimExplosion(this);

    }
}
}
