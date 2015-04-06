/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 09.12.14
 * Time: 15:21
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups.PopupChest {
import components.CELL_CHEST_65;
import components.CELL_CHEST_66;
import components.CELL_CHEST_67;

import flash.display.DisplayObjectContainer;
import flash.utils.getDefinitionByName;

public class ChestFactory {
    public function ChestFactory() {
    }

    public static function getChestCell(id:int):DisplayObjectContainer
    {

        CELL_CHEST_65;
        CELL_CHEST_66;
        CELL_CHEST_67;

        var ClassReference:Class = getDefinitionByName("components.CELL_CHEST_"+id) as Class;
        return new ClassReference();
    }
}
}
