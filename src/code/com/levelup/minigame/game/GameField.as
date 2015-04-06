/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 27.11.14
 * Time: 11:51
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.map.MapManager;
import com.levelup.minigame.game.FogController;
import com.levelup.minigame.game.cell.Cell;
import com.levelup.minigame.game.cell.CellEmpty;
import com.levelup.minigame.game.cell.CellFactory;
import com.levelup.minigame.game.cell.CellInstruments;
import com.levelup.minigame.game.event.GameEvent;

import components.*;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.utils.setTimeout;

public class GameField extends Sprite
{
    public static const FIELD_WIDTH:int = 9;
    public static const FIELD_HEIGHT:int = 12;

    private static var _container:Container;
    private var cellField:Array = [];
    private var gnome:Gnome;

    private var _selectedCell:Cell;
    private var _isAnim:Boolean = false;
    private var _maxHits:int;
    private var fogController:FogController = new FogController();

    public function GameField(maxHits:int)
    {
        _maxHits = maxHits;

        super();

        //глобальный контейнер для всех элементов игры
        _container = new Container(cellField);
        addChild(_container);

        _container.addEventListener(GameEvent.EVENT_CLICK_CELL, onClickCell);
        _container.addEventListener(GameEvent.EVENT_CHANGE_TOP_LINE, checkFinish);
        _container.addEventListener(GameEvent.EVENT_COLLECT, onCollect);
        _container.addEventListener(GameEvent.EVENT_CELL_REMOVED, onCellRemoved);
        _container.addEventListener(GameEvent.EVENT_EXPLOSED,onExplosion);
        _container.addEventListener(GameEvent.EVENT_FREEZE,onFreeze);
        _container.addEventListener(GameEvent.EVENT_LAMP,onLamp);
        fogController.addEventListener(GameEvent.EVENT_LAMP_OFF, onLampOff);
        _container.addEventListener(GameEvent.EVENT_FIRE_HUMMER,onFireHummer);
        _container.addEventListener(GameEvent.EVENT_ELECTRIC_HUMMER,onElectricHummer);
        _container.addEventListener(GameEvent.EVENT_DOUBLE_DROP,onDouble);
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onLampOff(event:GameEvent):void
    {
        gnome.lamp = false;
    }

    private function onLamp(event:GameEvent):void
    {
        fogController.setMaxView();
        fogController.openCells(gnome,cellField);
        gnome.lamp = true;
    }

    private function onAdded(event:Event):void
    {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
    }

    private function onKeyDown(event:KeyboardEvent):void
    {
        if (event.keyCode == Keyboard.P)
        {
            _container.pause = !_container.pause;
            showField();
        }
    }


    private function showField():void
    {
        trace("---------------------------------------------");
        trace("gnome",gnome.line,gnome.column);
        trace("---------------------------------------------");
        for (var i:int=0;i<cellField.length;i++)
        {
            if (cellField[i]!=null && i == gnome.line)
            {
                trace("line",i);
                var out:Array = [];

                for (var j:int=0;j<cellField[i].length;j++)
                {
                    out.push((cellField[i][j] as Cell).type);
                }
                trace(out);
                /*
                 out = [];
                 for (var j:int=0;j<cellField[i].length;j++)
                 {
                 out.push(((cellField[i][j] as Cell).isExplosion));
                 }
                 trace(out);

                 out = [];
                 for (var j:int=0;j<cellField[i].length;j++)
                 {
                 out.push((((cellField[i][j] as Cell).isOpen)));
                 }
                 trace(out);
                 */
            }
        }
    }


    private function onFreeze(event:GameEvent):void
    {
        gnome.freezHits();
    }
    private function onDouble(event:GameEvent):void
    {
        gnome.doubleDrop();
    }

    private function onElectricHummer(event:GameEvent):void
    {
        gnome.electricHummer();
    }

    private function onFireHummer(event:GameEvent):void
    {
        gnome.fireHummer();
    }

    public function get isDouble():Boolean
    {
        return gnome.isDouble;
    }



    /**
     * инициализация персонажа
     */
    private function initGnome(maxHits:int):void
    {
        gnome = new Gnome(maxHits);
        _container.addChild(gnome);
    }

    /**
     * когда игрок кликает по клетке
     */
    private function onClickCell(event:GameEvent):void
    {
        if (!_isAnim)
        {
            if (!_container.isStart) _container.start();
            _selectedCell = event.data as Cell;
            trace("click",_selectedCell.line, _selectedCell.column);

            animatePath();
        }
    }

    /**
     * ищем путь анимируем движение
     */
    private function animatePath():void
    {
        var path:Array = MoveController.getTrace(gnome, _selectedCell, cellField);

        fogController.step(gnome,cellField);
        fogController.openCells(gnome,cellField);

        if (path.length>0)
        {
            _container.addChild(gnome);
            var freeFall:Array = MoveController.getFreeFall(path,gnome,cellField);
            if (_selectedCell.type == CellEmpty.TYPE)
                gnome.simpleMove(path.concat(freeFall));
            else
            {
                _isAnim = true;
                if(path.length>1)
                    gnome.difficultMove(path,onMove);
                else
                    onMove();
            }
        }
    }

    /**
     * завершение анимации движения персонажа
     */
    private function onMove():void
    {
        if (gnome.line <= _selectedCell.line)
        {
            gnome.animHit(_selectedCell);
            setTimeout(endAnim,400);
        }
        else
        {
            //вверх не бьем
            _isAnim = false;
        }
    }

    private function endAnim():void
    {
        if (gnome.hits > 0)
        {
            gnome.decrementHits();

            var selectedPoint:Point = new Point(_selectedCell.column,_selectedCell.line);

            checkFireHummer(selectedPoint);
            if (gnome.isElectricHummer || gnome.isFireHummer)
                _selectedCell.explosion(0);
            else
                _selectedCell.onClick();

            if (_selectedCell.strength < 1)
            {
                var path:Array = [selectedPoint];
                var freeFall:Array = MoveController.getFreeFall(path,gnome,cellField);
                gnome.simpleMove(path.concat(freeFall));
            }

            gnome.decrementStep();
        }
        else
        {
            //isStart = false;
            mouseChildren = false;
            mouseEnabled = false;
        }

        _isAnim = false;
    }

    private function checkFireHummer(cell:Point):void
    {
        if (gnome.isFireHummer)
        {
            if (cell.x>0)
                if (cellField[cell.y]!=null)
                    (cellField[cell.y][cell.x-1] as Cell).explosion(1);
            if (cell.x < (cellField[cell.y] as Array).length-1)
                if (cellField[cell.y]!=null)
                    (cellField[cell.y][cell.x+1] as Cell).explosion(1);
        }
    }

    private function onCellRemoved(event:GameEvent):void
    {
        var cell:Cell = (event.data as Cell);
        if (cell.column == gnome.column && cell.line > gnome.line)
        {
            var path:Array = [new Point(gnome.column,gnome.line)];
            var freeFall:Array = MoveController.getFreeFall(path,gnome,cellField);
            gnome.freeFall(freeFall);
        }

        fogController.openCells(gnome, cellField);
    }

    public function onExplosion(e:GameEvent):void
    {
        var path:Array = [new Point(gnome.column,gnome.line)];
        var freeFall:Array = MoveController.getFreeFall(path,gnome,cellField);
        gnome.freeFall(freeFall);
    }


    /**
     * условие завершения игры . когда гном уезжает наверх
     */
    private function checkFinish(event:GameEvent):void
    {
        var currentTopLine:int = int(event.data);
        if (currentTopLine - gnome.line > 1)
        {
            _container.pause = true;
            dispatchEvent(new GameEvent(GameEvent.EVENT_FINISH));
        }
    }

    private function onCollect(event:GameEvent):void
    {
        if (event.data == CellInstruments.TYPE)
        {
            gnome.hits += 4;
        }
    }

    /**
     * destroy
     */
    public function destroy():void
    {
        _container.removeEventListener(GameEvent.EVENT_LAMP,onLamp);
        _container.removeEventListener(GameEvent.EVENT_CLICK_CELL, onClickCell);
        _container.removeEventListener(GameEvent.EVENT_CHANGE_TOP_LINE, checkFinish);
        _container.removeEventListener(GameEvent.EVENT_COLLECT, onCollect);
        _container.removeEventListener(GameEvent.EVENT_CELL_REMOVED, onCellRemoved);
        _container.removeEventListener(GameEvent.EVENT_EXPLOSED,onExplosion);
        _container.removeEventListener(GameEvent.EVENT_FREEZE,onFreeze);
        _container.removeEventListener(GameEvent.EVENT_FIRE_HUMMER,onFireHummer);
        _container.removeEventListener(GameEvent.EVENT_ELECTRIC_HUMMER,onElectricHummer);
        _container.removeEventListener(GameEvent.EVENT_DOUBLE_DROP,onDouble);
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)

        _container.destroy();
        removeChild(_container);
        cellField = [];
        gnome.destroy();
    }


    public function set pause(value:Boolean):void
    {
        _container.pause = value;
    }

    public static function get container():Container {
        return _container;
    }

    public function setBoost(boosts:Array):void
    {
        _container.init(boosts);
        initGnome(_maxHits);
        fogController.openCells(gnome, cellField);
    }
}
}
