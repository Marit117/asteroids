-- | This module defines how to turn
--   the game state into a picture
module View where
import Graphics.Gloss
import Model
import ViewGamestate (viewGstate)
import ViewPaused (viewPausedState)
import ViewGameOver (viewGameOverState)

view :: GameState -> IO Picture
view = return . viewPure

viewPure :: GameState -> Picture
viewPure gstate = case viewState gstate of
                  Game     -> viewGstate gstate
                  Paused   -> viewPausedState gstate
                  GameOver -> viewGameOverState gstate
                  