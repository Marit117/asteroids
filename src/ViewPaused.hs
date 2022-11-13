module ViewPaused where
import Graphics.Gloss
import Model
import Constants (smallerText, largerText, positionPaused, positionPressEsc)

viewPausedState :: GameState -> Picture
viewPausedState gstate = Pictures [viewPaused, viewPressEsc]

viewPaused :: Picture
viewPaused = positionPaused $ largerText $ color white $ Text "Paused"

viewPressEsc :: Picture
viewPressEsc = positionPressEsc $ smallerText $ color white $ Text "(press 'Esc' to continue the game)"