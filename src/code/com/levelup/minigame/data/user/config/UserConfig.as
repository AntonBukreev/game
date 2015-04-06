/**
 * ...
 * @author Morozov V.
 */

package com.levelup.minigame.data.user.config
{
	import com.adobe.serialization.json.JSON;
import com.levelup.minigame.common.managers.shared.SharedObjectManager;
import com.levelup.minigame.data.user.AbstractDataEntity;
	import com.levelup.minigame.data.user.userEvents.UserEvent;

	public class UserConfig extends AbstractDataEntity
	{
		public static const ONE_MIN: Number = 60 * 1000;
		public static const ONE_HOUR: Number = 60 * ONE_MIN;
		public static const ONE_DAY: Number = 24 * ONE_HOUR;

		public function UserConfig() 
		{
			super();
            update(SharedObjectManager.loadData(SharedObjectManager.USER_CONFIG));
		}

        public function update(data:Object):void
        {
            if (data)
            {
                for each (var item: Object in data as Array)
                {
                    setData(item.id, item.value);
                }

                dispatchEvent(new UserEvent(UserEvent.UPDATE_CONFIG));
            }
        }

		private function setData (id: String, value: Object): void
		{
			if (!items[id])
                items[id] = new ConfigItem(id);

            if (value == null)
            {
                switch(id)
                {
                    case ConfigConsts.ID_LAST_BOOST: value = "8"; break;
                    case ConfigConsts.ID_IS_SOUND: value = true; break;
                    case ConfigConsts.ID_IS_MUSIC: value = true; break;
                }
            }


            (items[id] as ConfigItem).value = value;
		}
		
		public function getDataById (id: String):ConfigItem
		{
			if (items[id] == null)
                setData(id,null);
            return items[id];
		}
		
		public function save (): void
		{
            var arr:Array = [];
            for each(var item:Object in items)
            {
                arr.push(item);
            }
            SharedObjectManager.saveData(SharedObjectManager.USER_CONFIG,arr)
		}

	}
}