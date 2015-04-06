/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 28.11.14
 * Time: 11:29
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {
import com.levelup.minigame.game.cell.Cell;
import com.levelup.minigame.game.cell.CellEmpty;

import flash.geom.Point;

import flash.geom.Point;

public class MoveController
{
    public function MoveController()
    {

    }

    private static var finalPoint:Point;
    private static var currentStartPoint:Point;
    private static var firstLine:int=0;

    private static function getFirstLine(field:Array):int
    {
        if (field[0]) return 0;

        for( var i:int=0;i<field.length;i++)
        {
            if(field[i])return i;
        }
        return 0;
    }

    public static const MAX_STEPS:int = 50;


    /**
     * ищем путь
     * @param arr
     * @return
     */

    public static function step(arr:Array):Point
    {
        arr[finalPoint.y][finalPoint.x] = -1;
        if (checkFinalPoint(finalPoint.y,finalPoint.x))
        {
            return new Point(finalPoint.x,finalPoint.y);
        }

        for(var k:int = 0;k < MAX_STEPS;k++)
        {
            var isFoundEmpty:Boolean = false;
            for( var i:int=0;i<arr.length;i++)
            {
                for( var j:int=0;j<arr[i].length;j++)
                {
                    if (checkNeighbors(i,j,arr))
                    {
                        isFoundEmpty = true;
                        arr[i][j] = -1;
                        if (checkFinalPoint(i,j))
                        {
                            show(arr);
                            return new Point(j,i);
                        }
                    }
                }
            }

            if (!isFoundEmpty)
            {
                show(arr);
                return null;
            }
        }
        show(arr);
        return null;
    }

    private static function show(arr:Array):void
    {   /*
        for (var i:int=0;i<arr.length;i++)
        {
            trace(arr[i]);
        }
        */
   }


    private static function checkFinalPoint(i:int,j:int):Boolean
    {
        if ((i-1) == currentStartPoint.y && j== currentStartPoint.x) return true;
        if ((i+1) == currentStartPoint.y && j== currentStartPoint.x) return true;
        if (i == currentStartPoint.y && (j-1)== currentStartPoint.x) return true;
        if (i == currentStartPoint.y && (j+1)== currentStartPoint.x) return true;
        return false;
    }

    private static function checkNeighbors(i:int,j:int,arr:Array):Boolean
    {
        if (arr[i][j]==0)
        {
            if (i>0)
                if (arr[i-1][j]==-1) return true;
            if (i<(arr.length-1))
                if (arr[i+1][j]==-1) return true;
            if (j>0)
                if (arr[i][j-1]==-1) return true;
            if (j<(arr[i].length-1))
                if (arr[i][j+1]==-1) return true;
        }
        return false;
    }


    public static function getTrace(gnome:Gnome, cell:Cell, field:Array):Array
    {
        firstLine = getFirstLine(field);
        MoveController.finalPoint = new Point(cell.column,cell.line-firstLine);
        currentStartPoint = new Point(gnome.column,gnome.line-firstLine);

        var f:Array=[];
        for( var i:int=0;i<field.length;i++)
        {
            if(field[i])
            {
                var temp:Array = [];
                for( var j:int=0;j<field[i].length;j++)
                {
                    temp.push((field[i][j] as Cell).type);
                }
                f.push(temp);
            }
        }

        var out:Array = [];

        for(var k:int = 0;k < MAX_STEPS;k++)
        {
            var p:Point = step(clone(f))
            if (p)
            {
                //путь найден крайняя точка "р"
                out.push(new Point(p.x, p.y+firstLine));
                currentStartPoint = p;
                if (p.y == finalPoint.y && p.x == finalPoint.x)
                    return out;
            }
            else
            {
                // нет прохода при первой итерации
                return [];
            }
        }
        // по идее до этого не может дойти
        return [];
    }


    private static function clone(arr:Array):Array
    {
        var out:Array = [];
        for( var i:int=0;i<arr.length;i++)
        {
            var temp:Array = [];
            for( var j:int=0;j<arr[i].length;j++)
            {
                temp.push(arr[i][j]);
            }
            out.push(temp);
        }
        return out;
    }

    /**
     * проверяем возможность падать
     */
    public static function getFreeFall(path:Array,gnome:Gnome,cellField:Array):Array
    {
        if (path.length==1)
        {   //это ситуация когда строим лестницу и падать не надо
            if (gnome.line > path[0].y) return [];
        }
        else
        {   //это ситуация когда строим лестницу и падать не надо
            if (path[path.length-1].y < path[path.length-2].y) return [];
        }

        var out:Array = [];
        var starti:int = path[path.length-1].y;
        var j:int = path[path.length-1].x;
        for(var i:int= starti+1; i<cellField.length;i++)
        {
            if ((cellField[i][j] as Cell).type == CellEmpty.TYPE || (cellField[i][j] as Cell).isExplosion)
                out.push(new Point(j,i));
            else
                return out;
        }
        return out;
    }


}
}
