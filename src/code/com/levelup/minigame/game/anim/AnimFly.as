/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 02.12.14
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim
{
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import components.GOLD;

import flash.display.DisplayObjectContainer;

import flash.display.MovieClip;
import flash.geom.Point;

public class AnimFly
{
    private var _view:MovieClip;
    private var _parent:DisplayObjectContainer;

    public function AnimFly(cell:Cell, cls:Class)
    {
        _parent = GameField.container.stage;
        _view = new cls();
        _parent.addChild(_view);
        var p:Point = cell.localToGlobal(new Point(0,0))
        _view.x = p.x;
        _view.y = p.y;
        //TweenLite.to(_view,0.5,{x:650,y:300, onComplete:onAnimComplete});
        var tl:TimelineLite = new TimelineLite();
        tl.append(TweenLite.to(_view,0.2,{x:_view.x+10,y:_view.y-20, scaleX:2, scaleY:2}) );
        tl.append(TweenLite.to(_view,0.5,{x:650,y:300, scaleX:0.5, scaleY:0.5, onComplete:onAnimComplete}) );
    }

    private function onAnimComplete():void
    {
        _parent.removeChild(_view);
        _view = null;
        _parent = null;
    }
}
}
