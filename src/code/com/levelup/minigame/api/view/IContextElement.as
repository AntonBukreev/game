/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.api.view
{
	import flash.geom.Point;

	public interface IContextElement extends IDisplayObject
	{
		function set crd (value: Point): void;
		function set id (value: String): void;
		function get id (): String;
		function destroy(): void;
	}
}