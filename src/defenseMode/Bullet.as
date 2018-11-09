package defenseMode
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import gameUitis.NpcMonster;
	
	public class Bullet extends Sprite
	{
		public function Bullet(tower:defenseTower,monster:NpcMonster)
		{
			super();
			
			_tower = tower;
			
			if(_tower is ArrowTower)
				this.graphics.beginFill(0x00ff00,1.0);
			else if(_tower is GunTower)
				this.graphics.beginFill(0xff0000,1.0);
			else if(_tower is IceTower)
				this.graphics.beginFill(0x0000ff,1.0);
			else if(_tower is PoisionTower)
				this.graphics.beginFill(0x00ff00,1.0);
			this.graphics.drawCircle(1,1,2);
			this.graphics.endFill();
			this.x = _tower.x;
			this.y = _tower.y;
			_targetPoint = monster;
		}
		
		public function shoot():void
		{
			if(!_targetPoint)
			{
				return;
			}
			var targetPointCenterX:Number = _targetPoint.x + 10
			var targetPointCenterY:Number = _targetPoint.y + 10
				
			if(this.x > targetPointCenterX)
			{
				if((this.x - targetPointCenterX)>=speed)
					this.x = this.x - speed;
				else
					this.x = this.x - (this.x -targetPointCenterX);
			}
			else
			{
				if((targetPointCenterX - this.x)>=speed)
					this.x = this.x + speed;
				else
					this.x = this.x + (targetPointCenterX - this.x);
			}
			
			if(this.y > targetPointCenterY)
			{
				if((this.y - targetPointCenterY)>=speed)
					this.y = this.y - speed;
				else
					this.y = this.y - (this.y - targetPointCenterY);
			}
			else
			{
				if((targetPointCenterY - this.y)>=speed)
					this.y = this.y + speed;
				else
					this.y = this.y + (targetPointCenterY- this.y);
			}
		}
		
		public function isDead():Boolean
		{
			if(!_targetPoint)
			{
				return true;
			}
			var targetPointCenterX:Number = _targetPoint.x + 10
			var targetPointCenterY:Number = _targetPoint.y + 10
			if(this.x == targetPointCenterX && this.y == targetPointCenterY)
			{
				return true;
			}
			
			return false;
		}
		
		public function dead():void
		{
			_tower.attake(_targetPoint);
			this.parent.removeChild(this);
		}
		
		private var speed:Number = 5;
		public var _targetPoint:NpcMonster;
		private var _tower:defenseTower;
	}
}