/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 09.12.14
 * Time: 12:18
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.geom.Point;

public class AnimCollectionFly
{
    private var _view:DisplayObjectContainer;
    private var _parent:DisplayObjectContainer;

    public function AnimCollectionFly(cell:Cell, view:DisplayObjectContainer)
    {
        _parent = GameField.container.stage;
        _view = view;
        _parent.addChild(_view);
        var p:Point = cell.localToGlobal(new Point(0,0))
        _view.x = p.x;
        _view.y = p.y;

        var tl:TimelineLite = new TimelineLite();
        tl.append(TweenLite.to(_view,0.2,{x:_view.x-10,y:_view.y-10, scaleX:2, scaleY:2}) );
        tl.append(TweenLite.to(_view,0.5,{x:50,y:300, scaleX:0.5, scaleY:0.5, alpha:0, onComplete:onAnimComplete}) );

    }

    private function onAnimComplete():void
    {
        _parent.removeChild(_view);
        _view = null;
        _parent = null;
    }
}
}
