package gameUitis
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class NpcMonster extends Sprite
	{
		public function NpcMonster(hpMax:Number = 0,attake:Number = 0,defense:Number = 0,isFriend = false,CONTROLNODE:int = 2)
		{
			super();
			_hp = hpMax;
			_attak = attake;
			_defense = defense;
			_isFriend = isFriend;
			_gameControlMode = CONTROLNODE;
			
		}
		
		public function get defense():int
		{
			return _defense;
		}

		public function get attakNum():Number
		{
			return _attak;
		}

		public function set attakNum(value:Number):void
		{
			_attak = value;
		}

		public function get alive():Boolean
		{
			return _hp > 0;
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function attake(role:NpcMonster):void
		{
			role.attaked(_attak);
		}
		
		public function attaked(atk:Number):void
		{
			var damage:Number = (atk - _defense)<=0 ? 0 : (atk - _defense)
			_hp = _hp - damage;
		}
		
		public function recover(i:Number):void
		{
			_hp = _hp + i;
		}
		
		public function autoMove():void
		{
			
		}
		
		public function moveTo(p:Point):void
		{
			if(!p)return;
			if(this.x > p.x)
				_moveDirectionX = GameConst.LEFT;
			else if(this.x< p.x)
				_moveDirectionX = GameConst.RIGHT;
			else if(this.x== p.x)
				_moveDirectionX = GameConst.NONE;
			
			if(this.y> p.y)
				_moveDirectionY = GameConst.UP;
			else if(this.y< p.y)
				_moveDirectionY = GameConst.DOWN;
			else if(this.y== p.y)
				_moveDirectionY = GameConst.NONE;
			move();
		}
		
		public function move():void
		{
			switch(_moveDirectionX)
			{
				case GameConst.NONE:
					break;
				case GameConst.LEFT:
					this.x = this.x - _moveSpeed;
					break;
				case GameConst.RIGHT:
					this.x = this.x + _moveSpeed;
					break;
			}
			
			switch(_moveDirectionY)
			{
				case GameConst.NONE:
					break;
				case GameConst.UP:
					this.y = this.y - _moveSpeed;
					break;
				case GameConst.DOWN:
					this.y = this.y + _moveSpeed;
					break;
			}
		}
		
		public function isImpactItem(shape:Sprite):Boolean
		{
			return GameUtil.isImPact(this,shape);
		}
		
		public function isImpactNpcMonster(shape:NpcMonster):Boolean
		{
			return GameUtil.isImPact(this,shape);
		}
		
		public function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this)
		}
		
		public function get gameControlMode():int{return _gameControlMode;}
		public function set moveDirectionX(i:int):void
		{
			_moveDirectionX = i
		}
		public function set moveDirectionY(i:int):void
		{
			_moveDirectionY = i
		}
		public function set positionPoint(p:Point):void
		{
			_positionPoint = p;
			moveTo(p);
		}
		
		public function set image(image:Loader):void
		{
			_image = image;
			_image.x = 0;
			_image.y = 0;
			addChild(_image);
		}
		
		public function position(p:Point):void
		{
			this.x = p.x;
			this.y = p.y;
		}
		
		public function setSpeed(i:int):void
		{
			this._moveSpeed = i;
		}
		private var _image:Loader;
		private var _gameControlMode:int = GameConst.CONTROL_ARR[2];
		private var _isFriend:Boolean = false;
		private var _maxhp:Number = 10;
		private var _moveSpeed:Number = 2;
		private var _moveDirectionX:Number = 0;
		private var _moveDirectionY:Number = 0;
		private var _hp:Number = 10;
		private var _mp:Number = 0;
		private var _attak:Number = 2;
		private var _defense:int = 1;
		private var _positionPoint:Point;
	}
}