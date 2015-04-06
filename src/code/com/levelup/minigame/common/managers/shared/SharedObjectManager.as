package com.levelup.minigame.common.managers.shared
{
import com.adobe.crypto.MD5;
import com.adobe.serialization.json.JSON;
import flash.net.SharedObject;

public class SharedObjectManager
{
    private static var sharedObjectInst: SharedObject;

    public static const USER_INVENTORY:String = "1";
    public static const USER_CONFIG:String = "2";


    private static function init():void
    {
        if (!sharedObjectInst)
        sharedObjectInst = SharedObject.getLocal("gnomeminigame");
    }

    public static function saveData(name: String, data: Object): void
    {
        init();
        var str:String  = JSON.encode(data);
        sharedObjectInst.data[name] = str;
        try
        {
            sharedObjectInst.flush();
        } catch (e: Error)
        {
            trace("error saving data");
        }
    }

    public static function loadData(name: String): Object
    {
        init();
        var str:*  = sharedObjectInst.data[name];

        var data:Object = null;
        if (str)
            data = JSON.decode(str);
        return data;
    }



    public static function clearData(): void
    {
        sharedObjectInst.clear();
    }
}
}