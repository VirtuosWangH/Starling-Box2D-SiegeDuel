package view.scenes
{
    import starling.display.Button;
    import starling.display.Sprite;
    
    public class Scene extends Sprite
    {
        private var mBackButton:Button;
        
        public function Scene()
        {
            // the main menu listens for TRIGGERED events, so we just need to add the button.
            // (the event will bubble up when it's dispatched.)
            
            mBackButton = new Button(SiegeDuel.assets.getTexture("button_back"), "Back");
            mBackButton.x = 0;
            mBackButton.y = SDContext.stageHeight - mBackButton.height + 1;
            mBackButton.name = "backButton";
            addChild(mBackButton);
        }
    }
}