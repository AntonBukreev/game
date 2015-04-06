/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 02.12.14
 * Time: 15:54
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {

import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.GameField;
import com.levelup.minigame.game.cell.Cell;
import com.levelup.minigame.game.cell.CellEmpty;
import com.levelup.minigame.game.cell.CellFactory;
import com.levelup.minigame.game.event.GameEvent;

import components.GROUND;
import components.HEAD;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Container extends Sprite
{
    private var SPEED_PIXELS_PER_MSEOND:Number = 20/1000;
    public static const HEAD_HEIGHT:int = 300;
    //public static const GROUND_HEIGHT:int = 300;

    public var isStart:Boolean;

    private var head:HEAD;
    private var grounds:Array;

    private var lastUpdateTime:Number;

    public var cellField:Array;

    private var _currentTopLine:int=-5;

    public function Container(cellField:Array)
    {
        this.cellField = cellField;
        isStart = false;
        super();
    }

    public function init(boosts:Array):void
    {
        MapController.initNewMap(boosts);
        initGroundBack();
        initHeadBack();
        initCells();
        addEventListener(Event.ENTER_FRAME, update);
    }

    /**
     * первоначальное заполнение поля
     */
    private function initCells():void
    {
        createFirstLine();
        for (var i:int=1; i < GameField.FIELD_HEIGHT+1;i++)
        {
            generateNewLine();
        }
    }

    /**
     * первый пустой уровень где стоит гном
     */
    private function createFirstLine():void
    {
        var out:Array = [];
        for (var j:int=0; j < GameField.FIELD_WIDTH;j++)
        {
            var cell:Cell = CellFactory.getCell(CellEmpty.TYPE,0,j);
            this.addChild(cell);
            out.push(cell);
            cell.addEventListener(MouseEvent.CLICK, onClickCell);
        }
        cellField.push(out);
    }

    /**
     * инициализация фона
     */
    private function initGroundBack():void
    {
        grounds = [new GROUND(),new GROUND(),new GROUND()];

        for(var i:int=0; i <grounds.length; i++)
        {
            var ground:GROUND = grounds[i];
            this.addChild(ground);
            ground.y = i*ground.height;
        }
    }

    private function initHeadBack():void
    {
        head = new HEAD();
        head.mouseEnabled = false;
        head.y = -HEAD_HEIGHT+Cell.SIZE;
        this.y = HEAD_HEIGHT-Cell.SIZE;
        this.addChild(head);
    }

    /**
     * обновление фона
     */
    private function updateGroundBack():void
    {
        for(var i:int=0; i <grounds.length; i++)
        {
            var ground:GROUND = grounds[i];
            if (ground.y+this.y < -ground.height)
            {
                ground.y += ground.height * 3;
            }
        }
    }

    /**
     * обновление фона
     */
    private function updateHeadBack():void
    {
        if (head)
        {
            if (this.y < -Cell.SIZE)
            {
                this.removeChild(head);
                head = null;
            }
        }
    }

    /**
     * движение поля вниз, убираем то что вылезло за видимое поле
     */
    private function update(event:Event):void
    {
        if (isStart)
        {
            var now:Number = (new Date()).time;
            var delta:Number = SPEED_PIXELS_PER_MSEOND*(now - lastUpdateTime);

            if (delta >= 0.3)
            {
                this.y -= delta;
                lastUpdateTime = now;

                updateHeadBack();
                updateGroundBack();
                updateField();
            }

            checkTopLine();
        }
    }

    private function checkTopLine():void
    {
        var line:int = -this.y/Cell.SIZE;

        if (_currentTopLine != line)
        {
            _currentTopLine = line;
            dispatchEvent(new GameEvent(GameEvent.EVENT_CHANGE_TOP_LINE, line));
        }
    }

    /**
     * убираем невидимые кубики сверху. добавляем новые снизу
     */
    private function updateField():void
    {
        if (this.y  < 0)
        {
            var currentTopLine:int = Math.abs(this.y)/Cell.SIZE;
            for (var i:int=0;i<cellField.length;i++)
            {
                if (cellField[i])
                {
                    if (i < currentTopLine)
                    {
                        removeLine(i);
                        generateNewLine();
                    }
                }
            }
        }
    }

    /**
     * вот это надо будет переписать когда появятся карты
     */
    private function generateNewLine():void
    {
        var line:int = cellField.length;
        var out:Array = [];
        for (var j:int=0; j < GameField.FIELD_WIDTH;j++)
        {
            var cell:Cell = CellFactory.getCell(MapController.getType(line,j),line,j);
            this.addChild(cell);
            out.push(cell);
            cell.addEventListener(MouseEvent.CLICK, onClickCell);
        }
        cellField.push(out);
    }

    /**
     *  удаляем клетки которые вышли из поля видимости
     */
    private function removeLine(i:int):void
    {
        for(var j:int=0;j < cellField[i].length;j++)
        {
            var cell:Cell = cellField[i][j];
            this.removeChild(cell);
            cell.removeEventListener(MouseEvent.CLICK, onClickCell);
            cell = null;
        }
        cellField[i] = null;
    }

    private function onClickCell(event:MouseEvent):void
    {
        dispatchEvent(new GameEvent(GameEvent.EVENT_CLICK_CELL, event.target))
    }

    /**
     * начало движения контейнера
     */
    public function start():void
    {
        lastUpdateTime = (new Date().time);
        isStart = true;
    }

    /**
     * останавливаем все
     */
    public function set pause(value:Boolean):void
    {
        this.mouseChildren = !value;
        this.mouseEnabled = !value;
        isStart = !value;
        lastUpdateTime = (new Date().time);
    }

    public function get pause():Boolean
    {
        return !isStart;
    }

    public function destroy():void
    {

        for each (var line:Array in cellField )
        {
            if (line)
                for each (var cell:Cell in line )
                {
                    this.removeChild(cell);
                    cell.removeEventListener(MouseEvent.CLICK, onClickCell);
                    cell = null;
                }
        }

        CommonUtility.removeAllChildren(this);
        removeEventListener(Event.ENTER_FRAME, update);
    }

    /**
     * изымаем клетку из поля на ее место ставим пустую
     */
    public function removeCell(cell:Cell):void
    {
        cell.removeEventListener(MouseEvent.CLICK, onClickCell);
        this.removeChild(cell);

        var empty:CellEmpty = new CellEmpty(cell.line, cell.column,true);
        cellField[cell.line][cell.column] = empty;
        this.addChild(empty);
        empty.addEventListener(MouseEvent.CLICK, onClickCell);
        cell = null;


        dispatchEvent(new GameEvent(GameEvent.EVENT_CELL_REMOVED, empty));
    }


        public function openFog():void
        {

        }

    }
}
