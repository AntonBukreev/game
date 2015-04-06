/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 08.12.14
 * Time: 18:52
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene.LobbyScene {
import components.COLLECTION_35;
import components.COLLECTION_36;
import components.COLLECTION_37;
import components.COLLECTION_38;
import components.COLLECTION_39;
import components.COLLECTION_40;
import components.COLLECTION_41;
import components.COLLECTION_42;
import components.COLLECTION_43;
import components.COLLECTION_44;
import components.COLLECTION_45;
import components.COLLECTION_46;
import components.COLLECTION_47;
import components.COLLECTION_48;
import components.COLLECTION_49;
import components.COLLECTION_50;
import components.COLLECTION_51;
import components.COLLECTION_52;
import components.COLLECTION_53;
import components.COLLECTION_54;
import components.COLLECTION_55;
import components.COLLECTION_56;
import components.COLLECTION_57;
import components.COLLECTION_58;
import components.COLLECTION_59;
import components.COLLECTION_60;
import components.COLLECTION_61;
import components.COLLECTION_62;
import components.COLLECTION_63;
import components.COLLECTION_64;
import components.COLLECTION_BACK_35;
import components.COLLECTION_BACK_36;
import components.COLLECTION_BACK_37;
import components.COLLECTION_BACK_38;
import components.COLLECTION_BACK_39;
import components.COLLECTION_BACK_40;
import components.COLLECTION_BACK_41;
import components.COLLECTION_BACK_42;
import components.COLLECTION_BACK_43;
import components.COLLECTION_BACK_44;
import components.COLLECTION_BACK_45;
import components.COLLECTION_BACK_46;
import components.COLLECTION_BACK_47;
import components.COLLECTION_BACK_48;
import components.COLLECTION_BACK_49;
import components.COLLECTION_BACK_50;
import components.COLLECTION_BACK_51;
import components.COLLECTION_BACK_52;
import components.COLLECTION_BACK_53;
import components.COLLECTION_BACK_54;
import components.COLLECTION_BACK_55;
import components.COLLECTION_BACK_56;
import components.COLLECTION_BACK_57;
import components.COLLECTION_BACK_58;
import components.COLLECTION_BACK_59;
import components.COLLECTION_BACK_60;
import components.COLLECTION_BACK_61;
import components.COLLECTION_BACK_62;
import components.COLLECTION_BACK_63;
import components.COLLECTION_BACK_64;
import components.COLLECTION_C_35;
import components.COLLECTION_C_36;
import components.COLLECTION_C_37;
import components.COLLECTION_C_38;
import components.COLLECTION_C_39;
import components.COLLECTION_C_40;
import components.COLLECTION_C_41;
import components.COLLECTION_C_42;
import components.COLLECTION_C_43;
import components.COLLECTION_C_44;
import components.COLLECTION_C_45;
import components.COLLECTION_C_46;
import components.COLLECTION_C_47;
import components.COLLECTION_C_48;
import components.COLLECTION_C_49;
import components.COLLECTION_C_50;
import components.COLLECTION_C_51;
import components.COLLECTION_C_52;
import components.COLLECTION_C_53;
import components.COLLECTION_C_54;
import components.COLLECTION_C_55;
import components.COLLECTION_C_56;
import components.COLLECTION_C_57;
import components.COLLECTION_C_58;
import components.COLLECTION_C_59;
import components.COLLECTION_C_60;
import components.COLLECTION_C_61;
import components.COLLECTION_C_62;
import components.COLLECTION_C_63;
import components.COLLECTION_C_64;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.utils.getDefinitionByName;

public class CollectionFactory {
    public function CollectionFactory() {
    }

    public static function getCollection(id:String):DisplayObjectContainer
    {

        COLLECTION_35;
        COLLECTION_36;
        COLLECTION_37;
        COLLECTION_38;
        COLLECTION_39;
        COLLECTION_40;
        COLLECTION_41;
        COLLECTION_42;
        COLLECTION_43;
        COLLECTION_44;

        COLLECTION_45;
        COLLECTION_46;
        COLLECTION_47;
        COLLECTION_48;
        COLLECTION_49;
        COLLECTION_50;
        COLLECTION_51;
        COLLECTION_52;
        COLLECTION_53;
        COLLECTION_54;

        COLLECTION_55;
        COLLECTION_56;
        COLLECTION_57;
        COLLECTION_58;
        COLLECTION_59;
        COLLECTION_60;
        COLLECTION_61;
        COLLECTION_62;
        COLLECTION_63;
        COLLECTION_64;



        var ClassReference:Class = getDefinitionByName("components.COLLECTION_"+id) as Class;
        return new ClassReference();
    }

    public static function getCollectionBack(id:String):DisplayObjectContainer
    {

        COLLECTION_BACK_35;
        COLLECTION_BACK_36;
        COLLECTION_BACK_37;
        COLLECTION_BACK_38;
        COLLECTION_BACK_39;
        COLLECTION_BACK_40;
        COLLECTION_BACK_41;
        COLLECTION_BACK_42;
        COLLECTION_BACK_43;
        COLLECTION_BACK_44;

        COLLECTION_BACK_45;
        COLLECTION_BACK_46;
        COLLECTION_BACK_47;
        COLLECTION_BACK_48;
        COLLECTION_BACK_49;
        COLLECTION_BACK_50;
        COLLECTION_BACK_51;
        COLLECTION_BACK_52;
        COLLECTION_BACK_53;
        COLLECTION_BACK_54;

        COLLECTION_BACK_55;
        COLLECTION_BACK_56;
        COLLECTION_BACK_57;
        COLLECTION_BACK_58;
        COLLECTION_BACK_59;
        COLLECTION_BACK_60;
        COLLECTION_BACK_61;
        COLLECTION_BACK_62;
        COLLECTION_BACK_63;
        COLLECTION_BACK_64;



        var ClassReference:Class = getDefinitionByName("components.COLLECTION_BACK_"+id) as Class;
        return new ClassReference();
    }


    public static function getCollectionCell(id:int):DisplayObjectContainer
    {

        //cells
        COLLECTION_C_35;
        COLLECTION_C_36;
        COLLECTION_C_37;
        COLLECTION_C_38;
        COLLECTION_C_39;
        COLLECTION_C_40;
        COLLECTION_C_41;
        COLLECTION_C_42;
        COLLECTION_C_43;
        COLLECTION_C_44;

        COLLECTION_C_45;
        COLLECTION_C_46;
        COLLECTION_C_47;
        COLLECTION_C_48;
        COLLECTION_C_49;
        COLLECTION_C_50;
        COLLECTION_C_51;
        COLLECTION_C_52;
        COLLECTION_C_53;
        COLLECTION_C_54;

        COLLECTION_C_55;
        COLLECTION_C_56;
        COLLECTION_C_57;
        COLLECTION_C_58;
        COLLECTION_C_59;
        COLLECTION_C_60;
        COLLECTION_C_61;
        COLLECTION_C_62;
        COLLECTION_C_63;
        COLLECTION_C_64;

        var ClassReference:Class = getDefinitionByName("components.COLLECTION_C_"+id) as Class;
        return new ClassReference();
    }
}
}
