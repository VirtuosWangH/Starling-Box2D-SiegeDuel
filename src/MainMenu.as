package
{
    import flash.utils.getQualifiedClassName;
    
    import scenes.AnimationScene;
    import scenes.BenchmarkScene;
    import scenes.BlendModeScene;
    import scenes.CustomHitTestScene;
    import scenes.FilterScene;
    import scenes.MovieScene;
    import scenes.RenderTextureScene;
    import scenes.TextScene;
    import scenes.TextureScene;
    import scenes.TouchScene;
    
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.VAlign;

    public class MainMenu extends Sprite
    {
        public function MainMenu()
        {
            init();
        }
        
        private function init():void
        {            
            var scenesToCreate:Array = [
                ["Textures", TextureScene],
                ["Multitouch", TouchScene],
                ["TextFields", TextScene],
                ["Animations", AnimationScene],
                ["Custom hit-test", CustomHitTestScene],
                ["Movie Clip", MovieScene],
                ["Filters", FilterScene],
                ["Blend Modes", BlendModeScene],
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
        }
        
        private function onInfoTextTouched(event:TouchEvent):void
        {
            if (event.getTouch(this, TouchPhase.ENDED))
                Starling.current.showStats = !Starling.current.showStats;
        }
    }
}