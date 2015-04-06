/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 13.01.15
 * Time: 15:35
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.common.managers.map {
	import com.adobe.serialization.json.JSON;


public class MapVO
{
    private var _xml:XML;

    public var mapChance:Array;
    public var field:Array;
    public var chances:Array;

    public function MapVO(xml:XML)
    {
        _xml = xml;

        mapChance = JSON.decode(xml.child("map_chance").toString());
        field = JSON.decode(xml.child("field").toString());
        chances = JSON.decode(xml.child("chanses").toString());
    }
}
}
