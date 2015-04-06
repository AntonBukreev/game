package game.engine.abstract.model.i
{
	import game.engine.graphic.GraphicBody;
	import game.engine.abstract.model.vo.ObjectVO;
	
	import nape.geom.Vec2;

	public interface iBody
	{
		function update():void;
		function get vo():ObjectVO;
		function set vo(value:ObjectVO):void
			
		function checkCollision(item:*):void
		function onCollision(item:iBody):void
		function applyWorldForce(force:Vec2, poc:Vec2=null):void
	}
}