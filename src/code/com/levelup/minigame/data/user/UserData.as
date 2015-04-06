/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user
{
	import com.greensock.events.LoaderEvent;
	import com.levelup.minigame.api.view.ILoaderRespondent;
	import com.levelup.minigame.common.events.ProjectEvent;
	import com.levelup.minigame.common.managers.CommonManager;
	import com.levelup.minigame.common.params.LoaderConstants;
	import GamePreloader;
	import com.levelup.minigame.data.user.inventory.InventoryConst;
	import com.levelup.minigame.data.user.config.UserConfig;
	import com.levelup.minigame.data.user.inventory.UserInventory;
	import com.levelup.minigame.data.user.userEvents.UserEvent;
import com.levelup.minigame.data.vo.BoostVO;

import flash.events.Event;
	import flash.events.EventDispatcher;

	public class UserData extends EventDispatcher
	{
        private var _userConfig: UserConfig;
		private var _userInventory:UserInventory;

		
		private var syncProgress:int;
		private const progressArr:Array = [100];


		public function UserData()
		{
			_userConfig = new UserConfig();
			_userInventory = new UserInventory();
		}

		public function init():void
		{

        }
		

		public function parseData(data: Object):void
		{
			for (var key:String in data) 
			{
				updateData(key, data[key]);
			}
		}

		private function updateData(key:String, value:Object):void
		{

		}



        public function save():void
        {
            _userInventory.save();
            _userConfig.save();
        }

		public function get config():UserConfig { return _userConfig; }
		public function get userInventory():UserInventory { return _userInventory; }

        //---------------------------------------------------------------------
        //---------------------------------------------------------------------
        //---------------------------------------------------------------------

        public function get pickLevel():int
        {
            return _userInventory.getItemById(InventoryConst.ID_PICK_LEVEL).count;
        }

        public function set pickLevel(value:int):void
        {
            _userInventory.getItemById(InventoryConst.ID_PICK_LEVEL).count = value;
        }

        public function get money():int
        {
            return _userInventory.getItemById(InventoryConst.ID_MONEY).count;
        }

        public function set money(value:int):void
        {
            _userInventory.getItemById(InventoryConst.ID_MONEY).count = value;
        }

        public function get experience():int
        {
            return _userInventory.getItemById(InventoryConst.ID_EXPIRIENCE).count;
        }

        public function set experience(value:int):void
        {
            _userInventory.getItemById(InventoryConst.ID_EXPIRIENCE).count = value;
        }

        public function get level():int
        {
            return CommonManager.gameData.currentLevel;
        }

        //выдаем бонусы за переход уровня, и продажу коллекции
        public function get prize():int
        {
            return _userInventory.getItemById(InventoryConst.ID_PRIZE).count;
        }

        public function set prize(value:int):void
        {
            _userInventory.getItemById(InventoryConst.ID_PRIZE).count = value;
        }

        public function get allBoosts():Array
        {
            var boostIDs:Array = [];
            boostIDs = boostIDs.concat(InventoryConst.BOOSTS[0],InventoryConst.BOOSTS[1],InventoryConst.BOOSTS[2]);
            var levelIDs:Array = [];
            levelIDs = levelIDs.concat(InventoryConst.BOOSTS_LEVELS[0],InventoryConst.BOOSTS_LEVELS[1],InventoryConst.BOOSTS_LEVELS[2]);

            var boosts:Array = [];
            for(var i:int=0;i< boostIDs.length;i++)
            {
                boosts.push(new BoostVO(boostIDs[i],levelIDs[i]));
            }

            return boosts;
        }

        public function get boosts():Array
        {
            var out:Array=[];
            var boosts:Array = allBoosts;
            for each(var boost:BoostVO in boosts)
            {
                if (boost.level >0)
                {
                    out.push(boost);
                }
            }
            return out;
        }

        public function getBoostById(id:String):BoostVO
        {
            var boosts:Array = allBoosts;
            for each(var boost:BoostVO in boosts)
            {
                if (boost.id == id)
                {
                    return boost;
                }
            }
            return boost;
        }
    }
}