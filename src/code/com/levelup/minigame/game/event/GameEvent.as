/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 28.11.14
 * Time: 11:33
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.event {
import flash.events.Event;

public class GameEvent extends Event
{
    public var data:Object;

    public static const EVENT_STEP:String = "EVENT_STEP";
    public static const EVENT_FINISH:String = "EVENT_FINISH";
    public static const EVENT_CLICK_CELL:String = "EVENT_CLICK_CELL";
    public static const EVENT_CHANGE_TOP_LINE:String = "EVENT_CHANGE_TOP_LINE";
    public static const EVENT_COLLECT:String = "EVENT_COLLECT";
    public static const EVENT_COLLECT_COLLECTION:String = "EVENT_COLLECT_COLLECTION";
    public static const EVENT_CHANGE_DEPTH:String = "EVENT_CHANGE_DEPTH";
    public static const EVENT_COLLECT_CHEST:String = "EVENT_COLLECT_CHEST";

    public static const EVENT_CELL_REMOVED:String = "EVENT_CELL_REMOVED";
    public static const EVENT_EXPLOSED:String = "EVENT_EXPLOSED";
    public static const EVENT_FREEZE:String = "EVENT_FREEZE";
    public static const EVENT_UNFREEZE:String = "EVENT_UNFREEZE";
    public static const EVENT_LAMP:String = "EVENT_LAMP";
    public static const EVENT_LAMP_OFF:String = "EVENT_LAMP_OFF";
    public static const EVENT_DOUBLE_DROP:String = "EVENT_DOUBLE_DROP";
    public static const EVENT_CANCEL_DOUBLE_DROP:String = "EVENT_CANCEL_DOUBLE_DROP";
    public static const EVENT_FIRE_HUMMER:String = "EVENT_FIRE_HUMMER";
    public static const EVENT_ELECTRIC_HUMMER:String = "EVENT_ELECTRIC_HUMMER";
    public static const EVENT_UPDATE_VIEW:String = "EVENT_UPDATE_VIEW";




    public function GameEvent(type:String, data:Object=null)
    {
        this.data = data;
        super(type, true, false);
    }
}
}
