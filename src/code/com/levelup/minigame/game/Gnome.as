/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 27.11.14
 * Time: 17:49
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Back;
import com.greensock.easing.Cubic;
import com.greensock.easing.Linear;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.game.cell.Cell;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.game.event.GameEvent;
import com.levelup.minigame.game.items.Stairway;

import components.GNOME;

import flash.display.MovieClip;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.Timer;
import flash.utils.setTimeout;

public class Gnome extends Sprite
{

    private const FRAME_STAND:int = 1;
    private const FRAME_WALK:int = 2;
    private const FRAME_HIT_DOWN:int = 3;
    private const FRAME_HIT_DOWN_LEFT:int = 4;
    private const FRAME_LOSE:int = 5;

    private const FRAME_HIT_RIGHT:int = 6;
    private const FRAME_HIT_LEFT:int = 7;

    private var _hits:int = 0;

    public var line:int;
    public var column:int;

    private var freezTimer:Timer = new Timer(1000);
    private var freezSeconds:int = 0;

    private var doubleTimer:Timer = new Timer(1000);
    private var doubleSeconds:int = 0;

    private var _fireHummerSteps:int = 0;
    private var _electricHummerSteps:int = 0;

    // 5 cells per second
    private const SPEED:Number = 10;

    private var _moveCallBack:Function;

    private var _view:GNOME = new GNOME();

    public function get hits():int
    {
        return _hits;
    }

    private var lastLine:int=-1;

    public function set hits(value:int):void
    {
        _hits = value;
        dispatchEvent(new GameEvent(GameEvent.EVENT_STEP, _hits));
    }


    public function Gnome(maxHits:int)
    {
        _hits = maxHits;
        line = 0;
        column = 4;
        super();
        _view["mcProgress"].visible = false;
        addChild(_view);
        updateFrame(FRAME_STAND);
        updateHummer();

        y = line*Cell.SIZE;
        x = column*Cell.SIZE;
        mouseChildren = false;
        mouseEnabled = false;

        freezTimer.addEventListener(TimerEvent.TIMER, onTimeFreez);
        doubleTimer.addEventListener(TimerEvent.TIMER, onTimeDouble);


    }

    private function discardExcessItems(path:Array):Array
    {
        trace(path);
        if (path.length > 2)
        {
            var temp:Array = [];

            for(var i:int= 0; i<path.length; i++)
            {
                if (i<path.length-1)
                {
                    if (!onLine(i,path))
                    {
                        temp.push(path[i]);
                    }
                }
                else
                {
                    temp.push(path[i]);
                }
            }
            return temp;
        }

        return path;
    }

    private function onLine(i:int, path:Array):Boolean
    {
        if(i==0)
            return (((line == path[i].y) && (line == path[i+1].y)) || ((column == path[i].x) && (column == path[i+1].x)));
        return (((path[i-1].x == path[i].x) && (path[i].x == path[i+1].x)) || ((path[i-1].y == path[i].y) && (path[i].y == path[i+1].y)));
    }

    /**
     * движение по пустым клеткам
     * @param path
     */

    private var isAnim:Boolean = false;
    private var tween:TimelineLite = new TimelineLite();
    private var _lamp:Boolean = false;


    public function simpleMove(path:Array, callBack:Function=null):void
    {
        if (!isAnim)
        {
            updateFrame(FRAME_WALK);
            updateHummer();
            _moveCallBack = callBack;
            tween = new TimelineLite();
            var finalPath:Array = discardExcessItems(path);

            for(var i:int = 0; i <finalPath.length; i++)
            {
                var time:Number =  getDist(i,finalPath)/SPEED;
                var obj:Object = {y:finalPath[i].y*Cell.SIZE,x:finalPath[i].x*Cell.SIZE, ease:Linear.easeNone};
                if (checkDownDirection(i,finalPath)) obj.ease = Cubic.easeIn;
                if (i==finalPath.length-1) obj.onComplete = onSimpleMoveComplete;
                tween.append(TweenLite.to(this,time,obj) );
            }

            showStairway(path);

            line = path[path.length-1].y;
            column = path[path.length-1].x;
        }
    }

    public function freeFall(path:Array):void
    {
        if (path.length >0)
        {
            if (lastLine != path[path.length-1].y)
            {
                lastLine = path[path.length-1].y;
                var time:Number =  getDist(path.length-1,path)/(SPEED/6);
                var obj:Object = {y:lastLine*Cell.SIZE,x:path[path.length-1].x*Cell.SIZE, ease:Back.easeIn};
                tween.append(TweenLite.to(this,time,obj));
                line = lastLine;
            }
        }
    }

    private function onSimpleMoveComplete():void
    {
        updateFrame(FRAME_STAND);
        updateHummer();
        dispatchEvent(new GameEvent(GameEvent.EVENT_CHANGE_DEPTH,line));
        if (_moveCallBack!=null) _moveCallBack();
    }



    private function showStairway(path:Array):void
    {
        var delay:Number=0;
        for(var j:int=0;j<path.length;j++)
        {
            checkStairway(j,path,delay);
            delay += 1/SPEED;
        }
    }

    private function checkStairway(i:int, path:Array, delay:Number):void
    {
        if (path.length==1 || i == 0)
        {
            if (line > path[0].y) addStairway(line,column,delay);
        }
        else
        {
            if (path[i].y < path[i-1].y) addStairway(path[i-1].y,path[i-1].x,delay);
        }

    }

    private function addStairway(line:int, column:int,delay:Number):void
    {

        setTimeout(function():void
        {
            var stairway:Stairway = new Stairway();
            stairway.y = line*Cell.SIZE;
            stairway.x = column*Cell.SIZE;
            parent.addChildAt(stairway,parent.numChildren-1);
        },delay*1000);
    }

    private function getDist(i:int, path:Array):Number
    {
        if (i == 0)
        {
            return Math.abs(path[0].x - column) + Math.abs(path[0].y - line);
        }
        return Math.abs(path[i].x - path[i-1].x) + Math.abs(path[i].y - path[i-1].y);
    }


    private function checkDownDirection(i:int, path:Array):Boolean
    {
        if (i == 0)
            return line < path[i].y;

        return path[i].y > path[i-1].y;
    }

    /**
     * с разрушением блока в конце
     * @param path
     * @param callBack
     */
    public function difficultMove(path:Array, callBack:Function):void
    {
        path.pop();
        simpleMove(path,callBack);
    }



    private function onTimeDouble(event:TimerEvent):void
    {
        (_view["mcProgress"]["mcBar"] as MovieClip).gotoAndStop(10-doubleSeconds);
        _view["mcProgress"].visible = doubleSeconds >0;
        if (doubleSeconds <0)
        {
            _view["mcProgress"]["mcDoubleDrop"].visible = false;
            doubleTimer.stop();
            dispatchEvent(new GameEvent(GameEvent.EVENT_CANCEL_DOUBLE_DROP));
        }
        doubleSeconds -=1;
    }

    private function onTimeFreez(event:TimerEvent):void
    {
        (_view["mcProgress"]["mcBar"] as MovieClip).gotoAndStop(10-freezSeconds);
        _view["mcProgress"].visible = freezSeconds >0;
        if (freezSeconds <0)
        {
            _view["mcProgress"]["mcFreeze"].visible = false;
            freezTimer.stop();
            dispatchEvent(new GameEvent(GameEvent.EVENT_UNFREEZE));
        }
        freezSeconds -=1;
    }

    public function freezHits():void
    {
        _view["mcProgress"]["mcFreeze"].visible = true;
        _view["mcProgress"]["mcDoubleDrop"].visible = false;
        (_view["mcProgress"]["mcBar"] as MovieClip).gotoAndStop(0);
        freezSeconds=10;
        _view["mcProgress"].visible = true;
        doubleTimer.stop();
        doubleSeconds = 0;
        dispatchEvent(new GameEvent(GameEvent.EVENT_CANCEL_DOUBLE_DROP));
        freezTimer.start();
    }

    public function decrementHits():void
    {
        if (freezSeconds <=0)
            hits -= 1;
    }

    public function doubleDrop():void
    {
        _view["mcProgress"]["mcFreeze"].visible = false;
        _view["mcProgress"]["mcDoubleDrop"].visible = true;
        (_view["mcProgress"]["mcBar"] as MovieClip).gotoAndStop(0);
        doubleSeconds =10;
        _view["mcProgress"].visible = true;
        freezTimer.stop();
        freezSeconds = 0;
        dispatchEvent(new GameEvent(GameEvent.EVENT_UNFREEZE));
        doubleTimer.start();
    }

    public function get isDouble():Boolean
    {
        return doubleSeconds>0;
    }

    public function fireHummer():void
    {
        _fireHummerSteps = 5;
        _electricHummerSteps=0;
    }

    public function electricHummer():void
    {
        _electricHummerSteps = 5;
        _fireHummerSteps = 0;
    }

    public function decrementStep():void
    {
        _fireHummerSteps -= 1;
        _electricHummerSteps -= 1;
    }

    public function get isFireHummer():Boolean
    {
        return _fireHummerSteps > 0;
    }

    public function get isElectricHummer():Boolean
    {
        return _electricHummerSteps > 0;
    }

    public function animHit(selectedCell:Cell):void
    {
        var down:Boolean = selectedCell.line > line;
        var left:Boolean = selectedCell.column < column;
        var showBang:Boolean = selectedCell.strength > 1;

        if (hits>0)
        {
            if (down)
            {
                updateFrame(FRAME_HIT_DOWN,showBang);

            }
            else
            {
                if (left)
                    updateFrame(FRAME_HIT_LEFT,showBang);
                else
                    updateFrame(FRAME_HIT_RIGHT,showBang);
            }
            updateHummer();
        }
        else
        {
            updateFrame(FRAME_LOSE);
            updateHummer();
        }
    }

    private function updateHummer():void
    {

       var hummer:MovieClip = _view["mcAnim"]["mcAnim"]["mcHummer"]["mcHummer"];

        hummer.gotoAndStop(CommonManager.userData.pickLevel+1);
        if(isElectricHummer)
            hummer.gotoAndStop(22);
        if(isFireHummer)
           hummer.gotoAndStop(21);


    }

    private function updateFrame(frame:int, bang:Boolean = false):void
    {
        _view["mcAnim"].gotoAndStop(frame);
        _view["mcAnim"]["mcAnim"].gotoAndPlay(1);
        _view["mcAnim"]["mcAnim"]["mcRedLight"].visible = _lamp;

        if (_view["mcAnim"]["mcAnim"]["mcAnimBang"])
        {
            _view["mcAnim"]["mcAnim"]["mcAnimBang"].visible = bang && !isFireHummer && !isElectricHummer;
            if (bang)
                _view["mcAnim"]["mcAnim"]["mcAnimBang"].gotoAndPlay(1);
        }
        if (_view["mcAnim"]["mcAnim"]["mcAnimFire"])
        {
            _view["mcAnim"]["mcAnim"]["mcAnimFire"].visible = isFireHummer;
            if (isFireHummer)
                _view["mcAnim"]["mcAnim"]["mcAnimFire"].gotoAndPlay(1);
        }
        if (_view["mcAnim"]["mcAnim"]["mcAnimElectric"])
        {
            _view["mcAnim"]["mcAnim"]["mcAnimElectric"].visible = isElectricHummer;
            if (isElectricHummer)
                _view["mcAnim"]["mcAnim"]["mcAnimElectric"].gotoAndPlay(1);
        }

    }


    public function destroy():void
    {
        freezTimer.removeEventListener(TimerEvent.TIMER, onTimeFreez);
        doubleTimer.removeEventListener(TimerEvent.TIMER, onTimeDouble);
    }


    public function set lamp(lamp:Boolean):void
    {
        _lamp = lamp;
    }
}
}
