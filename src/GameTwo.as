package
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	
	import gameUitis.$;
	import gameUitis.Button;
	import gameUitis.GameBase;

	public class GameTwo extends GameBase
	{
		public function GameTwo()
		{
			super();
			
			
		}
		
		override protected function initlize():void
		{
			super.initlize();
			
			this.graphics.beginFill(0xC0C0C0,0.8);
			this.graphics.drawRect(0,0,240,240);
			this.graphics.lineStyle(1,0xFF0000);
			this.graphics.moveTo(80,0);
			this.graphics.lineTo(80,240);
			this.graphics.moveTo(160,0);
			this.graphics.lineTo(160,240);
		}
		
		override protected function initaddto_stage():void
		{
			super.initaddto_stage();
			
			for(var i:int=1 ; i<8 ; i++)
			{	
				var str:String = "machine/star-icon-" + i+".png";
				dict1[i] = $.loadManager.LoadImage(str);
				dict1[i].y = -160 + i*80;
				dict1[i].x = 2;
//				dict1[i].visible = false;
				addChild(dict1[i]);
				
				str = "machine/star-icon-" + i+".png";
				dict2[i] = $.loadManager.LoadImage(str);
				dict2[i].y = -160 + i*80;
				dict2[i].x = 82;
//				dict1[i].visible = false;
				addChild(dict2[i]);
				
				str = "machine/star-icon-" + i+".png";
				dict3[i] = $.loadManager.LoadImage(str);
				dict3[i].y = -160 + i*80;
				dict3[i].x = 162;
//				dict1[i].visible = false;
				addChild(dict3[i]);
			}
			
			buttonBegin = new Button(true,"开始");
			addChild(buttonBegin);
			buttonBegin.x = 240;
			buttonBegin.y = 240;
			buttonBegin.addEventListener(MouseEvent.CLICK,onCilic);
		}
		
		protected function onCilic(event:MouseEvent):void
		{
			if(istrue)
				timeID = $.timeManager.setTimer(30,changePosition);
			istrue = false;
		}
		
		private function changePosition(event:TimerEvent):void
		{
			count++
			speed = speed - 0.01
			for(var i:int=1 ; i<8 ; i++)
			{
				dict1[i].y = dict1[i].y + speed;
				
				if(dict1[i].y  >= 240)
				{
					dict1[i].y = dict1[i].y - 320;
				}
				
				dict2[i].y = dict2[i].y + speed;
				
				if(dict2[i].y  >= 240)
				{
					dict2[i].y = dict1[i].y - 320;
				}
				
				dict3[i].y = dict3[i].y + speed;
				
				if(dict3[i].y  >= 240)
				{
					dict3[i].y = dict3[i].y - 320;
				}
			}
			if(count>= 400)
			{
				for (i in dict1)
				{
					if(dict1[i].y == 80)
					{
						$.timeManager.clearTimer(timeID);
						successArr.push(dict1[i],dict2[i],dict3[i])
					}
				}
			}
			
		}
		
		private var successArr:Array = [];
		private var speed:Number = 8;
		private var count:int = 0;
		private var istrue:Boolean = true;
		private var buttonBegin:Button;
		private var dict1:Dictionary = new Dictionary;
		private var dict2:Dictionary = new Dictionary;
		private var dict3:Dictionary = new Dictionary;
		private var timeID:int;
	}
}