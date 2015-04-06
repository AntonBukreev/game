/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 25.12.14
 * Time: 16:47
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim {
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import components.EXPLOSION;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.setTimeout;

public class AnimExplosion
{
    private var _view:MovieClip;
    private var _parent:DisplayObjectContainer;

    public function AnimExplosion(cell:Cell, delay:int=0)
    {
        _parent = GameField.container;
        _view = new EXPLOSION();
        _view.x = cell.x;
        _view.y = cell.y;
        _view["mcAnim"].gotoAndStop(1);

        if (delay >0)
        {
            _view["mcAnim"].scaleX = _view["mcAnim"].scaleY = Math.random()*0.5+0.5;
        }


        setTimeout(function():void
                {
                    _parent.addChildAt(_view,_parent.numChildren-1);
                    _view["mcAnim"].play();
                    _view.addEventListener("animComplete", onAnimComplete);
                },
                delay);
    }

    public function onAnimComplete(e:Event):void
    {
        _parent.removeChild(_view);
        _view = null;
        _parent= null;
    }
}
}
