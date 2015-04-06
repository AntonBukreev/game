/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 05.12.14
 * Time: 14:11
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.data.vo {
import com.levelup.minigame.common.managers.CommonManager;

public class BoostVO extends Object
{
    public var id:String;
    public var levelId:String;


    public function BoostVO(id:String, levelId:String)
    {
        this.id = id;
        this.levelId = levelId;

        super();
    }

    public function get count():int {
        return CommonManager.userData.userInventory.getItemById(id).count;
    }

    public function set count(value:int):void {
        CommonManager.userData.userInventory.getItemById(id).count = value;
    }

    public function get level():int {
        return CommonManager.userData.userInventory.getItemById(levelId).count;
    }

    public function set level(value:int):void {
        CommonManager.userData.userInventory.getItemById(levelId).count = value;
    }

    public function get color():int {
        return CommonManager.gameData.getBoostColor(id);
    }
}
}
