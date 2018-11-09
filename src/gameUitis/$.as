package gameUitis
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class $
	{
		public function $()
		{	
			timeManager = new TimeManager;
			loadManager = new LoadManager;
			npcManager = new NpcMonsterManager;
		}
		
		static public var
			timeManager:TimeManager,
			loadManager:LoadManager,
			npcManager:NpcMonsterManager;
	}
}