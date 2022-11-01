-- | This module defines how to turn
--   the game state into a picture
module View where

import Graphics.Gloss
import Model
import Player (Player (..))
import LocationData (LocationData(..))
import Bullet (Bullet(..))
import Asteroid (Asteroid (locationAsteroid))

view :: GameState -> IO Picture
view = return . viewPure

viewPure :: GameState -> Picture
viewPure gstate = Pictures [ viewPlayer (player gstate), Pictures (viewBullet (bullets gstate)), Pictures (viewAsteroid (asteroids gstate))]


-- aaaaaaaaaaaaaa
viewPlayer :: Player -> Picture
viewPlayer p = uncurry translate (position (locationPlayer p)) $ rotate (angle p) $ color white $ Polygon [(0, 20), (20, -10), (0, 0), (-20, -10)]

viewBullet :: [Bullet] -> [Picture]
viewBullet = map (\bullet -> uncurry translate (position (locationBullet bullet)) $ color white $ circleSolid 3)

viewAsteroid :: [Asteroid] -> [Picture]
viewAsteroid = map (\asteroid -> uncurry translate (position (locationAsteroid asteroid)) $ color white $ Polygon [(-10,20), (10,15), (0,5), (10,0), (15,-10), (0,-20), (-20,-10), (-20,10)])