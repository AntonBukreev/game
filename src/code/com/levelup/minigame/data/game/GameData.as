/**
 * ...
 * @authitsor Morozov V.
 */

package com.levelup.minigame.data.game
{
import com.adobe.images.BitString;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.utils.CommonUtility;
import com.levelup.minigame.data.user.AbstractDataEntity;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.data.vo.BoostVO;
import com.levelup.minigame.game.cell.CellCoal;
import com.levelup.minigame.game.cell.CellEmeralds;
import com.levelup.minigame.game.cell.CellFactory;
import com.levelup.minigame.game.cell.CellGold;
import com.levelup.minigame.game.cell.CellIron;
import com.levelup.minigame.view.panels.scene.GameScene.MissionConsts;
import com.levelup.minigame.view.panels.scene.LobbyScene.CollectionFactory;

import org.osmf.net.NetStreamSwitchManager;

public class GameData
{
    public function GameData()
    {
    }

    private const picks:Array = [
        {hits:50,price:0},
        {hits:55,price:50},
        {hits:60,price:80},
        {hits:64,price:120},
        {hits:68,price:170},
        {hits:72,price:230},
        {hits:76,price:300},
        {hits:80,price:380},
        {hits:84,price:470},
        {hits:88,price:570},
        {hits:92,price:680},
        {hits:95,price:790},
        {hits:98,price:910},
        {hits:101,price:1040},
        {hits:104,price:1180},
        {hits:107,price:1330},
        {hits:110,price:1490},
        {hits:112,price:1660},
        {hits:114,price:1840},
        {hits:115,price:2030}
    ];



    public function getMoneyByItem(type:int):int
    {
        switch (type)
        {
            case CellCoal.TYPE: return 1;
            case CellGold.TYPE: return 2;
            case CellIron.TYPE: return 4;
            case CellEmeralds.TYPE: return 5;
        }
        return 0;
    }

    public function get currentHits():int
    {
        var level:int = CommonManager.userData.pickLevel;
        return picks[level].hits;
    }

    public function get nextPick():Object
    {
        var level:int = CommonManager.userData.pickLevel +1;
        if (level < picks.length)
            return picks[level];
        return 0;
    }

    public function getLevelExp(level:int):int
    {
        var pickPrice:int = picks[CommonManager.userData.pickLevel].price;
        var needExp:Number = (level) * 200 - pickPrice;
        if (needExp < 0) needExp = 0;
        return needExp;
    }

    public function get currentLevel():int
    {
        var pickPrice:int = picks[CommonManager.userData.pickLevel].price;
        var currentExpirience:int = CommonManager.userData.experience;

        var i:int=0;
        do
        {
            i+=1;
            var needExp:Number = i * 200 - pickPrice;
        }
        while(currentExpirience >= needExp)

        return i - 1;

    }

    public function getExperience(money:int, depth:int):int
    {
        return money*1.6 + depth*1.4;
    }

    public function getBoostPrize():BoostVO
    {
        var indexColor:int = CommonUtility.getRandomByChanceArr([60,30,10]);
        var indexID:int = CommonUtility.getRandomByChanceArr([100,100,100,100,100]);
        var boostId:String = InventoryConst.BOOSTS[indexColor][indexID];
        var boostLevelId:String = InventoryConst.BOOSTS_LEVELS[indexColor][indexID];
        return new BoostVO(boostId,boostLevelId);
    }

    public function get openWoodChest():String
    {
        //Деньги (25-100 денег, с шагом 25)	50%
        //кусок коллекции (любой случайный кусок)	25%
        //любой белый павер ап	25%

        var index:int = CommonUtility.getRandomByChanceArr([50,25,25]);

        switch (index)
        {
            case 0: return InventoryConst.ID_MONEY;
            case 1: return randomCollectionId.toString();
            case 2:
                var indexID:int = CommonUtility.getRandomByChanceArr([100,100,100,100,100]);
                var boostId:String = InventoryConst.BOOSTS[0][indexID];
                return boostId;

        }
        return InventoryConst.ID_MONEY;
    }

    public function isCollection(id:String):Boolean
    {
        for each(var collection:Array in InventoryConst.COLLECTIONS)
            for each(var collectionId:String in collection)
            {
                if (collectionId == id) return true;
            }
        return false;
    }

    public function isBoosts(id:String):Boolean
    {
        for each(var color:Array in InventoryConst.BOOSTS)
            for each(var boostId:String in color)
            {
                if (boostId == id) return true;
            }
        return false;
    }

    public function getBoostColor(id:String):int
    {
        for (var i:int=0; i < InventoryConst.BOOSTS.length; i++)
        {
            var color:Array = InventoryConst.BOOSTS[i];
            for each(var boostId:String in color)
            {
                if (boostId == id) return i;
            }
        }
        return 0;
    }

    private static function get randomCollectionId():int
    {
        //35-64
        return Math.floor(Math.random()*29.99)+35;
    }

    public function get openIronChest():String
    {
        // Любой белый павер ап	60%
        //Любой зеленый павер ап	40%

        var indexColor:int = CommonUtility.getRandomByChanceArr([60,40,0]);
        var indexID:int = CommonUtility.getRandomByChanceArr([100,100,100,100,100]);
        var boostId:String = InventoryConst.BOOSTS[indexColor][indexID];
        return boostId;
    }
    public function get openGoldChest():String
    {
        // Любой зеленый павер ап	60%
        //Любой синий павер ап	40%

        var indexColor:int = CommonUtility.getRandomByChanceArr([0,60,40]);
        var indexID:int = CommonUtility.getRandomByChanceArr([100,100,100,100,100]);
        var boostId:String = InventoryConst.BOOSTS[indexColor][indexID];
        return boostId;
    }


    private const MISSION_COUNT:Array =
            [
                [50,50,50,50,75,75,75,75,75,100,100,100,100,100,125,125,125,125,125,125],
                [12,12,12,12,15,15,15,15,15,18,18,18,18,18,22,22,22,22,22,22],
                [10,10,10,10,12,12,12,12,12,15,15,15,15,15,18,18,18,18,18,18],
                [8 ,8 ,8 ,8 ,10,10,10,10,10,12,12,12,12,12,15,15,15,15,15,15],
                [6 ,6 ,6 ,6 ,8 ,8 ,8 ,8 ,8 ,10,10,10,10,10,12,12,12,12,12,12],
                [40,40,40,40,55,55,55,55,55,75,75,75,75,75,100,100,100,100,100,100],
                [25,25,25,25,30,30,30,30,30,40,40,40,40,40,50,50,50,50,50,50],
                [1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,4],
                [1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,4]
            ];


    public function missionCount(index:int):int
    {
        return MISSION_COUNT[index][CommonManager.userData.pickLevel];
    }

    public function missionComplete():int
    {
        if (CommonManager.userData.pickLevel<9)
            return 2;
        return 3;
    }

    public function getStars(index:int):int
    {
        var items:int = 0;
        for each ( var id:String in InventoryConst.COLLECTIONS[index])
        {
            if (CommonManager.userData.userInventory.getItemById(id).count>0)
            {
                items += 1;
            }
        }

        switch (items)
        {
            case 0: return 0;
            case 1: return 1;
            case 2: return 1;
            case 3: return 2;
            case 4: return 2;
            case 5: return 3;
        }
        return 0;
    }

    public function boostUpgradePrice(boost:BoostVO):int
    {
        var k:int = 5;
        if (int (boost.id) <15 ) k = 3;
        if (int (boost.id) <10 ) k = 1;

        return int(boost.level)*50 + k*100;
    }

    public function boostSellPrice(boost:BoostVO):int
    {
        var k:int = 500;
        if (int(boost.id) <15 ) k = 200;
        if (int(boost.id) <10 ) k = 50;
        return k;
    }

    public function getCoinsByChest():int
    {
        var money:Array = [25,50,75, 100];
        var index:int = CommonUtility.getRandomByChanceArr([10,10,10,10]);
        return money[index];
    }

    public function get currentPick():Object
    {
        var level:int = CommonManager.userData.pickLevel;
        if (level < picks.length)
            return picks[level];
        return {count:0};
    }

    private const SELL_COLLECTION_ONE_STAR:Array = [100, 50, 50, 50,50, 100];
    private const SELL_COLLECTION_TWOE_STAR:Array = [1,0,0,0,0,1];
    private const SELL_COLLECTION_THREE_STAR:Array = [2,1,2,1,1,2];

    public function collectionPriceItem(index:int):String
    {
        var ri:int = CommonUtility.getRandomByChanceArr([10,10,10,10,10]);
        var arr:Array = [];
        var stars:int = CommonManager.gameData.getStars(index);
        if (stars == 1)
            return InventoryConst.ID_MONEY;
        if (stars == 2)
        {
            arr = InventoryConst.BOOSTS[SELL_COLLECTION_TWOE_STAR[index]];
            return arr[ri];
        }
        if (stars == 3)
        {
            arr = InventoryConst.BOOSTS[SELL_COLLECTION_THREE_STAR[index]];
            return arr[ri];
        }
        return "";
    }

    public function collectionPriceCount(index:int):int
    {
        var stars:int = CommonManager.gameData.getStars(index);
        if (stars == 1)
            return SELL_COLLECTION_ONE_STAR[index];
        if (stars == 2)
        {
            return 1;
        }
        if (stars == 3)
        {
            return 1;
        }
        return 0;
    }
}
}