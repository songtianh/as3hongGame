package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import defenseMode.ArrowTower;
	import defenseMode.Bullet;
	import defenseMode.GunTower;
	import defenseMode.IceTower;
	import defenseMode.PoisionTower;
	import defenseMode.TowerConst;
	import defenseMode.TowerTypeButton;
	import defenseMode.defenseMonster;
	import defenseMode.defenseTower;
	
	import gameUitis.$;
	import gameUitis.Button;
	import gameUitis.GameBase;
	
	public class DefenseMap extends GameBase
	{
		public function DefenseMap()
		{
			super();
			
		}
		
		override protected function initlize():void
		{
			super.initlize();
			
			ruleText = new TextField();
			ruleText.width = 400;
			ruleText.textColor = 0x0000ff;   
			showRuleTips(true);
			this.addChild(ruleText);
			ruleText.x = 100 
			ruleText.y = 90 
		}
		
		private function showRuleTips(isShow:Boolean):void
		{
			if(isShow)
			{
				ruleText.text = "循环圈内的怪不得超过"+ MAX_MONSTER +"个\r" +
					"点击地面可放置防御塔，防御塔再次点击可升级\r" +
					"每次升级防御塔可增加防御塔的攻击力和攻击范围\r" +
					"防御塔每三级可多一个攻击目标\r" +
					"当前圈内怪物:" + currentMonsterNum + "/"+MAX_MONSTER+"";
			}
			else
			{
				var killMonster:int = bornMonster - currentMonsterNum;
				var monster:defenseMonster = new defenseMonster(currentStage);
				ruleText.text = "第"+ currentStage +"波,当前怪物属性: 生命" + monster.hp + "防御：" +  monster.defense +"\r" +
					"当前圈内怪物:" + currentMonsterNum + "/"+MAX_MONSTER+ "\r" +
					"总杀怪数：" + killMonster + "\r" +
					"当前选择的防御塔: " + TowerConst.TOWER_NAME[TowerTypeButton.selectType - 1];
			}
				
			if(monsterIdArr.length >= MAX_MONSTER)
			{
				gameOver = true;
			}
		}
		
		private function get currentMonsterNum():int
		{
			return monsterIdArr.length;
		}
		
		override protected function initaddto_stage():void
		{
			super.initaddto_stage();
			
			drawMap();
			showRuleTips(false);
			drawScoreAndMoney();
			this.graphics.beginFill(0xffff33,0.2);
			this.graphics.drawRect(this.x,this.y,this.width + 200,this.height + 200);
			this.graphics.endFill();

			this.addEventListener(MouseEvent.CLICK,setTower);
			
			addContruButton();
			drawButton();
		}
		
		private function drawButton():void
		{
			var button:TowerTypeButton;
			for(var i:int = 1 ; i<5 ; i++)
			{
				button = new TowerTypeButton(this,i);
				this.addChild(button);
				button.y = 320;
				button.x = 100 + 50*i;
				towerTypeButtonArr.push(button);
			}
		}
		
		private function addContruButton():void
		{
			pauseButton = new Button(true,"暂停");
			speedButton = new Button(true,"加速");
			this.addChild(pauseButton);
			this.addChild(speedButton);
			speedButton.x = pauseButton.x = 350;
			pauseButton.y = 120;
			speedButton.y = 180;
			
			pauseButton.addEventListener(MouseEvent.CLICK,pauseOrStart);
			speedButton.addEventListener(MouseEvent.CLICK,changeSpeed);
		}
		
		protected function pauseOrStart(event:MouseEvent):void
		{
			isPause = !isPause;
			if(isPause)
			{
				pauseButton.setText("开始");
			}
			else
			{
				pauseButton.setText("暂停");
			}
		}
		
		protected function changeSpeed(event:MouseEvent):void
		{
			if(speed == 2)
			{
				speed = 1;
				speedButton.setText("减速");
			}
			else
			{
				speed = 2;
				speedButton.setText("加速");
			}
		}
		
		protected function setTower(event:MouseEvent):void
		{
			var mx:Number = event.stageX;
			var my:Number = event.stageY;
			if((mx >= 40 && mx<= 300)  && (my >=40 && my<= 300))
			{
				var tower:defenseTower;
				for each(tower in towerVector)
				{
					if((mx>= tower.x && mx<= (tower.x + 20))  &&  (my>= tower.y && my<= (tower.y + 20)))
					{
						return;
					}
				}
				if(money >= 100)
				{
					money -=100;
					setMoney();
					switch(TowerTypeButton.selectType)
					{
						case TowerConst.TOWER_ARROW_TYPE:
							tower = new ArrowTower();
							break;
						case TowerConst.TOWER_GUN_TYPE:
							tower = new GunTower();
							break;
						case TowerConst.TOWER_ICE_TYPE:
							tower = new IceTower();
							break;
						case TowerConst.TOWER_POISION_TYPE:
							tower = new PoisionTower();
							break;
					}
					this.addChild(tower);
					tower.x = int((mx - 40)/20)*20 + 40;
					tower.y = int((my - 40)/20)*20 + 40;
					if(tower)
					{
						towerVector.push(tower);
					}
				}
			}
		}
		
		private function drawScoreAndMoney():void
		{
			var formatter:TextFormat = new TextFormat(); 
			formatter.size = 20; 
			formatter.bold = true;
			
			scoreText.autoSize =  TextFieldAutoSize.CENTER; 
			scoreText.textColor = 0xff0000;   
			this.addChild(scoreText);
			scoreText.setTextFormat(formatter);
			setScore();
			
			moneyText.autoSize =  TextFieldAutoSize.CENTER; 
			moneyText.textColor = 0x00ff00;   
			this.addChild(moneyText);
			moneyText.setTextFormat(formatter);
			setMoney();
			
			monsterText.autoSize =  TextFieldAutoSize.CENTER; 
			monsterText.textColor = 0x00ff00;   
			this.addChild(monsterText);
			monsterText.setTextFormat(formatter);
			setMonsterText();
			
			moneyText.y = scoreText.y = 340;
			scoreText.x = 150;
			moneyText.x = 250;
		}
		
		private function setMonsterText():void
		{
			var len:int = monsterIdArr.length;
			monsterText.text = "当前怪物数：" + len;	
			showRuleTips(false);
		}
		
		public function setMoney():void
		{
			moneyText.text = "资金：" + money;	
		}
		
		private function setScore():void
		{
			scoreText.text = "分数：" + score;	
		}
		
		private function autoAddMonster():void
		{
			var id:int = $.npcManager.getDefenseMonster(currentStage)
			var monster:defenseMonster = $.npcManager.Monster[id]
//			var str:String = "machine/star1.png";
//			monster.image =  $.loadManager.LoadImage(str);
			monsterIdArr.push(id);
			this.addChild(monster);
			
			monster.position(bornSpot);
		}
		
		private function drawMap():void
		{
			this.graphics.beginFill(0xC0C0C0,0.8);
			this.graphics.lineStyle(1,0xFF0000);
			//外
			this.graphics.moveTo(bornSpot.x,bornSpot.y);
			this.graphics.lineTo(bornSpot.x,maxPoint.y);
			
			this.graphics.moveTo(bornSpot.x,maxPoint.y);
			this.graphics.lineTo(maxPoint.x,maxPoint.y);
			
			this.graphics.moveTo(maxPoint.x,maxPoint.y);
			this.graphics.lineTo(maxPoint.x,bornSpot.y);
			
			this.graphics.moveTo(maxPoint.x,bornSpot.y);
			this.graphics.lineTo(bornSpot.x,bornSpot.y);
			//内
			this.graphics.moveTo(bornSpot.x + 20,bornSpot.y + 20);
			this.graphics.lineTo(bornSpot.x + 20,maxPoint.y - 20);
			
			this.graphics.moveTo(bornSpot.x + 20,maxPoint.y - 20);
			this.graphics.lineTo(maxPoint.x - 20,maxPoint.y - 20);
			
			this.graphics.moveTo(maxPoint.x - 20,maxPoint.y - 20);
			this.graphics.lineTo(maxPoint.x - 20,bornSpot.y + 20);
			
			this.graphics.moveTo(maxPoint.x - 20,bornSpot.y + 20);
			this.graphics.lineTo(bornSpot.x + 20,bornSpot.y + 20);
			this.graphics.endFill();
			
			pointVector.push(new Point(bornSpot.x,maxPoint.y - 20),new Point(maxPoint.x - 20,maxPoint.y - 20),new Point(maxPoint.x - 20,bornSpot.y),new Point(bornSpot.x,bornSpot.y));
		}
		
		private function runAndKill():void
		{
			var monster:defenseMonster;
			var len:int = monsterIdArr.length;
			for(var i:int = 0 ; i<len ; i++)
			{
				monster = $.npcManager.Monster[monsterIdArr[i]];
				if(monster && !monster.alive)
				{
					killed(i)
				}
			}
			for(i = 0 ; i<len ; i++)
			{
				monster = $.npcManager.Monster[monsterIdArr[i]];
				if(monster)
					monster.autoGoTo(pointVector);
			}
		}
		
		/**
		 * 怪物死亡后
		 * 加钱
		 * 清除怪物
		 * 增加得分
		 * */
		private function killed(id:int):void
		{
			$.npcManager.clearMonseter(monsterIdArr[id]);
			monsterIdArr.splice(id,1);
			money +=10;
			setMoney();
			score++;
			setScore();
		}
		
		override protected function control(event:TimerEvent):void
		{
			super.control(event);
			
			if(gameOver)
			{
				var textFild:TextField = new TextField;
				textFild.textColor = 0xff0000;
				textFild.text = "游戏结束"
				textFild.x = 200;
				textFild.y = 200;
				this.addChild(textFild);
			}
			
			checkCurrentStage();
			
			if(isPause)
				return;
			if(count%speed == 0)
			{
				var bullet:Bullet;
				var tower:defenseTower;
				if(count%(20 * speed) == 0)
				{
					autoAddMonster()
					bornMonster++;
				}
				//怪物行走和判断是否死亡
				runAndKill();
				
				if(count%(10 * speed) == 0)
				{
					for each(tower in towerVector)
					{
						var bulletArr:Array = tower.shoot(monsterIdArr);
						for each(bullet in bulletArr)
						{
							if(bullet)
							{
								addChild(bullet);
								bulletVector.push(bullet);
							}
						}
					}
				}
				
				for each(bullet in bulletVector)
				{
					if(bullet)
					{
						bullet.shoot();
						if(bullet.isDead() || !bullet._targetPoint)
						{
							if(bullet.parent)
							{
								bullet.dead();
							}
							bullet = null
						}
					}
				}
			}
			
			setMonsterText();
			count++;
		}
		
		/**判断当前是第几关*/
		private function checkCurrentStage():void
		{
			currentStage = bornMonster/(20) + 1;
		}
		
		public function updataTowerSelect():void
		{
			var button:TowerTypeButton;
			for each(button in towerTypeButtonArr)
			{
				button.setSelectVsible();
			}
		}
		
		private var towerTypeButtonArr:Array = [];
		private var isPause:Boolean = false;
		/**总刷怪数*/
		private var bornMonster:int = 0;
		/**当前关卡*/
		private var currentStage:int = 1;
		private const MAX_MONSTER:int = 30;
		private var towerVector:Vector.<defenseTower> = new Vector.<defenseTower>;
		private var scoreText:TextField = new TextField;
		private var moneyText:TextField = new TextField;
		private var monsterText:TextField = new TextField;
		private var count:int = 0;
		private var bulletVector:Vector.<Bullet> = new Vector.<Bullet>;
		private var pointVector:Vector.<Point> = new Vector.<Point>;
		private var monsterIdArr:Array = [];
		private var bornSpot:Point = new Point(40,20);
		private var minPoint:Point = new Point(20,20);
		private var maxPoint:Point = new Point(320,320);
		private var score:int = 0;
		public static var money:int = 250;
		private var ruleText:TextField;
		private var pauseButton:Button;
		private var speedButton:Button;
		private var speed:int = 2;
		
	}
}