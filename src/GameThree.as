package
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	
	import gameUitis.$;
	import gameUitis.GameBase;
	import gameUitis.NpcMonster;
	
	public class GameThree extends GameBase
	{
		public function GameThree()
		{
			super();
			
		}
		
		override protected function initaddto_stage():void
		{
			super.initaddto_stage();
			
			player.x = 0;
			player.y = 0;
			var str:String = "machine/star1.png";
			player.image =  $.loadManager.LoadImage(str);
			
			addChild(player);
			autoAddBoss();
		}
		
		override protected function control(event:TimerEvent):void
		{
			super.control(event);
			
			if(player.isImpactNpcMonster($.npcManager.Monster[_bossId]))
			{
				
				autoAddBoss();
			}
		}
		
		private function autoAddBoss():void
		{
			var len:int = $.npcManager.Monster.length;
//			if(len != 0)
//				$.npcManager.clearMonseter(_bossId);
			_bossId = $.npcManager.getMonster();
			var monster:NpcMonster = $.npcManager.Monster[_bossId];
			var str:String = "machine/star0.png";
			monster.image =  $.loadManager.LoadImage(str);
			monster.height = monster.width = 25;
			do
			{
				$.npcManager.randomPosition(monster);
			}
			while(!player.isImpactNpcMonster(monster))
			addChild(monster);
		}
		
		private var _bossId:int;
	}
}