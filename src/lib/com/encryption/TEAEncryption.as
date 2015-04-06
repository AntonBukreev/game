package com.encryption
{
    /**
    * The Tiny Encryption Algorithm (TEA) is a block cipher notable for its simplicity of description and implementation.
	* It was designed by David Wheeler and Roger Needham of the Cambridge Computer Laboratory.
	* TEA suffers from equivalent keys and can be broken using a related-key attack requiring 2^23 chosen plaintexts and a time complexity of 2^32.
    */
	public class TEAEncryption
	{
		public var _sKey: String ;
		
		/**
		 * Destroys encryption data
		 */
		public function destroy(): void {
			_sKey = null;
		}
		
		/**
		 * Initialize key for TEA algorithm
		 * @param	sKey key for TEA algorithm
		 */
		public function initialize(sKey: String): void
		{
			_sKey = sKey;
		}
		
        /**
         * Encrypts string
         * @param	sSourceString string for encrypting
         * @return String containing encrypted value
         */	
		public function encrypt( sSourceString: String): String{
			return TEAEncrypt(sSourceString);
		}
		/**
		 * Decrypts string
         * @param	sSourceString string for decrypting
         * @return String containing decrypted value
		 */
		public function decrypt ( sSourceString: String): String{
			return TEADecrypt(sSourceString);
		}
		/**
		 * Decrypts and parses string
		 * @param	oDecryptionObject owner parsed variables
		 * @param	sSourceString string for decrypting and parsing
		 */						 
		public function decryptAndParse(sSourceString: String, oDecryptionObject: *): * {
			return parseVariables(TEADecrypt(sSourceString), oDecryptionObject);
		}
		
		public function getKey(): String
		{
			return _sKey;
		}
		
		/**************************************************************************************************\
		decrypt - Called by the subclass it is used for parsing an array of encrypted variables
		used most commonly by the appConfigFile.  These variables are loaded onto the specified object 
		as well as the root, due to a desire for consistent function
		\**************************************************************************************************/
		private function parseVariables(sParams: String, oDecryptionObject: *): * {
			if (!sParams || !oDecryptionObject) return null;
			var arr: Array = sParams.split("");
			for (var countI: int = 0; countI < arr.length; countI++) {
				if (sParams.charCodeAt(countI) == 0 ) {
					sParams = sParams.slice(0, (countI));
					break;
				}
			}
			
			var aVars: Array = sParams.split("&");
			for (var count: int = 0; count <aVars.length ;count++){
				var aVarHolder: Array = new Array();
				aVarHolder = aVars[count].split("=");
				oDecryptionObject[aVarHolder[0]] = aVarHolder[1];
			}
			return oDecryptionObject;
		}
	
		///////////////////////TEA ENCRYPTION FUNCTIONS/////////////////////
		
		/**
		* Encrypts a string with the specified key.
		*/
		private function TEAEncrypt(src: String): String
		{
			var v: Array = charsToLongs(strToChars(src));
			var k: Array = charsToLongs(strToChars(_sKey));
			var n: int = v.length;
			if (n == 0) return "";
			if (n == 1) v[n++] = 0;
			var z: uint = v[n - 1];
			var y: uint = v[0];
			var delta: uint = 0x9E3779B9; 
			var mx: uint;
			var e: uint;
			var q: uint = Math.floor(6 + 52 / n);
			var sum: uint = 0;

			while (q-- > 0) 
			{
				sum += delta;
				sum = sum >>> 0;  //Sasha added
				e = sum>>>2 & 3;
				for (var p: int = 0; p < n - 1; p++) 
				{
					y = v[p+1];
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
					// Begin Sasha changes
					//z = v[p] += mx;
					mx = mx >>> 0;
					v[p] += mx;
					v[p] = v[p] >>> 0;
					z = v[p];
					// End Sasha changes
				}
				y = v[0];
				mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
				// Begin Sasha changes
				//z = v[n-1] += mx;
				mx = mx >>> 0;
				v[n-1] += mx;
				v[n-1] = v[n-1] >>> 0;
				z = v[n-1];
				// End Sasha changes
			}
			
			return charsToHex(longsToChars(v));
		}
	
		/**
		* Decrypts a string with the specified key.
		*/
		private function TEADecrypt(src: String): String
		{
			var v: Array = charsToLongs(hexToChars(src));
			var k: Array = charsToLongs(strToChars(_sKey));
			var n: int = v.length;
			
			if (n == 0) return "";
			
			var z: uint = v[n - 1];
			var y: uint = v[0];
			var delta: uint = 0x9E3779B9;
			var mx: uint;
			var e: uint;
			var q: uint = Math.floor(6 + 52 / n);
			var sum: uint = q * delta;
			
			while (sum != 0) 
			{
				e = sum>>>2 & 3;
				for (var p: uint = n - 1; p > 0; p--)
				{
					z = v[p-1];
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
					y = v[p] -= mx;
				}
				
				z = v[n-1];
				mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
				y = v[0] -= mx;
				sum -= delta;
			}
			
			//Ann changes
			var aChars: Array = longsToChars(v);
			for (var i: int = aChars.length - 1; i >= 0; i--)
			{
				if (aChars[i] == 0)
				{
					aChars.pop();
				}
				else { break; }
			}
			//end Ann changes
			return charsToStr(aChars);
		}
	
		private function charsToLongs(chars: Array): Array
		{
			var temp: Array = new Array(Math.ceil(chars.length/4));
			for (var i: int = 0; i < temp.length; i++) 
			{
				temp[i] = chars[i*4] + (chars[i*4+1]<<8) + (chars[i*4+2]<<16) + (chars[i*4+3]<<24);
			}
			
			return temp;
		}
		
		private function longsToChars(longs: Array): Array
		{
			var codes: Array = new Array();
			for (var i: int = 0; i < longs.length; i++) 
			{
				codes.push(longs[i] & 0xFF, longs[i]>>>8 & 0xFF, longs[i]>>>16 & 0xFF, longs[i]>>>24 & 0xFF);
			}
			
			return codes;
		}
		
		private function charsToHex(chars: Array): String
		{
			var result: String = new String("");
			var hexes: Array = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
			for (var i: int = 0; i < chars.length; i++) 
			{
				result += hexes[chars[i] >> 4] + hexes[chars[i] & 0xf];
			}
			return result;
		}
		
		private function hexToChars(hex: String): Array
		{
			var codes: Array = new Array();
			for (var i: int = (hex.substr(0, 2) == "0x") ? 2 : 0; i < hex.length; i += 2) 
			{
				codes.push(parseInt(hex.substr(i, 2), 16));
			}
			
			return codes;
		}
		
		private function charsToStr(chars: Array): String
		{
			var result: String = new String("");
			for (var i: int = 0; i < chars.length; i++) 
			{
				result += String.fromCharCode(chars[i]);
			}
			
			return result;
		}
		
		private function strToChars(str: String): Array
		{
			var codes: Array = new Array();
			for (var i: int = 0; i < str.length; i++) 
			{
				codes.push(str.charCodeAt(i));
			}
			
			return codes;
		}
	}
}