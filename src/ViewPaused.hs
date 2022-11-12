module ViewPaused where
import Graphics.Gloss
import Model

viewPausedState :: GameState -> Picture
viewPausedState gstate = Pictures [viewPaused, viewPressEsc]

viewPaused :: Picture
viewPaused = translate (-150) 0 $ scale 0.75 0.75 $ color white $ Text "Paused"

viewPressEsc :: Picture
viewPressEsc = translate (-225) (-50) $ scale 0.2 0.2 $ color white $ Text "(press 'Esc' to continue the game)"