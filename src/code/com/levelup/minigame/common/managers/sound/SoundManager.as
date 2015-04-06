package com.levelup.minigame.common.managers.sound
{
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.sound.events.SoundEvent;
import com.levelup.minigame.data.user.config.ConfigConsts;
import com.levelup.minigame.data.user.config.ConfigItem;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.media.SoundChannel;

import sounds.MUSIC_GAME;

import sounds.MUSIC_LOBBY;


public class SoundManager extends EventDispatcher
{

    private static var music:Sound;
    private static var _sound:Sound;

    private static var _musicOn:Boolean;
    private static var _soundOn:Boolean;

    private static var _musicChannel:SoundChannel;
    private static var _soundChannel:SoundChannel;


    public function SoundManager(key:Key):void
    {
        super();
    }

    private static var _instance:SoundManager;

    public static function get instance():SoundManager
    {
        if (_instance == null) _instance = new SoundManager(new Key());
        return _instance;
    }

    public static function start(stage:DisplayObjectContainer):void
    {
        _soundOn = CommonManager.userData.config.getDataById(ConfigConsts.ID_IS_SOUND).value;
        _musicOn = CommonManager.userData.config.getDataById(ConfigConsts.ID_IS_MUSIC).value;
    }

    public function onGameScene():void
    {
        music = new MUSIC_GAME();
        updateMusic();
    }
    public function onLobbyScene():void
    {
        music = new MUSIC_LOBBY();
        updateMusic();
    }

    private function updateMusic():void
    {
        if (_musicChannel) _musicChannel.stop();
        if (musicOn)
        {
            _musicChannel = music.play(0,100);
        }
    }


    public  function get musicOn():Boolean {

        return _musicOn;
    }

    public  function set musicOn(value:Boolean):void
    {
        _musicOn = value;
        updateMusic();
        CommonManager.userData.config.getDataById(ConfigConsts.ID_IS_MUSIC).value = value;
        CommonManager.userData.config.save();
        dispatchEvent(new SoundEvent(SoundEvent.CHANGE_MUSIC, value));
    }

    public function get soundOn():Boolean {
        return _soundOn;
    }

    public function set soundOn(value:Boolean):void {
        _soundOn = value;
        if (_soundChannel)
            _soundChannel.stop();
        CommonManager.userData.config.getDataById(ConfigConsts.ID_IS_SOUND).value = value;
        CommonManager.userData.config.save();
        dispatchEvent(new SoundEvent(SoundEvent.CHANGE_SOUND, value));
    }


    public function sound(Cls:Class):void
    {
        _sound = new Cls;

        if (_soundOn)
            _soundChannel = _sound.play();
    }


}
}
class Key{};