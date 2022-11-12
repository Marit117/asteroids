module Asteroid where
import Model
import Constants
import System.Random (StdGen, Random (randomR))
import Vector(rotate, vectorScale)
import Update (updatePosition)

-- Asteroid Movement
updateAsteroid :: StdGen -> Float -> Time -> [Asteroid] -> ([Asteroid], Float, StdGen)
updateAsteroid r secs timeEnemy as = addAsteroid r secs (moveAsteroid secs as, timeEnemy)

moveAsteroid :: Float -> [Asteroid] -> [Asteroid]
moveAsteroid secs = map (\a -> a { locationAsteroid = updatePosition (locationAsteroid a) secs})

-- Asteroid added every few seconds
addAsteroid :: StdGen -> Time -> ([Asteroid], Float) -> ([Asteroid], Float, StdGen)
addAsteroid r secs (as, timeEnemy) | (secs + timeEnemy) > timeAddAsteroid = (newa : as, 0, newr)
                                   | otherwise = (as, secs + timeEnemy, r)
    where
        (newa, newr) = asteroidRandom r

asteroidRandom :: StdGen ->  (Asteroid, StdGen)
asteroidRandom r1 = (Asteroid {size = Large, locationAsteroid = locdata}, r3)
    where
        locdata  = LocationData { velocity = vel, position = pos }
        vel = rotate (0, speed) rot
        ((rot, speed), r2) = randomR ((0,20), (360,100)) r1
        pos = (posx, 400)
        (posx, r3) = randomR (-400, 400) r2

-- Asteroids that are hit break into two smaller asteroids
-- if they cannot go smaller, they are dead
killAsteroid :: [Asteroid] -> ([Asteroid], [DeadAsteroid])
killAsteroid [] = ([], [])
killAsteroid (a:as) | size a > Small = let (alive, dead) = killAsteroid as in
                        (Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) newAsteroidSpeedLow}} :
                         Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) newAsteroidSpeedHigh}} : 
                         alive, dead)
                    | otherwise = let (alive, dead) = killAsteroid as in (alive, DeadAsteroid {deathPosition = position (locationAsteroid a), timeSinceDeath = 0} : dead)