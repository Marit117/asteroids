module ViewGamestate where
import Graphics.Gloss
import Model
import Constants
import Vector (vectorScale)

viewGstate :: GameState -> Picture
viewGstate gstate = Pictures [viewScore (score gstate), viewLives (player gstate), viewPlayer (player gstate), Pictures (viewBullets (bullets gstate)), 
                              Pictures (viewAsteroids (asteroids gstate)), Pictures (viewDeadAsteroids (deadAsteroids gstate)), Pictures (viewUfo (ufos gstate))]

viewLives :: Player -> Picture
viewLives p = positionLives $ smallerText $ color white $ Text ("Lives: " ++ show (lives p))

viewScore :: Int -> Picture
viewScore score = positionScore $ smallerText $ color white $ Text ("Score: " ++ show score)

viewPlayer :: Player -> Picture
viewPlayer p = uncurry translate (position (locationPlayer p)) $ rotate (angle p) $ color white $ Polygon playerOutline

viewBullets :: [Bullet] -> [Picture]
viewBullets = map (\bullet -> uncurry translate (position (locationBullet bullet)) $ color white $ circleSolid bulletSize)

viewAsteroids :: [Asteroid] -> [Picture]
viewAsteroids = map (\asteroid -> uncurry translate (position (locationAsteroid asteroid)) $ color white $ asteroidLine asteroid)
    where
        adjustSize n = map (`vectorScale` n) asteroidOutline
        asteroidLine asteroid = case size asteroid of
                                Small  -> Line (adjustSize asteroidScaleSmall)
                                Medium -> Line (adjustSize asteroidScaleMedium)
                                Large  -> Line (adjustSize asteroidScaleLarge)

viewDeadAsteroids :: [DeadAsteroid] -> [Picture]
viewDeadAsteroids = map (\asteroid -> uncurry translate (deathPosition asteroid) $ color white $ Line (adjustSize asteroid))
    where
        adjustSize da = map (`vectorScale` (asteroidScaleSmall - timeSinceDeath da)) asteroidOutline

viewUfo :: [Ufo] -> [Picture]
viewUfo = map (\ufo -> uncurry translate (position (locationUfo ufo)) $ color white $ Line ufoOutline)