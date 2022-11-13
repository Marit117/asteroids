module Enemy where
import Asteroid ( asteroidRandom )
import Ufo ( ufoRandom )
import Model
import Constants
import System.Random (StdGen, Random (randomR))

-- after a few seconds, add a random enemy to the game
addEnemy :: Float -> StdGen -> Time -> ([Asteroid], [Ufo], Float) -> ([Asteroid], [Ufo], Float, StdGen)
addEnemy elapsedTime r secs (as, us, timeEnemy) | (secs + timeEnemy) > timeAddEnemy = chooseEnemy (randomR randomChance r) elapsedTime (as, us)
                                    | otherwise                                     = (as, us, secs + timeEnemy, r)

chooseEnemy :: (Int, StdGen) -> Float -> ([Asteroid], [Ufo]) -> ([Asteroid], [Ufo], Time, StdGen)
chooseEnemy (number, r) elapsedTime (as, us) | number <= calculateChance elapsedTime 
                                               && elapsedTime > timeBeforeUfo = (as, newUfo : us, resetTime, newru)         --  chance for an ufo (chance grows after time passes, will not go higher than the maximum chance)
                                             | otherwise                      = (newAsteroid : as, us, resetTime, newra)    --  chance for an asteroid
    where
        (newUfo, newru)      = ufoRandom r
        (newAsteroid, newra) = asteroidRandom r


--calculateChance elapsedTime
calculateChance :: Float -> Int
calculateChance elapsedTime = min chanceUfoMax (round (elapsedTime / decreaseChanceSpeed))