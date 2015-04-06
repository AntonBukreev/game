/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 14.01.15
 * Time: 16:57
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.common.managers.sound.events {
import flash.events.Event;

public class SoundEvent extends Event
{
    public static const CHANGE_SOUND:String = "CHANGE_SOUND";
    public static const CHANGE_MUSIC:String = "CHANGE_MUSIC";

    public var data:Boolean;

    public function SoundEvent(type:String, data:Boolean)
    {
        this.data = data;
        super(type, false, false);
    }
}
}
