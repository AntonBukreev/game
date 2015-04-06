/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 19:11
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {
import com.levelup.minigame.game.cell.Cell;
import com.levelup.minigame.game.cell.CellEmpty;
import com.levelup.minigame.game.event.GameEvent;

import flash.events.EventDispatcher;

import flash.geom.Point;

public class FogController extends EventDispatcher
{
    public function FogController()
    {
    }

    private  var firstLine:int=0;
    private  var startI:int;
    private  var startJ:int;
    private  var maxView:int = 1;
    private  var steps:int = 1;

    private const NORMAL_VIEW_DISTANCE:int = 1;
    private const LAMP_VIEW_DISTANCE:int = 15;


    private function getFirstLine(field:Array):int
    {
        if (field[0]) return 0;

        for( var i:int=0;i<field.length;i++)
        {
            if(field[i])return i;
        }
        return 0;
    }


    public  function openCells(gnome:Gnome, field:Array):void
    {
        openMoveCells(gnome,field);
        updateOpenNeighbors(field);
    }

    private function openMoveCells(gnome:Gnome, field:Array):Array
    {
        var out:Array = [];
        var findFree:Boolean = false;
        startI = gnome.line;
        startJ = gnome.column;

        firstLine = getFirstLine(field);

        do
        {
            findFree = false;
            for( var i:int=firstLine;i<field.length;i++)
            {
                for( var j:int=0;j<field[i].length;j++)
                {
                    if (checkNeighbors(i,j,field))
                    {
                        (field[i][j] as Cell).open();
                        findFree = true;
                        out.push(field[i][j] as Cell);
                    }
                }
            }
        }while(findFree);
        return out;
    }

    private  function updateOpenNeighbors(field:Array):void
    {
        for( var i:int=firstLine;i<field.length;i++)
        {
            for( var j:int=0;j<field[i].length;j++)
            {
                if ((field[i][j] as Cell).isOpen && (field[i][j] as Cell).type == CellEmpty.TYPE)
                    openNeighbors(i,j,field);
            }
        }
    }

    private  function openNeighbors(i:int,j:int,arr:Array):void
    {
        for(var ii:int=-maxView;ii<=maxView;ii++)
        {
            for(var jj:int=-maxView;jj<=maxView;jj++)
            {
                if (!(ii==0 && jj==0))
                {
                    openCurrent(i+ii,j+jj,arr);
                }
            }
        }
/*
        openCurrent(i-1,j,arr);
        openCurrent(i+1,j,arr);
        openCurrent(i,j-1,arr);
        openCurrent(i,j+1,arr);
        openCurrent(i+1,j+1,arr);
        openCurrent(i-1,j-1,arr);
        openCurrent(i+1,j-1,arr);
        openCurrent(i-1,j+1,arr);
  */
    }

    private  function openCurrent(i:int,j:int,arr:Array):void
    {
        if ((i>=firstLine) && i<(arr.length) &&j>=0 && j<(arr[i].length))
        if (!(arr[i][j] as Cell).isOpen)
        {
            (arr[i][j] as Cell).open();
        }
    }
    private  function checkNeighbors(i:int,j:int,arr:Array):Boolean
    {
        if (!(arr[i][j] as Cell).isOpen)
        {
            if (i==startI && j ==startJ) return true;
            if ((arr[i][j] as Cell).type == CellEmpty.TYPE || (arr[i][j] as Cell).isExplosion)
            {
                if (checkCurrent(i-1,j,arr)) return true;
                if (checkCurrent(i+1,j,arr)) return true;
                if (checkCurrent(i,j-1,arr)) return true;
                if (checkCurrent(i,j+1,arr)) return true;
            }
        }
        return false;
    }

    private  function checkCurrent(i:int,j:int,arr:Array):Boolean
    {
        if (i==startI && j ==startJ) return true;

        if ((i>=firstLine) && i<(arr.length) &&j>=0 && j<(arr[i].length))
            if ((arr[i][j] as Cell).type == CellEmpty.TYPE || (arr[i][j] as Cell).isExplosion)
            {
                return (arr[i][j] as Cell).isOpen;
            }
        return false;
    }

    public function setMaxView():void
    {
            maxView = LAMP_VIEW_DISTANCE;
            steps = 10;
    }

    public function step(gnome:Gnome, field:Array):void
    {
        if (steps>0)
        {
            steps -= 1;
        }
        else
        {
            if (maxView > NORMAL_VIEW_DISTANCE)
            {
                dispatchEvent(new GameEvent(GameEvent.EVENT_LAMP_OFF));
                setNormalView(gnome, field);
            }
        }
    }

    private function setNormalView(gnome:Gnome, field:Array):void
    {
        maxView = NORMAL_VIEW_DISTANCE;
        var normalOpened:Array = openMoveCells(gnome, field);

        for( var i:int=firstLine;i<field.length;i++)
        {
            for( var j:int=0;j<field[i].length;j++)
            {
              var cell:Cell = field[i][j];
                cell.close();
            }
        }

    }

    private function findOpenCell(cell:Cell, arr:Array):Boolean
    {
        for each( var item:Cell in arr)
        {
            if (item.line == cell.line && item.column == cell.column)
            return true;
        }
        return false;
    }



}
}
