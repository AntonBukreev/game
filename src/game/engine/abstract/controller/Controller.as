package game.engine.abstract.controller
{
	
	import game.Game;
	import game.engine.abstract.model.i.iBody;
	import game.engine.abstract.model.vo.ConfVO;
	import game.engine.abstract.model.vo.ObjectVO;
	import game.engine.graphic.GraphicBody;
	
	import nape.phys.Body;
	import nape.space.Space;
	
	public class Controller
	{
		
		/**
		 * all elements of this controller
		 */ 
		public var items:Array = [];
		
		public var graphicGenerator:Function;
		public var graphicDestroyer:Function;
		public var addToSpaceHandler:Function;
		public var removeFromSpaceHandler:Function;
		
		public function Controller()
		{
		}
		 
		protected function get conf():ConfVO
		{
			return Game.conf;
		}
		
		/**
		 * handler to generate graphic Handler(name:string):MovieClip
		 */ 
		public function generateGraphic(name:String):*
		{
			return graphicGenerator(name);
		}
		/**
		 * handler to remove graphic Handler(graphic:MovieClip):void
		 */

		public function destroyGraphic(item:*):void
		{
			graphicDestroyer(item.mGraphic);
		}
		/**
		 * handler to add engine component to space Handler(item:IBody):void
		 */

		public function addToSpace(arr:Array):void
		{
			for each(var item:Body in arr)
			{
				addToSpaceHandler(item);
			}
		}
		/**
		 * handler to remove engine component to space Handler(item:IBody):void
		 */
		public function destroyView(item:iBody):void
		{
			destroyGraphic(item);
			removeFromSpaceHandler(item);
		}
		
		
		/**
		 * init controller, generate start items and add tham to space 
		 */ 
		public function  init():void
		{
			addToSpace(generateItems);
		}
		
		public function get generateItems():Array
		{
			items = [];
			for(var i:int = 0; i < itemsCount; i ++)
			{
				items.push(generateItem());
			}
			return items;
		}
		
		public function generateItem(x:int=0,y:int=0):iBody
		{
			return null;
		}
		/**
		 * update
		 */ 
		public function update():void
		{
			for each(var item:GraphicBody in items)
			{
				if (item.vo.isOut())
				{
					onIsOut(item);
				}
				else
				{	
					item.update();
				}
			}
		}
		/**
		 * when item is very far
		 */ 
		public function onIsOut(item:iBody):void
		{
			resetVO(item.vo);
		}
		/**
		 * resetItem
		 */ 
		public function resetItem(item:iBody):void
		{
			if (item)
			{
				destroyView(item);
				addToSpaceHandler(replace(item, generateItem()));
			}
		}
		
		public function resetVO(vo:ObjectVO):void
		{
			resetItem(findItemByVO(vo));
		}
				
		protected function replace(oldItem:iBody, newItem:iBody):iBody
		{
			//very strange bug
			for(var i:int = 0; i < items.length; i++)
			{
				if (items[i] == oldItem) 
				{
					items[i] = newItem;
					return newItem;
				}
			}
			return newItem;
		}
		
		public function get itemsCount():int
		{
			return 0;
		}
		
		/**
		 * generate one item and add it to space
		 */ 
		public function addItem():void
		{
			var item:* = generateItem();
			items.push(item);
			addToSpaceHandler(item);
		}
		
		/**
		 * removeItem
		 */ 
		public function removeItem(item:iBody):void
		{
			if (item)
			{
				destroyView(item);
				var tempArr:Array = [];
				for each(var tempItem:* in items)
				{
					if (item != tempItem)
					{
						tempArr.push(tempItem);
					}
				}
				items = tempArr;
			}
		}
		
		public function onMove(x:int, y:int):void
		{
			
		}
		
		public function onDown(x:int, y:int):void
		{
			
		}
		
		public function findItemByVO(vo:ObjectVO):*
		{
			for each(var item:iBody in items)
			{
				if (item.vo.x == vo.x && item.vo.y == vo.y && item.vo.rotation ==vo.rotation) return item;
			}
			return null;
		}
		

		public function destroy():void
		{
			for each(var item:GraphicBody in items)
			{
				destroyView(item);
				item.destroy();
			}
			
			items = [];
			
			graphicGenerator = null;
			graphicDestroyer = null;
			addToSpaceHandler = null;
			removeFromSpaceHandler = null;
		}
		
	}
}