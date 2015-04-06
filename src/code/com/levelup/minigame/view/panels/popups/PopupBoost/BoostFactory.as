/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 05.12.14
 * Time: 17:51
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.PopupBoost {
import components.BOOST_10;
import components.BOOST_11;
import components.BOOST_12;
import components.BOOST_13;
import components.BOOST_14;
import components.BOOST_15;
import components.BOOST_16;
import components.BOOST_17;
import components.BOOST_18;
import components.BOOST_19;
import components.BOOST_5;
import components.BOOST_6;
import components.BOOST_7;
import components.BOOST_8;
import components.BOOST_9;
import components.BOOST_GAME_10;
import components.BOOST_GAME_11;
import components.BOOST_GAME_12;
import components.BOOST_GAME_13;
import components.BOOST_GAME_14;
import components.BOOST_GAME_15;
import components.BOOST_GAME_16;
import components.BOOST_GAME_17;
import components.BOOST_GAME_18;
import components.BOOST_GAME_19;
import components.BOOST_GAME_5;
import components.BOOST_GAME_6;
import components.BOOST_GAME_7;
import components.BOOST_GAME_8;
import components.BOOST_GAME_9;

import flash.display.DisplayObjectContainer;
import flash.utils.getDefinitionByName;

public class BoostFactory
{
    public function BoostFactory() 
    {



    }

    public static function getBoost(id:String):DisplayObjectContainer
    {
        var classes:Array =
                [
                    BOOST_5,
                    BOOST_6,
                    BOOST_7,
                    BOOST_8,
                    BOOST_9,
                    BOOST_10,
                    BOOST_11,
                    BOOST_12,
                    BOOST_13,
                    BOOST_14,
                    BOOST_15,
                    BOOST_16,
                    BOOST_17,
                    BOOST_18,
                    BOOST_19
                ];

        var ClassReference:Class = getDefinitionByName("components.BOOST_"+id) as Class;
        return new ClassReference();
    }

    public static function getGameBoost(id:String):DisplayObjectContainer
    {
        var classes:Array =
                [
                    BOOST_GAME_5,
                    BOOST_GAME_6,
                    BOOST_GAME_7,
                    BOOST_GAME_8,
                    BOOST_GAME_9,
                    BOOST_GAME_10,
                    BOOST_GAME_11,
                    BOOST_GAME_12,
                    BOOST_GAME_13,
                    BOOST_GAME_14,
                    BOOST_GAME_15,
                    BOOST_GAME_16,
                    BOOST_GAME_17,
                    BOOST_GAME_18,
                    BOOST_GAME_19
                ];

        var ClassReference:Class = getDefinitionByName("components.BOOST_GAME_"+id) as Class;
        return new ClassReference();
    }
}
}
