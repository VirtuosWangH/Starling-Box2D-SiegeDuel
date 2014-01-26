package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

	
	/**
	 *@author: wanghe
	 *@data: Jan 26, 2014
	 */
	
	public class TestB2 extends flash.display.Sprite
	{
		private var radToDeg:Number=57.2957795;
		private var world:b2World=new b2World(new b2Vec2(0,10),true);
		private var worldScale:Number=30;
		private var pickedTiles:int=0;
		private var pickedBodies:Array=new Array();
		private var idle:Timer;
		public function TestB2()
		{
			super();
		
			debugDraw();
			wall(320,470,600,20);
			wall(10,280,20,400);
			wall(630,280,20,400);
			
			brick(170+60*3,120+60*3,60,60,3*6+3);
			
			addEventListener(Event.ENTER_FRAME,update);
		}

		private function debugDraw():void {
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
		private function wall(pX:Number,pY:Number,w:Number,h:Number):void {
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX/worldScale,pY/worldScale);
			var polygonShape:b2PolygonShape=new b2PolygonShape();
			polygonShape.SetAsBox(w/2/worldScale,h/2/worldScale);
			var fixtureDef:b2FixtureDef=new b2FixtureDef();
			fixtureDef.shape=polygonShape;
			fixtureDef.density=2;
			fixtureDef.restitution=0.4;
			fixtureDef.friction=0.5;
			var theWall:b2Body=world.CreateBody(bodyDef);
			theWall.CreateFixture(fixtureDef);
		}
		private function brick(pX:Number,pY:Number,w:Number,h:Number,val:int):void {
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX/worldScale,pY/worldScale);
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.userData=new Object();
			bodyDef.userData.tile= Tile();
			bodyDef.userData.tile.buttonMode=true;
//			bodyDef.userData.tile.gotoAndStop(1);
			addChild(bodyDef.userData.tile);
			bodyDef.userData.picked=false;
			bodyDef.userData.tileValue=val;
			var polygonShape:b2PolygonShape=new b2PolygonShape();
			polygonShape.SetAsBox(w/2/worldScale,h/2/worldScale);
			var fixtureDef:b2FixtureDef=new b2FixtureDef();
			fixtureDef.shape=polygonShape;
			fixtureDef.density=2;
			fixtureDef.restitution=0.4;
			fixtureDef.friction=0.5;
			var theWall:b2Body=world.CreateBody(bodyDef);
			theWall.CreateFixture(fixtureDef);
		}
		private function update(e:Event):void {
			world.Step(1/30,10,10);
			world.ClearForces();
			for (var b:b2Body=world.GetBodyList(); b; b=b.GetNext()) {
				if (b.GetUserData()) {
					b.GetUserData().tile.x=b.GetPosition().x*worldScale;
					b.GetUserData().tile.y=b.GetPosition().y*worldScale;
					b.GetUserData().tile.rotation=b.GetAngle()*radToDeg;
				}
			}
			world.DrawDebugData();
		}
		private function Tile():Sprite{
			var tile:Sprite = new Sprite();
			tile.graphics.beginFill(0x000000);
			tile.graphics.drawRect(0,0,50,50);
			tile.graphics.endFill();
			return tile;
		}
	}
}