package com.levelup.minigame.common.managers.language
{
import com.levelup.minigame.common.utils.CommonUtility;

import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import flash.external.ExternalInterface;
import flash.text.TextField;
import flash.utils.Dictionary;

import org.osmf.media.pluginClasses.PluginEntry;


/**
 * ...
 * @author Leez
 */




public class LanguageManager extends EventDispatcher
{

    [Embed(source='../../../../../../../res/values/strings.xml', mimeType="application/octet-stream")]
    public static const Strings:Class;
    [Embed(source='../../../../../../../res/values-ru/strings.xml', mimeType="application/octet-stream")]
    public static const RuStrings:Class;

    public static var dict:Dictionary = new Dictionary();

    public function LanguageManager()
    {


        var xml:XML = getLocale();



        var dataList:XMLList = xml.children();
        var i:int;
        for (i = 0; i < dataList.length(); i++)
        {
            var item:XML = dataList[i] as XML ;
            trace(item.attribute("name"),item.toString());
            dict[item.attribute("name").toString()] = item.toString();
        }

    }

    private function getLocale():XML
    {
        if (ExternalInterface.available)
        {
            var url:String = ExternalInterface.call("window.location.href.toString");
            var index:int = url.indexOf("?")

            var dictionary:Dictionary = new Dictionary();
            if(index>0)
            {

                try{
                    var par:String = url.substring(index+1);
                    var arr:Array = par.split("&");
                    for each(var s:String in arr)
                    {
                        var i:int = s.indexOf("=")
                        var name:String = s.substring(0,i);
                        var value:String = s.substr(i+1);
                        dictionary[name] = value;
                    }
                }
                catch(e:*)
                {}
            }

            switch(dictionary["locale"])
            {
                case "ru":
                    return new XML( new RuStrings);
            }
        }
        return new XML( new Strings);
    }

    private static function getValue(name:String):String
    {
        if (dict[name]) return dict[name];
        return name;
    }


    public static function parse(view:DisplayObjectContainer):void
    {
        for(var i:int = 0; i < view.numChildren; i++)
        {
            if (view.getChildAt(i) is DisplayObjectContainer)
            {
                parse(view.getChildAt(i) as DisplayObjectContainer);
            }
            else
            {
                if (view.getChildAt(i) is TextField)
                {
                    var tf:TextField = view.getChildAt(i) as TextField;
                    var name:String = tf.name;
                    if (name.indexOf("locale_")>=0)
                    {
                        name = name.replace("locale_","");
                        CommonUtility.setTextInFieldResizeV(tf, getValue(name));
                    }

                    tf.mouseEnabled = false;
                    tf.selectable = false;

                }
            }

        }



    }

    public static function getString(name:String):String
    {
        return getValue(name);
    }
}
}