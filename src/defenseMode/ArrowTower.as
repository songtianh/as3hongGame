package defenseMode
{
	import flash.display.Sprite;

	/**
	 * 弓箭塔
	 * */
	public class ArrowTower extends defenseTower
	{
		public function ArrowTower(hpMax:Number=0, attake:Number=5, defense:Number=0, CONTROLNODE:int=2)
		{
			//TODO: implement function
			super(hpMax, attake, defense, CONTROLNODE);
		}
		
		override public function drawTouchSp():Sprite
		{
			var touchSp:Sprite = new Sprite;
			touchSp.graphics.beginFill(0x00ff00,1.0);
			touchSp.graphics.drawRect(0,0,20,20);
			touchSp.graphics.endFill();
			return touchSp;
		}
	}
}