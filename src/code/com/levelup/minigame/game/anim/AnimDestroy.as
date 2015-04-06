/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 25.12.14
 * Time: 12:49
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;

public class AnimDestroy
{
    private var _view:MovieClip;
    private var _parent:DisplayObjectContainer;
    private var _clsAnim2:Class;

    public function AnimDestroy(cell:Cell, clsAnim:Class, clsAnim2:Class=null)
    {
        _clsAnim2 = clsAnim2;
        _parent = GameField.container;
        _view = new clsAnim();
        _view.x = cell.x;
        _view.y = cell.y;
        _view.gotoAndStop(1);
        _parent.addChildAt(_view,_parent.numChildren-1);

        _view.play();
        _view.addEventListener("animComplete", onAnimComplete);
    }

    private function onAnimComplete(e:Event):void
    {
        _parent.removeChild(_view);
        if (_clsAnim2!=null)
        {
            animFly(_view, _clsAnim2)
        }
        else
        {
            _view = null;
            _parent= null;
        }

    }

    public function animFly(cell:DisplayObjectContainer, cls:Class):void
    {
        _parent = GameField.container;
        _view = new cls();
        _parent.addChild(_view);
        //var p:Point = cell.localToGlobal(new Point(0,0))
        _view.x = cell.x;
        _view.y = cell.y;

        var tl:TimelineLite = new TimelineLite();
        tl.append(TweenLite.to(_view,0.2,{x:_view.x+10,y:_view.y-20, scaleX:2, scaleY:2}) );
        tl.append(TweenLite.to(_view,0.5,{x:650,y:300, scaleX:0.5, scaleY:0.5, onComplete:onAnimComplete2}) );
    }

    private function onAnimComplete2():void
    {
        _parent.removeChild(_view);
        _view = null;
        _clsAnim2 = null;
    }
}
}
