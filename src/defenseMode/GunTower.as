package defenseMode
{
	import flash.display.Sprite;

	public class GunTower extends defenseTower
	{
		public function GunTower(hpMax:Number=0, attake:Number=5, defense:Number=0, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, CONTROLNODE);
		}
		
		override public function drawTouchSp():Sprite
		{
			var touchSp:Sprite = new Sprite;
			touchSp.graphics.beginFill(0xff0000,1.0);
			touchSp.graphics.drawRect(0,0,20,20);
			touchSp.graphics.endFill();
			return touchSp;
		}
	}
}