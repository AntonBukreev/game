/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 22.12.14
 * Time: 22:42
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.Btn {
import com.levelup.minigame.common.managers.sound.SoundManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import sounds.SOUND_CLICK;

public class BtnClip
{
    protected  const  FRAME_OUT:int = 1;
    protected  const  FRAME_OVER:int = 2;
    protected  const  FRAME_DOWN:int = 3;

    protected var _view:MovieClip;


    public function BtnClip(view:MovieClip)
    {
        _view = view;
        _view.mouseChildren = false;
        _view.buttonMode = true;
        _view.useHandCursor = true;
        _view.addEventListener(MouseEvent.MOUSE_OVER, onOver);
        _view.addEventListener(MouseEvent.MOUSE_OUT, onOut);
        _view.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
        _view.addEventListener(MouseEvent.MOUSE_UP, onUp);

        _view.gotoAndStop(FRAME_OUT);
    }

    private function onUp(event:MouseEvent):void
    {
       _view.gotoAndStop(FRAME_OUT);
    }

    private function onDown(event:MouseEvent):void
    {
        SoundManager.instance.sound(SOUND_CLICK);
        _view.gotoAndStop(FRAME_DOWN);
    }

    private function onOut(event:MouseEvent):void
    {
        _view.gotoAndStop(FRAME_OUT);
    }

    private function onOver(event:MouseEvent):void
    {
        _view.gotoAndStop(FRAME_OVER);
    }

    public function addEventListener(type:String, handler:Function):void
    {
        _view.addEventListener(type, handler);
    }

    public function removeEventListener(type:String, handler:Function):void
    {
        _view.removeEventListener(type, handler);
    }


    public function destroy():void
    {
        _view.removeEventListener(MouseEvent.MOUSE_UP, onUp);
        _view.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
        _view.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
        _view.removeEventListener(MouseEvent.CLICK, onDown);
    }
}
}
