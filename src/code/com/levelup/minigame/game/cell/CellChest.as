/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 02.12.14
 * Time: 19:26
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.anim.AnimFlyChest;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.view.panels.popups.PopupChest.ChestFactory;

import flash.display.DisplayObjectContainer;

public class CellChest extends Cell
{
    public static const TYPE:int = 3;
    private var _id:int;

    public function CellChest(line:int, column:int,id:int)
    {
        _id = id;
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            var view:DisplayObjectContainer = ChestFactory.getChestCell(_id);
            addChild(view);
        }
        super.open();
    }

    override public function onClick():void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT_CHEST, _id));
        new AnimFlyChest(this, ChestFactory.getChestCell(_id));
        super.onClick();
    }
}
}
