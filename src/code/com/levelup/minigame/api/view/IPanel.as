/**
 * ...
 * @author Morozov V.
 */
package com.levelup.minigame.api.view
{
	public interface IPanel extends IDisplayObject
	{
		function get name (): String;
		function get type (): String;
		function set data (value: Object): void;
		
		function get isInFocus():Boolean;
		function set isInFocus(value:Boolean):void;
		
		function show (): void;
		function hide (): void;
		function remove (): void;
		function destroy (): void;
	}
}