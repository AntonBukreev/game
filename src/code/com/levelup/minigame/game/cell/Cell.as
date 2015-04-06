/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 27.11.14
 * Time: 14:44
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import com.greensock.TweenLite;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.game.Container;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.anim.AnimExplosion;
import com.levelup.minigame.game.event.GameEvent;

import components.CELL_FOG;

import components.EXPLOSION;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

public class Cell extends Sprite
{
    public static const SIZE:int = 50;

    public var strength:int = 1;
    public var line:int;
    public var column:int;

    public var type:int=0;

    public var isExplosion:Boolean = false;
    private var _fog:MovieClip;
    private var _isOpen:Boolean = false;

    private const EXPLOSION_DELAY:int = 200;


    public function Cell(line:int,column:int,type:int)
    {
        this.type = type;
        this.line = line;
        this.column = column;

        super();
        mouseChildren = false;
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);

        x = column * SIZE;
        y = line * SIZE;

        initFog();
    }

    private function onAdded(event:Event):void
    {

    }

    public function open():void
    {
        if (!_isOpen)
        {
            _isOpen = true

            if (_fog)
            {
                addChild(_fog);
                TweenLite.to(_fog,0.5,{alpha:0, onComplete:onHideFog})
            }
        }
    }

    public function close():void
    {
        if (_fog)
        {
            _isOpen = false;
            _fog.alpha = 0;
            addChild(_fog);
            TweenLite.to(_fog,0.5,{alpha:1})
        }
    }

    private function onHideFog():void
    {
        try
        {
            removeChild(_fog);
        }
        catch(e:*)
        {
            trace("error onHideFog !!!!!!!!!!!!");
        }
    }

    public function initFog():void
    {
        if (!_isOpen)
        {
            _fog = new CELL_FOG()
            _fog.x = -3;
            _fog.y = -3;
            randomFrame(_fog);
            addChild(_fog);
        }
    }

    public function onClick():void
    {
        decrement();
        if (strength <= 0)
        {
            dispatchEvent(new GameEvent(GameEvent.EVENT_COLLECT, type));
        }
        checkRemove();
    }

    protected function decrement():void
    {
        strength -= 1;
    }

    protected function checkRemove():void
    {
        try
        {
            if (strength <=0)
            {
                (parent as Container).removeCell(this);
            }
        }
        catch(e:*)
        {
            trace("ERROR removeCell !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        }
    }

    protected function randomFrame(mc:MovieClip):void
    {
        var count:int = mc.totalFrames;
        var frame:int = Math.floor(Math.random()*(count-0.1))+1;
        mc.gotoAndStop(frame);
    }

    public function explosion(t:int, showAnim:Boolean = true):void
    {
        if(type != CellEmpty.TYPE)
        {
            if (!isExplosion)
            {
                isExplosion = true;
                open();

                strength = 0;

                var mc:* = this.getChildAt(0);
                if (!_isOpen)
                {
                    if (numChildren > 1)
                        this.getChildAt(1).alpha = 0;
                }


                if (showAnim)
                    new AnimExplosion(this,t*EXPLOSION_DELAY);

                setTimeout(
                        function ():void
                        {
                            if (type == CellGold.TYPE || type == CellIron.TYPE || type == CellCoal.TYPE || type == CellEmeralds.TYPE || type == CellConcrete.TYPE || type == CellGround.TYPE)
                                onExplosionComplete();
                            else
                                TweenLite.to(mc,0.5,{alpha:0, onComplete:onExplosionComplete});
                        },t*EXPLOSION_DELAY);
            }
        }
        else
        {
            if (showAnim)
                new AnimExplosion(this, t*EXPLOSION_DELAY);
        }
    }

    private function onExplosionComplete():void
    {
        onClick();
    }

    public function get isOpen():Boolean
    {
        return _isOpen;
    }

    public function set isOpen(value:Boolean):void {
        _isOpen = value;
    }

    protected function destroy(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        if (_fog)
        {
            TweenLite.killTweensOf(_fog);
        }

        CommonUtility.removeAllChildren(this);
        _fog = null;
    }


}
}
