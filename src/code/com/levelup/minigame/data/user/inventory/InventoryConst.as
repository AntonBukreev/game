/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user.inventory
{
public class InventoryConst
{
    public static const ID_MONEY:String = "1";
    public static const ID_PICK_LEVEL:String = "2";
    public static const ID_EXPIRIENCE:String = "3";
    public static const ID_PRIZE:String = "4";

    //WHITE
    public static const ID_BOOST_COAL:String = "5";
    public static const ID_BOOST_GOLD:String = "6";
    public static const ID_BOOST_IRON:String = "7";
    public static const ID_BOOST_EMERALD:String = "8";
    public static const ID_BOOST_BOX:String = "9";
    //GREEN
    public static const ID_BOOST_BARREL:String = "10";
    public static const ID_BOOST_DRILL:String = "11";
    public static const ID_BOOST_COIL:String = "12";
    public static const ID_BOOST_DYNAMITE:String = "13";
    public static const ID_BOOST_MINE:String = "14";
    //BLUE
    public static const ID_BOOST_FREEZE:String = "15";
    public static const ID_BOOST_LAMP:String = "16";
    public static const ID_BOOST_FIRE_HAMMER:String = "17";
    public static const ID_BOOST_ELECTRIC_HAMMER:String = "18";
    public static const ID_BOOST_DOUBLEDROP:String = "19";

    //WHITE LEVEL
    public static const ID_BOOST_LEVEL_COAL:String = "20";
    public static const ID_BOOST_LEVEL_GOLD:String = "21";
    public static const ID_BOOST_LEVEL_IRON:String = "22";
    public static const ID_BOOST_LEVEL_EMERALD:String = "23";
    public static const ID_BOOST_LEVEL_BOX:String = "24";
    //GREEN LEVEL
    public static const ID_BOOST_LEVEL_BARREL:String = "25";
    public static const ID_BOOST_LEVEL_DRILL:String = "26";
    public static const ID_BOOST_LEVEL_COIL:String = "27";
    public static const ID_BOOST_LEVEL_DYNAMITE:String = "28";
    public static const ID_BOOST_LEVEL_MINE:String = "29";
    //BLUE LEVEL
    public static const ID_BOOST_LEVEL_FREEZ:String = "30";
    public static const ID_BOOST_LEVEL_LAMP:String = "31";
    public static const ID_BOOST_LEVEL_FIRE_HAMMER:String = "32";
    public static const ID_BOOST_LEVEL_ELECTRIC_HAMMER:String = "33";
    public static const ID_BOOST_LEVEL_DOUBLEDROP:String = "34";

    public static const ID_COLLECTION_1_1:String = "35";
    public static const ID_COLLECTION_1_2:String = "36";
    public static const ID_COLLECTION_1_3:String = "37";
    public static const ID_COLLECTION_1_4:String = "38";
    public static const ID_COLLECTION_1_5:String = "39";

    public static const ID_COLLECTION_2_1:String = "40";
    public static const ID_COLLECTION_2_2:String = "41";
    public static const ID_COLLECTION_2_3:String = "42";
    public static const ID_COLLECTION_2_4:String = "43";
    public static const ID_COLLECTION_2_5:String = "44";

    public static const ID_COLLECTION_3_1:String = "45";
    public static const ID_COLLECTION_3_2:String = "46";
    public static const ID_COLLECTION_3_3:String = "47";
    public static const ID_COLLECTION_3_4:String = "48";
    public static const ID_COLLECTION_3_5:String = "49";

    public static const ID_COLLECTION_4_1:String = "50";
    public static const ID_COLLECTION_4_2:String = "51";
    public static const ID_COLLECTION_4_3:String = "52";
    public static const ID_COLLECTION_4_4:String = "53";
    public static const ID_COLLECTION_4_5:String = "54";

    public static const ID_COLLECTION_5_1:String = "55";
    public static const ID_COLLECTION_5_2:String = "56";
    public static const ID_COLLECTION_5_3:String = "57";
    public static const ID_COLLECTION_5_4:String = "58";
    public static const ID_COLLECTION_5_5:String = "59";

    public static const ID_COLLECTION_6_1:String = "60";
    public static const ID_COLLECTION_6_2:String = "61";
    public static const ID_COLLECTION_6_3:String = "62";
    public static const ID_COLLECTION_6_4:String = "63";
    public static const ID_COLLECTION_6_5:String = "64";

    public static const ID_CHEST_WOOD:String = "65";
    public static const ID_CHEST_IRON:String = "66";
    public static const ID_CHEST_GOLD:String = "67";
    public static const ID_CHEST_KEY:String = "68";

    public static const BEST_DEPTH:String = "69";
    public static const BEST_MONEY:String = "70";

    public static const COLLECTIONS:Array = [
    [
        ID_COLLECTION_1_1,
        ID_COLLECTION_1_2,
        ID_COLLECTION_1_3,
        ID_COLLECTION_1_4,
        ID_COLLECTION_1_5
    ],
    [
        ID_COLLECTION_2_1,
        ID_COLLECTION_2_2,
        ID_COLLECTION_2_3,
        ID_COLLECTION_2_4,
        ID_COLLECTION_2_5
    ],
    [
        ID_COLLECTION_3_1,
        ID_COLLECTION_3_2,
        ID_COLLECTION_3_3,
        ID_COLLECTION_3_4,
        ID_COLLECTION_3_5
    ],
    [
        ID_COLLECTION_4_1,
        ID_COLLECTION_4_2,
        ID_COLLECTION_4_3,
        ID_COLLECTION_4_4,
        ID_COLLECTION_4_5
    ],
    [
        ID_COLLECTION_5_1,
        ID_COLLECTION_5_2,
        ID_COLLECTION_5_3,
        ID_COLLECTION_5_4,
        ID_COLLECTION_5_5
    ],
    [
        ID_COLLECTION_6_1,
        ID_COLLECTION_6_2,
        ID_COLLECTION_6_3,
        ID_COLLECTION_6_4,
        ID_COLLECTION_6_5
    ]
];

    public static const BOOSTS:Array =
            [
                [
                    ID_BOOST_COAL,
                    ID_BOOST_GOLD,
                    ID_BOOST_IRON,
                    ID_BOOST_EMERALD,
                    ID_BOOST_BOX
                ],
                [
                    ID_BOOST_BARREL,
                    ID_BOOST_DRILL,
                    ID_BOOST_COIL,
                    ID_BOOST_DYNAMITE,
                    ID_BOOST_MINE
                ],
                [
                    ID_BOOST_FREEZE,
                    ID_BOOST_LAMP,
                    ID_BOOST_FIRE_HAMMER,
                    ID_BOOST_ELECTRIC_HAMMER,
                    ID_BOOST_DOUBLEDROP
                ]
            ];
    public static const BOOSTS_LEVELS:Array =
            [
                [
                    ID_BOOST_LEVEL_COAL,
                    ID_BOOST_LEVEL_GOLD,
                    ID_BOOST_LEVEL_IRON,
                    ID_BOOST_LEVEL_EMERALD,
                    ID_BOOST_LEVEL_BOX
                ],
                [
                    ID_BOOST_LEVEL_BARREL,
                    ID_BOOST_LEVEL_DRILL,
                    ID_BOOST_LEVEL_COIL,
                    ID_BOOST_LEVEL_DYNAMITE,
                    ID_BOOST_LEVEL_MINE
                ],
                [
                    ID_BOOST_LEVEL_FREEZ,
                    ID_BOOST_LEVEL_LAMP,
                    ID_BOOST_LEVEL_FIRE_HAMMER,
                    ID_BOOST_LEVEL_ELECTRIC_HAMMER,
                    ID_BOOST_LEVEL_DOUBLEDROP
                ]
            ];







}
}

