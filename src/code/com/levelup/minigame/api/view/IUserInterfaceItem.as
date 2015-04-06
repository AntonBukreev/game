/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.api.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.text.TextField;

	public interface IUserInterfaceItem extends IEventDispatcher
	{
		function init ():void;
		
		function set position (value: Point): void;
		function set showAdvertising (value: Boolean): void;
		
		function set show (value: Boolean):void;
		function get show ():Boolean;

		function get view (): MovieClip;

		function getChildrenMovieClip (name: String): MovieClip;
		function getChildrenTextField (name: String): TextField;
		function getChildrenSimpleButton (name: String): SimpleButton;
		function addChildren (clip: DisplayObject): void;

		function destroy ():void;
	}
}