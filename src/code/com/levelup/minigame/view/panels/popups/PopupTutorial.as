/**
 * Created with IntelliJ IDEA.
 * User: rem
 * Date: 18.12.14
 * Time: 13:08
 * To change this template use File | Settings | File Templates.
 */
package com.levelup.minigame.view.panels.popups
{
public class PopupTutorial extends AbstractPopup
{
    private var _closeHandler:Function;
    public function PopupTutorial(panelName:String, panelData:Object)
    {
        _closeHandler = panelData.closeHandler;
        super(panelName, panelData);
    }


    override public function remove():void
    {
        if (_closeHandler!=null)
            _closeHandler();
        super.remove();
    }
}
}
