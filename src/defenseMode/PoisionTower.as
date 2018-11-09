package defenseMode
{
	import flash.display.Sprite;

	public class PoisionTower extends defenseTower
	{
		public function PoisionTower(hpMax:Number=0, attake:Number=5, defense:Number=0, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, CONTROLNODE);
		}
		
		override public function drawTouchSp():Sprite
		{
			var touchSp:Sprite = new Sprite;
			touchSp.graphics.beginFill(0x00ff00,1.0);
			touchSp.graphics.drawCircle(10,10,10);
			touchSp.graphics.endFill();
			return touchSp;
		}
	}
}