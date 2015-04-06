/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.api.view
{
	import flash.events.IEventDispatcher;

	public interface ILoaderRespondent extends IEventDispatcher
	{
		function get percent (): int;
	}
}