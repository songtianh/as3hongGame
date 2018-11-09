package defenseMode
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import gameUitis.$;
	import gameUitis.NpcMonster;
	
	public class defenseTower extends NpcMonster
	{
		public function defenseTower(hpMax:Number=0, attake:Number=5, defense:Number=0, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, true, CONTROLNODE);
			
			var touchSp:Sprite = drawTouchSp();
			this.addChild(touchSp);
			setRangeCircle();
			drawLev();
			touchSp.addEventListener(MouseEvent.CLICK,upLevel);
			touchSp.addEventListener(MouseEvent.MOUSE_OVER,showRange);
			touchSp.addEventListener(MouseEvent.MOUSE_OUT,hideRange);
		}
		
		public function drawTouchSp():Sprite
		{
			var touchSp:Sprite = new Sprite;
			touchSp.graphics.beginFill(0x00ff00,1.0);
			touchSp.graphics.drawRect(0,0,20,20);
			touchSp.graphics.endFill();
			return touchSp;
		}
		
		protected function hideRange(event:MouseEvent):void
		{
			spRange.visible = false;
		}
		
		protected function showRange(event:MouseEvent):void
		{
			spRange.visible = true;
		}
		
		private function setRangeCircle():void
		{
			if(spRange)
			{
				this.removeChild(spRange);
				spRange = null;
			}
			spRange = new Sprite;
			spRange.mouseEnabled = false;
			spRange.graphics.beginFill(0x00ff00,0.1);
			spRange.graphics.drawCircle(10,10,attkeRange);
			spRange.graphics.endFill();
			this.addChild(spRange);
			spRange.visible = false;
		}
		
		private function drawLev():void
		{
			levText.textColor = 0xff0000;
			levText.y = 0;
			levText.x = 0;
			levText.mouseEnabled = false;
			levText.width = 20;
			levText.height = 20;
			setLev();
			this.addChild(levText);
		}
		
		private function setLev():void
		{
			levText.text = "" + lev;
		}
		
		public function shoot(monsterIdArr:Array):Array
		{
			var bulletArr:Array = [];
			var count:int = 0;
			var monster:defenseMonster;
			var len:int = monsterIdArr.length;
			for(var i:int = 0 ; i<len ; i++)
			{
				monster = $.npcManager.Monster[monsterIdArr[i]];
				
				if(monster && canAttake(monster))
				{
					bulletArr.push(new Bullet(this,monster))
					count++;
					if(count == times)
						return bulletArr;
				}
			}
			return null;
		}
		
		private function canAttake(enemy:NpcMonster):Boolean
		{
			if(Math.abs(this.x - enemy.x) <= attkeRange && Math.abs(this.y - enemy.y) <= attkeRange)
				return true;
			return false;
		}
		
		protected function upLevel(event:MouseEvent):void
		{
			if(DefenseMap.money >= lev*100)
			{
				DefenseMap.money -= lev*100

				lev++;
				setLev();
				
				attakNum = attakNum + lev;
				
				
				attkeRange = 60 + lev*10;
				setRangeCircle();
				
				times = int(lev/3) + 1;
				showRange(null);
			}
		}
		/**多重攻击*/
		private var times:int = 1;
		private var spRange:Sprite;
		public var attkeRange:int = 60;
		private var levText:TextField = new TextField;
		private var lev:int = 1;
	}
}