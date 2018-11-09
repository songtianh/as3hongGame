package
{
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	
	import gameUitis.$;
	import gameUitis.GameBase;
	
	public class GameOne extends GameBase
	{
		public function GameOne()
		{
			super();
			
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var mx:int = this.mouseX;
			var my:int = this.mouseY;
			for(var i:int in dictbg)
			{
				if(mx>= dictbg[i].x && mx<= (dictbg[i].x + 70))
				{
					if(my>= dictbg[i].y && my<= (dictbg[i].y + 70))
					{
						if(dict[i])
							dict[i].visible = true;
					}
				}
			}
			
			
			timeID = $.timeManager.setTimer(200,setImage,1);
			updataCode();
		}
		
		private function updataCode():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function setImage(event:TimerEvent):void
		{
			for (var i:int in dict)
			{
				if(dict[i].visible == true)
				{
					for (var j:int in dict)
					{
						if(dict[j].visible == true)
						{
							if(dict[i] != dict[j])
							{
								if(dict[i].name == dict[j].name)
								{
									delete dict[j];
									delete dict[i];
								}
								else
								{
									dict[i].visible = dict[j].visible = false;
								}
									
							}	
						}
					}
				}	
			}
			$.timeManager.clearTimer(timeID);
		}
		
		override protected function initaddto_stage():void
		{
			super.initaddto_stage();
			
			
			for(var i:int=1 ; i<19 ; i++)
			{
				
				
				str = "liliankan/bg.png";
				dictbg[i] = $.loadManager.LoadImage(str);
				dictbg[i].visible = true;
				addChild(dictbg[i]);
				
				var str:String = "liliankan/tp" + i+".png";
				dict[i] = $.loadManager.LoadImage(str);
				dict[i].visible = false;
				addChild(dict[i]);
			}
			setName();
			setPosiTion();
		}
		
		private function setName():void
		{
			for(var i:int=1 ; i<10 ; i++)
			{
				
				dict[i*2].name = dict[(i*2)-1].name =i;
			}
		}
		
		private function setPosiTion():void
		{
			for(var i:int in dictbg)
			{
				dictbg[i].x = (i/3)*70;
				dictbg[i].y = (i%3)*70;
				dict[i].x = dictbg[i].x + 5
				dict[i].y = dictbg[i].y +3
			}
		}
		
		private var dictbg:Dictionary = new Dictionary;
		private var dict:Dictionary = new Dictionary;
		private var timeID:int;
	}
}