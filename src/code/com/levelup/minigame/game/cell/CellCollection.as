/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 09.12.14
 * Time: 11:56
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.levelup.minigame.game.anim.AnimCollectionFly;
import com.levelup.minigame.game.anim.AnimFly;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.view.panels.scene.LobbyScene.CollectionFactory;

import components.CELL_BOX;

import flash.display.DisplayObjectContainer;

public class CellCollection extends Cell
{
    public static const TYPE:int = 2;
    private var _id:int;

    public function CellCollection(line:int, column:int, id:int)
    {
        _id = id;
        super(line, column, TYPE);
    }

    override public function open():void
    {
        if (!isOpen)
        {
            var view:DisplayObjectContainer = new CELL_BOX();
            addChild(view);
        }
        super.open();
    }

    override public function onClick():void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT_COLLECTION, _id));
        new AnimCollectionFly(this, CollectionFactory.getCollectionCell(_id))
        super.onClick();
    }
}
}
