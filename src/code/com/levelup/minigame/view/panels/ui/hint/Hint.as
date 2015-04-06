package com.levelup.minigame.view.panels.ui.hint
{
	import com.greensock.TweenMax;
	import com.levelup.minigame.common.managers.CommonManager;
	import com.levelup.minigame.common.params.AssetNames;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Hint extends Sprite
	{

		private var textField: TextField;
		private var bg: Sprite;
		private const GAP: int = 12;
		private const ARROW_OFFSET: int = 22;
		public static var instance: Hint;

		public function Hint()
		{
			instance = this
		}

		public function init(): void
		{
			hide();

			bg = new Sprite()
			bg.addChild(CommonManager.instance.assetManager.getItemByLinkage(AssetNames.POPUP_ASSET, "tipsBgClip") as Sprite)
			addChild(bg)

			var newFormat: TextFormat = new TextFormat();
			newFormat.font = FontManager.getFontName(FontManager.ARIAL);
			newFormat.align = TextFieldAutoSize.CENTER;
			newFormat.color = 0x333333;
			newFormat.bold = false;
			newFormat.size = 18;
			newFormat.leftMargin = 2;
			newFormat.rightMargin = 1;
			newFormat.indent = 5;

			textField = new TextField();
			textField.width = 172;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.wordWrap = true;
			textField.selectable = false;

			textField.defaultTextFormat = newFormat;
			addChild(textField);
		}

		public function hide(): void
		{
			TweenMax.to(this, .25, {alpha: 0})
		}

		public function showUp(hintableObject: DisplayObject, text: String): void
		{
			textField.text = text.split("\r\n").join("\r").split("\t").join("");
			resizeBg();
			transformAndReplace(hintableObject);
			TweenMax.to(this, .25, { alpha: 1 });
		}

		private function resizeBg(): void
		{
			bg.getChildAt(0).width = textField.width + GAP * 2;
			bg.getChildAt(0).height = textField.height + ARROW_OFFSET + GAP * 2;
		}

		public function transformAndReplace(hintableObject: DisplayObject): void
		{
			var point: Point = hintableObject.localToGlobal(new Point(hintableObject.mouseX, hintableObject.mouseY));
			x = point.x;
			y = point.y;

			bg.scaleX = x + bg.width > stage.stageWidth ? -1 : 1;
			bg.scaleY = y - bg.height < 0 ? -1 : 1;

			textField.x = bg.scaleX == -1 ? -bg.width + GAP : GAP;
			textField.y = bg.scaleY == -1 ? bg.height - textField.height - GAP : -bg.height + GAP;
		}
	}
}