﻿package EasyBox2D.objects{	import flash.display.DisplayObject;		import Box2D.Collision.Shapes.b2MassData;	import Box2D.Collision.Shapes.b2Shape;	import Box2D.Common.Math.b2Vec2;	import Box2D.Dynamics.b2Body;	import Box2D.Dynamics.b2BodyDef;	import Box2D.Dynamics.b2FixtureDef;	import Box2D.Dynamics.b2World;	import Box2D.Dynamics.Joints.b2Joint;		import EasyBox2D.EasyBox2D;
    /**	The QuickObject class wraps nearly all the Box2D classes neccessary for rigid body instantiation - such as b2BodyDef, b2Body, b2Shape and b2DistanceJointDef. The QuickObject class also wraps a few properties of b2Body to enable easy alteration of position and rotation.		There is no need to instantiate a QuickObject directly. You should use the QuickBox2D add methods:	{@link com.actionsnippet.qbox.QuickBox2D#addBox()}	{@link com.actionsnippet.qbox.QuickBox2D#addCircle()}	{@link com.actionsnippet.qbox.QuickBox2D#addPoly()}	{@link com.actionsnippet.qbox.QuickBox2D#addGroup()}	{@link com.actionsnippet.qbox.QuickBox2D#addJoint()}		@author Zevan Rosser	@version 1.0	*/	public class BaseObject {		protected var _bodyDef:b2BodyDef;		protected var _shapeRequest:b2Shape;		protected var _fixtureDef:b2FixtureDef;		public var body:b2Body;						/** The b2DistanceJoint if this QuickObject is a JointObject. */		public var joint:b2Joint;				private var loc:b2Vec2;				protected var defaults:Object;				public var params:Object;				protected var type:String;				protected var w:b2World;				protected var ebox:EasyBox2D;				/**		The userData property from the b2Body or b2Joint. This will usually be a DisplayObject populated by QuickBox2D.		*/        public function get userData():*{			return body.GetUserData();		}				public function set userData(object:*):*{			body.SetUserData(object);		}				// wrappers for position				/**		Sets the x and y location of the rigid body.		@param x The x location.		@param y The y location.		*/		public function setLoc(x:Number, y:Number):void{			loc.x = x;			loc.y = y;			body.SetPositionAndAngle(loc, body.GetAngle());		}				/**		The x location of the rigid body.		*/		public function set x(val:Number):void{			loc = body.GetPosition();			loc.x = val;			body.SetPositionAndAngle(loc, body.GetAngle());		}		public function get x():Number{			return body.GetPosition().x;		}				/**		The y location of the rigid body.		*/		public function set y(val:Number):void{			loc = body.GetPosition();			loc.y = val;			body.SetPositionAndAngle(loc, body.GetAngle());		}				public function get y():Number{			return body.GetPosition().y;		}				/**		The angle of the rigid body.		*/		public function set angle(val:Number):void{			loc = body.GetPosition();			body.SetPositionAndAngle(loc, val);		}		public function get angle():Number{			return body.GetAngle();		}				/**	    @exclude		*/		public function BaseObject(qbox:EasyBox2D, params:Object=null) {			init(qbox, params);		}        // template method		private final function init(ebox:EasyBox2D, params:Object=null):void {			this.ebox = ebox;						this.params=params;			//            defineDefaults();//			setDefaults();////            // make sure we aren't a joint//            if (params.vecA == null){//			  setupBodyDef(params);////			}			this.w  = ebox.w;						// template hook			 build();//			 if (!ebox.debug){//				   if (userData is DisplayObject){//					 userData.x = params.x * 30;//					 userData.y = params.y * 30;//					 userData.rotation = params.angle / Math.PI * 180;//				     ebox.nativeContainer.addChild(userData);//				   }//			  }			 			 // make sure we aren't a joint//			 if (body != null){//				if (params.mass != null){//					body.ResetMassData()//					var m:b2MassData = new b2MassData();//					m.mass = params.mass;//					m.center = body.GetLocalCenter();//					body.SetMassData(m);//				}else{//					body.ResetMassData();//				}//			 }		}        public function handCursor():void{		    if (!ebox.debug){				   if (userData is DisplayObject){					 if (params.draggable == true && params.density != 0){						 userData.buttonMode = true; 					}				   }		    }		}		        // all bodyDefs are initialized the same way        private function setupBodyDef(p:Object):void{			_bodyDef = new b2BodyDef();			if (!(p.skin is DisplayObject)){				_bodyDef.position.x = p.x;				_bodyDef.position.y = p.y;				_bodyDef.angle = p.angle;			}else{				_bodyDef.position.x = p.skin.x / 30;				_bodyDef.position.y = p.skin.y / 30;				_bodyDef.angle = p.skin.rotation * Math.PI/180;			}			loc = new b2Vec2(p.x, p.y);						_bodyDef.linearDamping = p.linearDamping;			_bodyDef.angularDamping = p.angularDamping;			_bodyDef.fixedRotation = p.fixedRotation;			_bodyDef.bullet = p.isBullet;			_bodyDef.awake = !p.isSleeping;			_bodyDef.allowSleep = p.allowSleep;		}		        private function defineDefaults():void{			defaults = {x:3, y:3, linearDamping:0, angularDamping:0, isBullet:false,			                   fixedRotation:false,							   allowSleep: true, 							   isSleeping:false, 							   scaleSkin:true,		                       density:1.0, friction:0.5, restitution:0.2, angle:0.0, 							   maskBits:0xFFFF, categoryBits:1, groupIndex:0,							   draggable: true,						       lineColor:0x000000, lineAlpha:1,							   lineThickness:0,						       fillColor:0xCCCCCC, fillAlpha:1} 						// template hook			defaultParams(defaults);									// set any parameters that are default for the QuickBox2D instance			ebox.defaultParams(params);		}           // hook for Object Specific params		protected function defaultParams(p:Object):void{}				// hook for box2D initialization		protected function build():void {			trace("You must override the build() method of QuickObject");		}						 		/**		Destroys all composed Box2D instances (b2Shape, b2Body, b2Joint) and removes the DisplayObject associated with this QuickObject instance (if there is one). QuickObjects will only truly be destroyed at the end of the QuickBox2D internal loop - allowing for you to call this method inside of contact event listener functions.		*/		public final function destroy():void{		  		   ebox.destroyable.push(this);		}				/**	    @exclude		*/		public final function fullDestroy():void{			if (userData is DisplayObject){				if (userData.parent){					userData.parent.removeChild(userData);				}			}			if (joint){				w.DestroyJoint(joint as b2Joint);				return;			}						w.DestroyBody(body);					}		private function setDefaults():void {			if (params==null) {				params = new Object();			}			for (var key:String in defaults) {				if (params[key]==null) {					params[key]=defaults[key];				}			}		}	}}