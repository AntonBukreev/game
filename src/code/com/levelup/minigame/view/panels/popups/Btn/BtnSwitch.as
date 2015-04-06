/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 22.12.14
 * Time: 17:56
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.Btn {
import com.levelup.minigame.common.managers.sound.SoundManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import sounds.SOUND_CLICK;

public class BtnSwitch
{

    protected  const  FRAME_ON:int = 1;
    protected  const  FRAME_OVER:int = 2;
    protected  const  FRAME_OFF:int = 3;

    protected var _view:MovieClip;
    protected var _selected:Boolean = true;

    public function BtnSwitch(view:MovieClip)
    {
        _view = view;
        _view.mouseChildren = false;
        _view.buttonMode = true;
        _view.useHandCursor = true;
        _view.addEventListener(MouseEvent.MOUSE_OVER, onOver);
        _view.addEventListener(MouseEvent.MOUSE_OUT, onOut);
        _view.addEventListener(MouseEvent.CLICK, onClick);
        update();
    }

    private function onClick(event:MouseEvent):void
    {
        SoundManager.instance.sound(SOUND_CLICK);
        _selected = !_selected;
        update();
    }

    private function onOut(event:MouseEvent):void
    {
        update();
    }

    private function onOver(event:MouseEvent):void
    {
        _view.gotoAndStop(FRAME_OVER);
    }

    private function update():void
    {
        if (_selected)
            _view.gotoAndStop(FRAME_ON);
        else
            _view.gotoAndStop(FRAME_OFF);
    }

    public function addEventListener(type:String, handler:Function):void
    {
       _view.addEventListener(type, handler);
    }

    public function removeEventListener(type:String, handler:Function):void
    {
        _view.removeEventListener(type, handler);
    }

    public function set selected(value:Boolean):void
    {
        _selected = value;
        update();
    }

    public function destroy():void
    {
        _view.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
        _view.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
        _view.removeEventListener(MouseEvent.CLICK, onClick);
    }
}
}
