package defenseMode
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TowerTypeButton extends Sprite
	{
		public function TowerTypeButton(parent:DefenseMap,type:int)
		{
			super();
			
			this._parent = parent;
			_type = type;
			drawButton(type);
			drawSelectSp();
		}
		
		private function drawSelectSp():void
		{
			selectSp.graphics.beginFill(0xffffff,0.1);
			selectSp.graphics.lineStyle(1,0xF9F900,1);
			selectSp.graphics.drawRect(0,0,20,20);
			selectSp.graphics.endFill();
			this.addChild(selectSp);
			selectSp.visible = false;
		}
		
		private function drawButton(type:int):void
		{
			var tower:defenseTower;
			var touchSp:Sprite;
			switch(type)
			{
				case TowerConst.TOWER_ARROW_TYPE:
					tower = new ArrowTower;
					touchSp = tower.drawTouchSp();
					this.addChild(touchSp);
					break;
				case TowerConst.TOWER_GUN_TYPE:
					tower = new GunTower;
					touchSp = tower.drawTouchSp();
					this.addChild(touchSp);
					break;
				case TowerConst.TOWER_ICE_TYPE:
					tower = new IceTower;
					touchSp = tower.drawTouchSp();
					this.addChild(touchSp);
					break;
				case TowerConst.TOWER_POISION_TYPE:
					tower = new PoisionTower;
					touchSp = tower.drawTouchSp();
					this.addChild(touchSp);
					break;
			}
			touchSp.addEventListener(MouseEvent.CLICK,isSelect);
			touchSp.addEventListener(MouseEvent.MOUSE_OVER,showTips);
			touchSp.addEventListener(MouseEvent.MOUSE_OUT,hideTips);
		}
		
		protected function hideTips(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function showTips(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function isSelect(event:MouseEvent):void
		{
			selectType = _type;
			_parent.updataTowerSelect();
		}
		
		public function setSelectVsible():void
		{
			selectSp.visible = selectType == _type
		}
		private var selectSp:Sprite = new Sprite;
		public static var selectType:int = 1;
		private var _type:int;
		private var _parent:DefenseMap;
		
	}
}