/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.api.view
{
	public interface ILoader
	{
		function set displayPercent(value:int):void;
		function get displayPercent():int;
		function destroy():void;
	}
}