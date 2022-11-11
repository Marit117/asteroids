-- | This module defines how to turn
--   the game state into a picture
module View where

import Graphics.Gloss
import Model
import Player (Player (..))
import LocationData (LocationData(..))
import Bullet (Bullet(..))
import Asteroid (Asteroid (locationAsteroid, size), AsteroidSize (..))
import Vector (vectorScale)

view :: GameState -> IO Picture
view = return . viewPure

viewPure :: GameState -> Picture
viewPure gstate = Pictures [viewLives (player gstate), viewPlayer (player gstate), Pictures (viewBullets (bullets gstate)), Pictures (viewAsteroids (asteroids gstate))]

viewLives :: Player -> Picture
viewLives p = translate (-375) 350 $ scale 0.2 0.2 $ color white $ Text ("Lives: " ++ show (lives p))

viewPlayer :: Player -> Picture
viewPlayer p = uncurry translate (position (locationPlayer p)) $ rotate (angle p) $ color white $ Polygon [(0, 20), (20, -10), (0, 0), (-20, -10)]

viewBullets :: [Bullet] -> [Picture]
viewBullets = map (\bullet -> uncurry translate (position (locationBullet bullet)) $ color white $ circleSolid 3)

viewAsteroids :: [Asteroid] -> [Picture]
viewAsteroids = map (\asteroid -> uncurry translate (position (locationAsteroid asteroid)) $ color white $ asteroidPoly asteroid)
    where
        adjustPoly n = map (`vectorScale` n) [(-10,20), (10,15), (0,5), (10,0), (15,-10), (0,-20), (-20,-10), (-20,10)]
        asteroidPoly asteroid = case size asteroid of
                                Small -> Polygon (adjustPoly 0.75)
                                Medium -> Polygon (adjustPoly 1)
                                Large -> Polygon (adjustPoly 1.5)
