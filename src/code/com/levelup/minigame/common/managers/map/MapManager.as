/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 13.01.15
 * Time: 15:07
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.common.managers.map
{
import com.levelup.minigame.common.managers.map.MapVO;
import com.levelup.minigame.common.utils.CommonUtility;

public class MapManager
{


    [Embed(source='../../../../../../../map/depth1-10_01.xml', mimeType="application/octet-stream")]
    public static const XML1:Class;
    [Embed(source='../../../../../../../map/depth1-10_02.xml', mimeType="application/octet-stream")]
    public static const XML2:Class;
    [Embed(source='../../../../../../../map/depth1-10_03.xml', mimeType="application/octet-stream")]
    public static const XML3:Class;
    [Embed(source='../../../../../../../map/depth11-25_01.xml', mimeType="application/octet-stream")]
    public static const XML4:Class;
    [Embed(source='../../../../../../../map/depth11-25_02.xml', mimeType="application/octet-stream")]
    public static const XML5:Class;
    [Embed(source='../../../../../../../map/depth11-25_03.xml', mimeType="application/octet-stream")]
    public static const XML6:Class;
    [Embed(source='../../../../../../../map/depth26-50_01.xml', mimeType="application/octet-stream")]
    public static const XML7:Class;
    [Embed(source='../../../../../../../map/depth26-50_02.xml', mimeType="application/octet-stream")]
    public static const XML8:Class;
    [Embed(source='../../../../../../../map/depth51-75_01.xml', mimeType="application/octet-stream")]
    public static const XML9:Class;
    [Embed(source='../../../../../../../map/depth51-75_02.xml', mimeType="application/octet-stream")]
    public static const XML10:Class;
    [Embed(source='../../../../../../../map/depth51-75_03s.xml', mimeType="application/octet-stream")]
    public static const XML11:Class;
    [Embed(source='../../../../../../../map/depth76_100_01.xml', mimeType="application/octet-stream")]
    public static const XML12:Class;
    [Embed(source='../../../../../../../map/depth76_100_02.xml', mimeType="application/octet-stream")]
    public static const XML13:Class;
    [Embed(source='../../../../../../../map/depth101-125_01.xml', mimeType="application/octet-stream")]
    public static const XML14:Class;
    [Embed(source='../../../../../../../map/depth101-125_02.xml', mimeType="application/octet-stream")]
    public static const XML15:Class;
    [Embed(source='../../../../../../../map/depth101-125_03s.xml', mimeType="application/octet-stream")]
    public static const XML16:Class;
    [Embed(source='../../../../../../../map/depth126-150_01.xml', mimeType="application/octet-stream")]
    public static const XML17:Class;
    [Embed(source='../../../../../../../map/depth126-150_02.xml', mimeType="application/octet-stream")]
    public static const XML18:Class;
    [Embed(source='../../../../../../../map/depth151_175_01.xml', mimeType="application/octet-stream")]
    public static const XML19:Class;
    [Embed(source='../../../../../../../map/depth151_175_02.xml', mimeType="application/octet-stream")]
    public static const XML20:Class;
    [Embed(source='../../../../../../../map/depth151_175_03s.xml', mimeType="application/octet-stream")]
    public static const XML21:Class;
    [Embed(source='../../../../../../../map/depth176-200_01.xml', mimeType="application/octet-stream")]
    public static const XML22:Class;
    [Embed(source='../../../../../../../map/depth176-200_02.xml', mimeType="application/octet-stream")]
    public static const XML23:Class;
    [Embed(source='../../../../../../../map/depth201-225_01.xml', mimeType="application/octet-stream")]
    public static const XML24:Class;
    [Embed(source='../../../../../../../map/depth201-225_02.xml', mimeType="application/octet-stream")]
    public static const XML25:Class;
    [Embed(source='../../../../../../../map/depth201-225_03s.xml', mimeType="application/octet-stream")]
    public static const XML26:Class;



    public static var res:Array = [
        XML1, XML2, XML3, XML4, XML5, XML6, XML7, XML8, XML9, XML10,
        XML11, XML12, XML13, XML14, XML15, XML16, XML17, XML18, XML19, XML20,
        XML21, XML22, XML23, XML24, XML25, XML26
    ];

    private static var _instance:MapManager;

    public var levels:Array = [];

    private var depth:Array = [0,10];


    public function MapManager(key:Key)
    {
        for (var i:int = 25; i< 650; i+=25)
        {
            depth.push(i);
        }

        for each (var cls:Class in res)
        {
            var level:MapVO = new MapVO(new XML(new cls));
            levels.push(level);
        }

    }

    public static function get instance():MapManager
    {
        if (_instance == null) _instance = new MapManager(new Key());
        return _instance;
    }

    public function get generateMap():Array
    {
        var out:Array = [];
        var lines:int=0;

        do
        {
            var depthIndex:int = 0;

            for(var d:int=0; d < depth.length;d++)
            {
                if (depth[d] <= lines)
                    depthIndex = d;
            }

            var chances:Array = [];
            for (var i:int=0; i < levels.length;i++)
            {
                var map:MapVO = levels[i];
                chances.push(map.mapChance[depthIndex]);
            }
            var index:int = CommonUtility.getRandomByChanceArr(chances);
            var selected:MapVO = levels[index];
            out.push(selected);
            lines += selected.field.length;
        }
        while(lines <700)
        return out;
    }


}
}
class Key{};
