module ViewPaused where
import Graphics.Gloss
import Model
import Constants (smallerText, largerText)

viewPausedState :: GameState -> Picture
viewPausedState gstate = Pictures [viewPaused, viewPressEsc]

viewPaused :: Picture
viewPaused = translate (-150) 0 $ largerText $ color white $ Text "Paused"

viewPressEsc :: Picture
viewPressEsc = translate (-225) (-50) $ smallerText $ color white $ Text "(press 'Esc' to continue the game)"