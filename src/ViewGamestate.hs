module ViewGamestate where
import Graphics.Gloss
import Model
import Constants
import Vector (vectorScale)

viewGstate :: GameState -> Picture
viewGstate gstate = Pictures [viewLives (player gstate), viewPlayer (player gstate), Pictures (viewBullets (bullets gstate)), Pictures (viewAsteroids (asteroids gstate)), Pictures (viewDeadAsteroids (deadAsteroids gstate))]

viewLives :: Player -> Picture
viewLives p = translate (-375) 350 $ scale 0.2 0.2 $ color white $ Text ("Lives: " ++ show (lives p))

viewPlayer :: Player -> Picture
viewPlayer p = uncurry translate (position (locationPlayer p)) $ rotate (angle p) $ color white $ Polygon [(0, 20), (20, -10), (0, 0), (-20, -10)]

viewBullets :: [Bullet] -> [Picture]
viewBullets = map (\bullet -> uncurry translate (position (locationBullet bullet)) $ color white $ circleSolid 3)

viewAsteroids :: [Asteroid] -> [Picture]
viewAsteroids = map (\asteroid -> uncurry translate (position (locationAsteroid asteroid)) $ color white $ asteroidLine asteroid)
    where
        adjustSize n = map (`vectorScale` n) asteroidOutline
        asteroidLine asteroid = case size asteroid of
                                Small  -> Line (adjustSize 0.75)
                                Medium -> Line (adjustSize 1)
                                Large  -> Line (adjustSize 1.5)

viewDeadAsteroids :: [DeadAsteroid] -> [Picture]
viewDeadAsteroids = map (\asteroid -> uncurry translate (deathPosition asteroid) $ color white $ Line (adjustSize asteroid))
    where
        adjustSize da = map (`vectorScale` (0.75 - timeSinceDeath da)) asteroidOutline