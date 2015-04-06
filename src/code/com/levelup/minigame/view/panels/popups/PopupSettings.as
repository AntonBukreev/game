/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 22.12.14
 * Time: 16:52
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups
{
import com.levelup.minigame.common.managers.CommonManager;
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.managers.sound.SoundManager;
import com.levelup.minigame.common.params.PanelNames;
import com.levelup.minigame.data.user.inventory.InventoryConst;
import com.levelup.minigame.view.panels.popups.Btn.BtnSwitch;

import flash.events.MouseEvent;

public class PopupSettings extends AbstractPopup
{

    private var _closeHandler:Function;

    private var soundBtn:BtnSwitch;
    private var musicBtn:BtnSwitch;

    public function PopupSettings(panelName:String, panelData:Object)
    {
        _closeHandler = panelData.closeHandler;
        super(panelName, panelData);
    }

    override protected function initView():void
    {
        super.initView();

        getChildrenSimpleButton("btnTutorial").addEventListener(MouseEvent.CLICK, onTutorial);

        soundBtn = new BtnSwitch(getChildrenMovieClip("btnSound"));
        soundBtn.selected = SoundManager.instance.soundOn;
        soundBtn.addEventListener(MouseEvent.CLICK, onSound);
        musicBtn = new BtnSwitch(getChildrenMovieClip("btnMusic"));
        musicBtn.selected = SoundManager.instance.musicOn;
        musicBtn.addEventListener(MouseEvent.CLICK, onMusic);

        getChildrenTextField("tfCoins").text = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_MONEY).count.toString();
        getChildrenTextField("tfDepth").text = CommonManager.userData.userInventory.getItemById(InventoryConst.BEST_DEPTH).count.toString();
        getChildrenTextField("tfScore").text = CommonManager.userData.experience.toString();
    }

    private function onMusic(event:MouseEvent):void
    {
         SoundManager.instance.musicOn = !SoundManager.instance.musicOn;
    }

    private function onSound(event:MouseEvent):void
    {
        SoundManager.instance.soundOn = !SoundManager.instance.soundOn;
    }

    private function onTutorial(event:MouseEvent):void
    {
        PanelsManager.addPanel(PanelNames.POPUP_TUTORIAL,{closeHandler:_closeHandler});
        remove();
    }

    override protected function closeClickHandler(event: MouseEvent): void
    {
        if (_closeHandler!=null)
            _closeHandler();
        remove();
    }

    override public function destroy():void
    {
        musicBtn.removeEventListener(MouseEvent.CLICK, onMusic);
        soundBtn.removeEventListener(MouseEvent.CLICK, onSound);

        soundBtn.destroy();
        musicBtn.destroy();
        getChildrenSimpleButton("btnTutorial").removeEventListener(MouseEvent.CLICK, onTutorial)
        super.destroy();
    }

}
}
