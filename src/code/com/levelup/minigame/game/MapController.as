/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 02.12.14
 * Time: 16:22
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game {
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.map.MapManager;
import com.levelup.minigame.common.managers.map.MapVO;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.vo.BoostVO;

public class MapController
{
    public function MapController()
    {
    }

    private static var field:Array;
    private static var _boosts:Array=[];

    public static function initNewMap(boosts:Array):void
    {
        _boosts = boosts;
        field = [[1,1,1,1,1,1,1,1,1]];
        var levels:Array = MapManager.instance.generateMap;
        for each (var map:MapVO in levels)
        {
            field = field.concat(getField(map))
        }

    }

    private static function getField(map:MapVO):Array
    {
        var out:Array=[];
        for(var i:int=0; i < map.field.length; i++)
        {
            var temp:Array=[];
            for(var j:int =0; j < map.field[i].length; j++)
            {
                var value:int = int(map.field[i][j]);
                if (value==100) value = getRandom(map);
                temp.push(value);
            }
            out.push(temp);
        }
        return out;
    }

    private static function getRandom(map:MapVO):int
    {
        var chances:Array = [];
        for (var i:int = 0; i < map.chances.length; i++)
        {
            var b:int = bonus(i);
            if (!CommonManager.gameData.isBoosts(i.toString()) || b > 0)
                chances[i] = int(map.chances[i]) + b;
            else
                chances[i] = 0;
        }


        var randomIndex:int = CommonUtility.getRandomByChanceArr(chances);
        return randomIndex;
    }

    private static function bonus(i:int):int
    {
        for each( var boost:BoostVO in _boosts)
        {
            if(int(boost.id) == i)
                return 25+25*boost.level;
        }
        return 0;
    }


    //----------------------------------------------------
    //----------------------------------------------------
    //----------------------------------------------------
    public static function getType(line:int,column:int):int
    {
        var index:int = line-1;
        if (index >= field.length)
        {
            index = line-1 - field.length*int((line-1) / field.length);
        }
        return field[index][column];
    }


}
}
