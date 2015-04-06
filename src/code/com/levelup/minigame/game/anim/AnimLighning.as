/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 12.01.15
 * Time: 18:01
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.anim {
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;

import components.ANIM_LIGHTNING;

import flash.display.DisplayObjectContainer;

import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.setTimeout;

public class AnimLighning
{
    private var _view:MovieClip;
    private var _parent:DisplayObjectContainer;

    public function AnimLighning(cell:Cell, delay:int=0)
    {
        _parent = GameField.container;
        _view = new ANIM_LIGHTNING();
        _view.x = cell.x;
        _view.y = cell.y;
        _view.gotoAndStop(1);

        setTimeout(function():void
                {
                    _parent.addChildAt(_view,_parent.numChildren-1);
                    _view.play();
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
