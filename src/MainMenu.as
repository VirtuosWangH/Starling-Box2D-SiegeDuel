package
{
    import flash.utils.getQualifiedClassName;
    
    import model.DataManager;
    
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    
    import view.scenes.AnimationScene;
    import view.scenes.BenchmarkScene;
    import view.scenes.BlendModeScene;
    import view.scenes.BuildScene;
    import view.scenes.CustomHitTestScene;
    import view.scenes.FilterScene;
    import view.scenes.MovieScene;
    import view.scenes.RenderTextureScene;
    import view.scenes.TextScene;
    import view.scenes.TextureScene;
    import view.scenes.TouchScene;

    public class MainMenu extends Sprite
    {
        public function MainMenu()
        {
            init();
        }

        private function init():void
        {            
            var scenesToCreate:Array = [
				["BuildScene", BuildScene],
//                ["Textures", TextureScene],
//                ["Multitouch", TouchScene],
//                ["TextFields", TextScene],
//                ["Animations", AnimationScene],
//                ["Custom hit-test", CustomHitTestScene],
//                ["Movie Clip", MovieScene],
//                ["Filters", FilterScene],
//                ["Blend Modes", BlendModeScene],
                ["Render Texture", RenderTextureScene],
                ["Benchmark", BenchmarkScene]
            ];
            
            var buttonTexture:Texture = SiegeDuel.assets.getTexture("button_big");
            var count:int = 0;
            
            for each (var sceneToCreate:Array in scenesToCreate)
            {
                var sceneTitle:String = sceneToCreate[0];
                var sceneClass:Class  = sceneToCreate[1];
                
                var button:Button = new Button(buttonTexture, sceneTitle);             
                button.y = count * 52;
                button.name = getQualifiedClassName(sceneClass);
				
                addChild(button);
                ++count;
            }

			var dataManager:DataManager = DataManager.getInstance();
		}
        private function onInfoTextTouched(event:TouchEvent):void
        {
            if (event.getTouch(this, TouchPhase.ENDED))
                Starling.current.showStats = !Starling.current.showStats;
        }
    }
}