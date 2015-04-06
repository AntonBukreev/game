/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 08.12.14
 * Time: 16:47
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene.GameScene {
import com.levelup.minigame.game.cell.CellCoal;
import com.levelup.minigame.game.cell.CellCollection;
import com.levelup.minigame.game.cell.CellConcrete;
import com.levelup.minigame.game.cell.CellEmeralds;
import com.levelup.minigame.game.cell.CellGold;
import com.levelup.minigame.game.cell.CellGround;
import com.levelup.minigame.game.cell.CellInstruments;
import com.levelup.minigame.game.cell.CellIron;

public class MissionConsts {

    public static var TYPE_DEPTH:int = 0;
    public static var TYPE_COLLECT_COAL:int = CellCoal.TYPE;
    public static var TYPE_COLLECT_GOLD:int = CellGold.TYPE;
    public static var TYPE_COLLECT_IRON:int = CellIron.TYPE;
    public static var TYPE_COLLECT_EMERALDS:int = CellEmeralds.TYPE;
    public static var TYPE_COLLECT_GROUND:int = CellGround.TYPE;
    public static var TYPE_COLLECT_CONCRETE:int = CellConcrete.TYPE;
    public static var TYPE_COLLECT_INSTRUMENTS:int = CellInstruments.TYPE;
    public static var TYPE_COLLECT_COLLECTION:int = CellCollection.TYPE;

    public static var MISSIONS:Array = [
        TYPE_DEPTH,
        TYPE_COLLECT_COAL,
        TYPE_COLLECT_GOLD,
        TYPE_COLLECT_IRON,
        TYPE_COLLECT_EMERALDS,
        TYPE_COLLECT_GROUND,
        TYPE_COLLECT_CONCRETE,
        TYPE_COLLECT_INSTRUMENTS,
        TYPE_COLLECT_COLLECTION
    ];

    public static function get randomMissionIndex():int
    {
        return Math.floor(Math.random()*8.9);
    }

    public function MissionConsts()
    {
    }
}
}
