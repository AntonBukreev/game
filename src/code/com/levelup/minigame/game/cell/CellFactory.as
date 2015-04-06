/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 27.11.14
 * Time: 15:32
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.game.cell {
import components.CELL_INSTRUMENTS;

public class CellFactory
{
    public function CellFactory()
    {
    }

    public static function getCell(type:int,i:int,j:int):Cell
    {
        switch (type)
        {
            case CellEmpty.TYPE:        return new CellEmpty(i,j);      //0
            case CellGround.TYPE:       return new CellGround(i,j);     //1
            case CellCollection.TYPE:   return new CellCollection(i,j,randomCollectionId); //2 COLLECTION
            case CellChest.TYPE:        return new CellChest(i,j,randomChestId);      //3
            case CellRock.TYPE:         return new CellRock(i,j);       //4

            //5-34 BOOSTS

            case CellCoal.TYPE:                 return new CellCoal(i,j);       //5
            case CellGold.TYPE:                 return new CellGold(i,j);       //6
            case CellIron.TYPE:                 return new CellIron(i,j);       //7
            case CellEmeralds.TYPE:             return new CellEmeralds(i,j);   //8

            case CellBarrel.TYPE:               return new CellBarrel(i,j);      //10
            case CellDrill.TYPE:                return new CellDrill(i,j);       //11
            case CellCoil.TYPE:                 return new CellCoil(i,j);        //12
            case CellDynamite.TYPE:             return new CellDynamite(i,j);    //13
            case CellMine.TYPE:                 return new CellMine(i,j);        //14
            case CellFreeze.TYPE:               return new CellFreeze(i,j);      //15
            case CellLamp.TYPE:                 return new CellLamp(i,j);        //16
            case CellFireHammer.TYPE:           return new CellFireHammer(i,j);        //17
            case CellElectricHammer.TYPE:       return new CellElectricHammer(i,j);    //18
            case CellDoubleDrop.TYPE:           return new CellDoubleDrop(i,j);        //19




            //35-64 COLLECTIONS

            case CellConcrete.TYPE:      return new CellConcrete(i,j);    //70
            case CellInstruments.TYPE:      return new CellInstruments(i,j);    //71




        }
        return new CellEmpty(i,j);
    }


    private static function get randomCollectionId():int
    {
        //35-64
        return Math.floor(Math.random()*29.99)+35;
    }
    private static function get randomChestId():int
    {
        //65-67
        return Math.floor(Math.random()*2.99)+65;
    }
}
}
