package com.encryption
{
	public class EncryptedInt
	{
		private var xor:int;
		private var value:int;

		public function EncryptedInt(initial:int = 0)
		{
			value = 0;
			xor = (Math.random() - 0.5) * 4294967296;
			val = initial;
		}

		public function set val(number:int):void
		{
			value = number ^ xor;
		}

		public function get val():int
		{
			return value ^ xor;
		}
	}
}