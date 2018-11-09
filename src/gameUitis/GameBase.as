package gameUitis
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class GameBase extends Sprite
	{
		public function GameBase()
		{
			super();
			
			initlize();
		}
		
		public function get gameOver():Boolean
		{
			return _gameOver;
		}

		protected function control(event:TimerEvent):void
		{
			if(_gameOver)
			{
				removefrom_stage();
			}
			
			for each(var npc:NpcMonster in $.npcManager.Npc)
			{
				if(npc.gameControlMode == GameConst.CONTROL_ARR[0])
				{
					npc.positionPoint = _mousePoint;
				}
			}
		}
		
		protected function initlize():void
		{
			playerID = $.npcManager.getNpc(15,3,1,GameConst.CONTROL_ARR[1]);
			player = $.npcManager.Npc[playerID];
		}
		
		protected function initaddto_stage():void
		{
			if(_timeId == -1)
				_timeId = $.timeManager.setTimer(20,control,0);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			stage.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		protected function onMouseClick(event:MouseEvent):void
		{
			_mousePoint = new Point(mouseX - this.width,mouseY - this.height);
			for each(var npc:NpcMonster in $.npcManager.Npc)
			{
				if(npc.gameControlMode == GameConst.CONTROL_ARR[0])
				{
					npc.positionPoint = _mousePoint;
				}
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			
			switch(event.keyCode)
			{
				case Keyboard.UP:
					up = true;
					break;
				case Keyboard.DOWN:
					down = true;
					break;
				case Keyboard.LEFT:
					left = true;
					break;
				case Keyboard.RIGHT:
					right = true;
					break;
			}
			changeNpcPosition();
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					up = false;
					break;
				case Keyboard.DOWN:
					down = false;
					break;
				case Keyboard.LEFT:
					left = false;
					break;
				case Keyboard.RIGHT:
					right = false;
					break;
			}
			changeNpcPosition();
		}
		
		private function changeNpcPosition():void
		{
			for each(var npc:NpcMonster in $.npcManager.Npc)
			{
				if(npc.gameControlMode == GameConst.CONTROL_ARR[1])
				{
					if(up)npc.moveDirectionY = GameConst.UP;
					if(down)npc.moveDirectionY = GameConst.DOWN;
					if(left)npc.moveDirectionX = GameConst.LEFT;
					if(right)npc.moveDirectionX = GameConst.RIGHT;
					
					if(!up && !down)
						npc.moveDirectionY = GameConst.NONE;
					if(!left && !right)
						npc.moveDirectionX = GameConst.NONE;
					npc.move();
				}
			}
		}
		
		protected function removefrom_stage():void
		{
			if(_timeId != -1)
			{
				$.timeManager.clearTimer(_timeId);
				_timeId = -1;
			}
		}
		
		protected function addMonster():int
		{
			
			return 0;
		}
		
		public function set gameOver(isOver:Boolean):void
		{
			_gameOver = isOver;
		}
		
		public function set gameBegin(isBegin:Boolean):void
		{
			_gameBegin = isBegin;
			initaddto_stage();
		}
		
		private var _mousePoint:Point;
		private var up:Boolean,down:Boolean,left:Boolean,right:Boolean;
		private var _timeId:int = -1;
		private var gameCode:int = 0;
		private var _gameBegin:Boolean = false;
		private var _gameOver:Boolean = false;
		
		protected var playerID:int;
		protected var player:NpcMonster;
		protected var boss:NpcMonster;
	}
}