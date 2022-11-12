module ViewGameOver where
import Graphics.Gloss
import Model

viewGameOverState :: GameState -> Picture
viewGameOverState gstate = viewGameOver

viewGameOver :: Picture
viewGameOver = translate (-200) 0 $ scale 0.5 0.5 $ color white $ Text "Game Over"