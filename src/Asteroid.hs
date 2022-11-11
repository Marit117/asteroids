module Asteroid where
import LocationData (LocationData (LocationData, velocity, position))
import System.Random (StdGen, Random (randomR))
import Vector(Vector, rotate, vectorCollision, vectorScale)
import Update (updatePosition)
import Bullet (Bullet (locationBullet))

data Asteroid = Asteroid { size             :: AsteroidSize,
                           locationAsteroid :: LocationData
                         }

data AsteroidSize = Small | Medium | Large
    deriving (Eq, Ord, Enum)
    --pred large = medium

updateAsteroid :: StdGen -> Float -> Float -> [Asteroid] -> ([Asteroid], Float, StdGen)
updateAsteroid r secs timeEnemy as = addAsteroid r secs (moveAsteroid secs as, timeEnemy)

moveAsteroid :: Float -> [Asteroid] -> [Asteroid]
moveAsteroid secs = map (\a -> a { locationAsteroid = updatePosition (locationAsteroid a) secs})

addAsteroid :: StdGen -> Float -> ([Asteroid], Float) -> ([Asteroid], Float, StdGen)
addAsteroid r secs (as, timeEnemy) | (secs + timeEnemy) > 5 = (newa : as, 0, newr)
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

killAsteroid :: [Asteroid] -> [Asteroid]
killAsteroid [] = []
killAsteroid (a:as) | size a > Small =
                        Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) 0.5}} :
                        Asteroid {size = pred (size a), locationAsteroid = (locationAsteroid a) {velocity = vectorScale (velocity (locationAsteroid a)) 1.25}} : killAsteroid as
                    | otherwise = killAsteroid as