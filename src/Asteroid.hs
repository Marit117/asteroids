module Asteroid where
import Model
import Constants
import System.Random (StdGen, Random (randomR))
import Vector(rotate, vectorScale)
import Update (updatePosition)

-- Asteroid Movement
moveAsteroid :: Float -> [Asteroid] -> [Asteroid]
moveAsteroid secs = map (\a -> a { locationAsteroid = updatePosition (locationAsteroid a) secs})

-- Asteroid added with random direction and speed
asteroidRandom :: StdGen ->  (Asteroid, StdGen)
asteroidRandom r1 = (Asteroid {size = Large, locationAsteroid = LocationData { velocity = vel, position = pos }}, r3)
    where
        vel                = rotate (0, speed) rot
        pos                = (posx, 400)
        (posx, r3)         = randomR (-400, 400) r2
        ((rot, speed), r2) = randomR ((0,20), (360,100)) r1

-- Asteroids that are hit break into two smaller asteroids
-- if they cannot go smaller, the asteroid dies
killAsteroid :: [Asteroid] -> ([Asteroid], [DeadAsteroid])
killAsteroid [] = ([], [])
killAsteroid (a:as) | size a > Small = let (alive, dead) = killAsteroid as in
                        (Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) newAsteroidSpeedLow}} :
                         Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) newAsteroidSpeedHigh}} : 
                         alive, dead)
                    | otherwise = let (alive, dead) = killAsteroid as in (alive, DeadAsteroid {deathPosition = position (locationAsteroid a), timeSinceDeath = 0} : dead)