package assets
{
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import flash.display.MovieClip;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		public function Assets()
		{
		}
		  
		
		[Embed(source="../assets/assets.swf", symbol="MСPage1")]
		public static var MCPage1:Class;
		
		[Embed(source="../assets/assets.swf", symbol="MCPage2")]
		public static var MCPage2:Class;
		
		public static var mc1:flash.display.MovieClip  = new MCPage1() as flash.display.MovieClip;
		public static var atlas1:TextureAtlas = DynamicAtlas.fromMovieClipContainer(mc1);
		
		public static var mc2:flash.display.MovieClip  = new MCPage2() as flash.display.MovieClip;
		public static var atlas2:TextureAtlas = DynamicAtlas.fromMovieClipContainer(mc2);
		
		
		public static var mcBackGround	:String = "mcBackGround";
		public static var mcStartBtn	:String = "mcStartBtn";
		
		public static var mcPlanet		:String = "mcPlanet";
		public static var mcPig			:String = "mcPig";	
		public static var mcBird0		:String = "mcBird0";
		public static var mcBird1		:String = "mcBird1";
		public static var mcBird2		:String = "mcBird2";
		public static var mcBird3		:String = "mcBird3";		
		public static var mcGreen		:String = "mcGreen";
		public static var mcBlue		:String = "mcBlue";
		public static var mcDot			:String = "mcDot";

		
		public static function getPage1MC(name:String):starling.display.MovieClip
		{
			return new starling.display.MovieClip(atlas1.getTextures(name));
		}
		
		public static function getPage2MC(name:String):starling.display.MovieClip
		{
			return new starling.display.MovieClip(atlas2.getTextures(name));
		}
		
		
		public static function getTexture(name:String):Texture
		{
			var t:Texture = atlas1.getTextures(name)[0];
			return t;
		}
		
		
		
	}
}  