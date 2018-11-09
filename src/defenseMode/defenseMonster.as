package defenseMode
{
	import flash.geom.Point;
	import flash.text.TextField;
	
	import gameUitis.NpcMonster;
	
	public class defenseMonster extends NpcMonster
	{
		public function defenseMonster(type:int,hpMax:Number=0, attake:Number=0, defense:Number=1, CONTROLNODE:int=2)
		{
			super(10*type, attake, defense + int(type/2), false, CONTROLNODE);
			
			this._type = type;
			updataMode();
			text = new TextField;
			text.textColor = 0x00ffff;
			text.mouseEnabled = false;
			this.addChild(text);
			updataText();
			this.mouseEnabled = false;
		}
		
		private function updataMode():void
		{
			switch(_type)
			{
				case 1:
					this.graphics.beginFill(0xff00ff,1.0);
					this.graphics.drawRect(0,0,20,20);
					this.graphics.endFill();
					break;
				case 1:
					this.graphics.beginFill(0xff00ff,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
				case 2:
					this.graphics.beginFill(0xff0000,1.0);
					this.graphics.drawRect(0,0,20,20);
					this.graphics.endFill();
					break;
				case 3:
					this.graphics.beginFill(0xff0000,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
				case 4:
					this.graphics.beginFill(0x0000ff,1.0);
					this.graphics.drawRect(0,0,20,20);
					this.graphics.endFill();
					break;
				case 5:
					this.graphics.beginFill(0x0000ff,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
				case 6:
					this.graphics.beginFill(0xff66cc,1.0);
					this.graphics.drawRect(0,0,20,20);
					this.graphics.endFill();
					break;
				case 7:
					this.graphics.beginFill(0xff66cc,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
				case 8:
					this.graphics.beginFill(0xcc0000,1.0);
					this.graphics.drawRect(0,0,20,20);
					this.graphics.endFill();
					break;
				case 9:
					this.graphics.beginFill(0xcc0000,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
				default:
					this.graphics.beginFill(0xffffff,1.0);
					this.graphics.drawCircle(10,10,10);
					this.graphics.endFill();
					break;
			}
		}
		
		public function autoGoTo(pointVector:Vector.<Point>):void
		{
			var len:int = pointVector.length;
			var point:Point;
			if(len == 0)return;
			
			if(arriveFlag.length == 0)
			{
				for(var i:int = 0 ; i<len ; i++)
				{
					arriveFlag.push(false);
					
				}
			}
			for(i = 0 ; i<len ; i++)
			{
				if(!arriveFlag[i])
				{
					point = pointVector[i];
					this.moveTo(point);
					if(isArrive(point))
						arriveFlag[i] = true;
					return;
				}
			}
			
			//循环
			arriveFlag = new Vector.<Boolean>;
		}
		
		private function isArrive(point:Point):Boolean
		{
			if((Math.abs(this.x - point.x) <= 10) && (Math.abs(this.y - point.y) <= 10))
				return true;
			return false;
		}
		
		override public function attaked(atk:Number):void
		{
			super.attaked(atk);
			updataText();
		}
		
		private function updataText():void
		{
			text.text = "HP:" + hp;
		}
		
		private var _type:int = 1;
		private var text:TextField;
		private var arriveFlag:Vector.<Boolean> = new Vector.<Boolean>;
	}
}