/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user.inventory
{
import com.levelup.minigame.common.managers.shared.SharedObjectManager;
import com.levelup.minigame.data.user.AbstractDataEntity;
	import com.levelup.minigame.data.user.userEvents.UserEvent;

	public class UserInventory extends AbstractDataEntity
	{
		protected var changeItems:Array;
		
		public function UserInventory()
		{
			super();
			changeItems = [];

            update(SharedObjectManager.loadData(SharedObjectManager.USER_INVENTORY));
		}

		public function update(data:Object):void
		{
			if (data)
            {
    			for each (var item: Object in data as Array)
	    		{
		    		updateItem(item.id, item.count);
			    }

			    changeItems = [];
			    dispatchEvent(new UserEvent(UserEvent.UPDATE_INVENTORY));
            }
		}

		public function save():void
		{
            var arr:Array = [];
            for each(var item:Object in items)
            {
                arr.push(item);
            }
            SharedObjectManager.saveData(SharedObjectManager.USER_INVENTORY,arr)
		}

		private function updateItem(key: String, value:int):void
		{
			var item: UserInventoryItem = getItemById(key);
			item.count = value;
			item.dispatchEvent(new UserEvent(UserEvent.UPDATE_INVENTORY_ITEM));
		}

		public function getItemById(id:String):UserInventoryItem
		{
			var result:UserInventoryItem;
			result = items[id];
			if (!result) result = addItem(id);
			return result;
		}

		private function addItem(id:String):UserInventoryItem
		{
			var item:UserInventoryItem = new UserInventoryItem(id, changeItem);
			items[id] = item;
            init(item);
			return item;
		}

        private function init(item:UserInventoryItem):void
        {
            switch (item.id)
            {
                case InventoryConst.ID_BOOST_LEVEL_COAL:
                case InventoryConst.ID_BOOST_LEVEL_GOLD:
                case InventoryConst.ID_BOOST_LEVEL_IRON:
                case InventoryConst.ID_BOOST_LEVEL_EMERALD:
                case InventoryConst.ID_BOOST_LEVEL_BOX:
                    item.count = 1;
                    break;
            }
        }

		private function changeItem(id:String, count: int):void
		{
			changeItems.push( { key:id, value: count } );
		}
	}
}