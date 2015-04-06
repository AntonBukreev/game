/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 22.12.14
 * Time: 23:18
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.data.user.config {
public class ConfigItem
{
    private var _id:String;
    private var _value: Object;


    public function ConfigItem(id:String)
    {
        this._id = id;
        _value = null;
    }

    public function get id():String { return _id; }

    public function get value():Object {
        return _value;
    }

    public function set value(value:Object):void {
        _value = value;
    }
}
}
