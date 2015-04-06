package game.engine.graphic
{
	import game.engine.abstract.model.vo.PlanetVO;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class Planet extends GraphicBody
	{
		
		override public function Planet(vo:PlanetVO, graphic:*)
		{
			super(vo, BodyType.STATIC, graphic);
		
			allowRotation = false;
			var circle:Circle = new Circle(_vo.radius);
			shapes.add(circle);
		}
	}
}