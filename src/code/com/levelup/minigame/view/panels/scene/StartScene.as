/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 15.12.14
 * Time: 16:52
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.scene {
import com.levelup.minigame.common.managers.panels.PanelsManager;
import com.levelup.minigame.common.params.PanelNames;

import flash.events.MouseEvent;

public class StartScene extends AbstractScene
{
    public function StartScene(panelName:String, panelData:Object)
    {
        super(panelName, panelData);
    }

    override protected function initView(): void
    {
        super.initView();
        sceneClip["mcStart"].addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(event:MouseEvent):void
    {
        PanelsManager.switchCurrentScene(PanelNames.SCENE_LOBBY);
    }

    override public function destroy():void
    {
        sceneClip["mcStart"].addEventListener(MouseEvent.CLICK, onClick);
        super.destroy();
    }

}
}
