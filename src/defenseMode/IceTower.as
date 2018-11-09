package defenseMode
{
	import flash.display.Sprite;
	
	import gameUitis.NpcMonster;

	public class IceTower extends defenseTower
	{
		public function IceTower(hpMax:Number=0, attake:Number=5, defense:Number=0, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, CONTROLNODE);
		}
		
		override public function drawTouchSp():Sprite
		{
			var touchSp:Sprite = new Sprite;
			touchSp.graphics.beginFill(0x0000ff,1.0);
			touchSp.graphics.drawRect(0,0,20,20);
			touchSp.graphics.endFill();
			return touchSp;
		}
		
		override public function attake(role:NpcMonster):void
		{
			role.setSpeed(1);
		}
	}
}