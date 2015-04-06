/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 12.12.14
 * Time: 17:06
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_DYNAMITE;

import components.EXPLOSION;

public class CellDynamite extends Cell
{
    public static const TYPE:int = int(InventoryConst.ID_BOOST_DYNAMITE);

    public function CellDynamite(line:int, column:int)
    {
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            addChild(new CELL_DYNAMITE());
        }
        super.open();
    }

    override public function onClick():void
    {
        isExplosion = true;

        if (parent)
        {
        var randomI:Array = [-1,1,0,0];
        var randomJ:Array = [0,0,-1,1];
        var r:int = Math.floor(Math.random()*3.99);

        var field:Array = (parent as Container).cellField;

        //for (var i:int = line+2;i >= line-2;i--)
            //for (var j:int = column+2; j >= column-2;j--)
        var count:int = 5;
        var i:int = line;
        var j:int = column;
            do
            {

                if (i>0 && i <field.length)
                {
                    if (field[i]!=null && j>=0 && j <field[i].length)
                        if (!(i==line && j==column))
                        {
                            var t:int = Math.abs(column-j)+Math.abs(line-i);
                            (field[i][j] as Cell).explosion(t);
                        }
                }
                count -= 1;
                i += randomI[r];
                j += randomJ[r];
            }
            while(count >0)

        dispatchEvent(new GameEvent(GameEvent.EVENT_EXPLOSED));

        TweenLite.to(getChildAt(0),0.5,{alpha:0, onComplete:super.onClick})
        new AnimExplosion(this);
        }
    }
}
}
