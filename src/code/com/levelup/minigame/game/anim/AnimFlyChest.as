/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 09.12.14
 * Time: 15:19
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim {
import com.greensock.TweenLite;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import flash.display.DisplayObjectContainer;
import flash.geom.Point;

public class AnimFlyChest {


    private var _view:DisplayObjectContainer;
    private var _parent:DisplayObjectContainer;

    public function AnimFlyChest(cell:Cell, view:DisplayObjectContainer)
    {
        _parent = GameField.container.stage;
        _view = view;
        _parent.addChild(_view);
        var p:Point = cell.localToGlobal(new Point(0,0))
        _view.x = p.x;
        _view.y = p.y;
        TweenLite.to(_view,0.5,{x:650,y:300, alpha:0, onComplete:onAnimComplete});
    }

    private function onAnimComplete():void
    {
        _parent.removeChild(_view);
        _view = null;
        _parent = null;
    }
}
}
