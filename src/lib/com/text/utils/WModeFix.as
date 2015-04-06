package com.text.utils//.WModeFix
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;

	/**
	 * This class does not have any description yet
	 * 
	 * @author erik.podrez
	 * @date May 18, 2010 11:01:38 AM
	 */
	
	public class WModeFix
	{
		protected static var _instance : WModeFix;
		
		protected var _currentField : TextField;
		protected var _ctrlUsed : Boolean = false;
		protected var _textEnteredBeforeChange : uint = 0;
		protected var _bugList : Array = [];
		
		public function WModeFix(key : SingleTonKey)
		{
			if(!key)
				throw new Error("It`s singleton! :(");
		}
		
		protected function handleFocusIn(event : FocusEvent) : void
		{
			if (event.target is TextField)
			{
				this._currentField = event.target as TextField;
				this._currentField.addEventListener(FocusEvent.FOCUS_OUT, WModeFix.instance.handleFocusOut);
				this._currentField.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
				this._currentField.addEventListener(TextEvent.TEXT_INPUT, this.handleTextInput);
				this._currentField.addEventListener(Event.CHANGE, this.handleTextChange);
			}
		}
		
		protected function handleKeyDown(event : KeyboardEvent) : void
		{
			this._ctrlUsed = event.ctrlKey;
		}
		
		protected function handleTextInput(event : TextEvent) : void
		{
			if (event.text.length == 2 && !this._ctrlUsed)
			{
				this._bugList[this._bugList.length] = new Bug(event.text, this._currentField.selectionBeginIndex + this._textEnteredBeforeChange);
			}
			this._textEnteredBeforeChange += 1;
		}
		
		protected function handleTextChange(event : Event) : void
		{
			if (this._bugList.length)
			{
				var i : int = 0, l : int = this._bugList.length, bug : Bug;
				for(i; i < l; i++)
				{
					bug = this._bugList[i];
					
					this._currentField.replaceText(bug.carretIndex,  bug.carretIndex + (this._currentField.embedFonts ? 1 : 2), bug.correction);
				}
				
				this._currentField.setSelection(bug.carretIndex + 1, bug.carretIndex + 1);
				this._bugList.length = 0;
			}
			this._textEnteredBeforeChange = 0;
		}
		
		protected function handleFocusOut(event : FocusEvent) : void
		{
			this._currentField.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			this._currentField.removeEventListener(FocusEvent.FOCUS_OUT, WModeFix.instance.handleFocusOut);
			this._currentField.removeEventListener(TextEvent.TEXT_INPUT, this.handleTextChange);
			this._currentField.removeEventListener(Event.CHANGE, this.handleTextChange);
			this._currentField = null;
		}
		
		protected static function get instance() : WModeFix
		{
			if (!WModeFix._instance)
				WModeFix._instance = new WModeFix(new SingleTonKey);
			
			return WModeFix._instance;
		}
		
		public static function set stage(obj : Stage) : void
		{
			obj.addEventListener(FocusEvent.FOCUS_IN, WModeFix.instance.handleFocusIn);
			// obj.addEventListener(FocusEvent.FOCUS_OUT, WModeFix.instance.handleFocusOut);
		}
		
	}
	
}

internal class Bug
{
	protected var _correction : String;
	protected var _carretIndex : int;
	
	public function Bug($bug : String, $carretIndex : int)
	{
		this._correction = this.correctText($bug);
		this._carretIndex = $carretIndex;
	}
	
	protected function correctText(text : String) : String
	{
		return text.length > 1 ? String.fromCharCode((text.charCodeAt(0) << 8) + text.charCodeAt(1)) : text;
	}
	
	public function get correction() : String
	{
		return this._correction;
	}
	
	public function get carretIndex() : int
	{
		return this._carretIndex;
	}
}

internal final class SingleTonKey
{
	public function SingleTonKey() {}
}