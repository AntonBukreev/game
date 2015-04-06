package game.engine.graphic
{
	import game.Game;
	import game.engine.abstract.controller.ExplosionController;
	import game.engine.abstract.model.vo.ObjectVO;
	
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class Explosion extends GraphicBody
	{
		private var _creationTime:int = 0;
		
		public function Explosion(vo:ObjectVO, graphic:*=null)
		{
			_creationTime = new Date().time;
			super(vo, BodyType.STATIC, graphic);
			allowRotation = false;
			var circle:Circle = new Circle(1);
			shapes.add(circle);
		}
		
		override public function update():void
		{
			var radius:int = vo.radius;
			var time:int = (new Date().time - _creationTime);
			
			if (time < Game.conf.explosionTimeBorn)
			{
				radius = _vo.radius * Math.sqrt(time / Game.conf.explosionTimeBorn);
				
				var circle:Circle = new Circle(radius);
				shapes.add(circle);
					
				mGraphic.width = radius*2.5;
				mGraphic.height = radius*2.5;
			}	
			
			mGraphic.rotation = rotation;
			var l:Number = Math.sqrt(mGraphic.width*mGraphic.width + mGraphic.height*mGraphic.height)/2;
			var dy:Number = -l*Math.cos(Math.PI/4-rotation);
			var dx:Number = -l*Math.sin(Math.PI/4-rotation);
			mGraphic.x = position.x + dx;
			mGraphic.y = position.y + dy;  
			
			checkCollision(this); 
			
			if (time > Game.conf.explosionTimeBorn + Game.conf.explosionTimeLife )
			{
				ExplosionController.instance.removeItem(this);
				ExplosionController.instance.destroyView(this);
			}
		}
		
	}
}