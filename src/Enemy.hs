module Enemy where
import Asteroid ( asteroidRandom )
import Ufo ( ufoRandom )
import Model
import Constants
import System.Random (StdGen, Random (randomR))

-- after a few seconds, add a random enemy to the game
addEnemy :: StdGen -> Time -> ([Asteroid], [Ufo], Float) -> ([Asteroid], [Ufo], Float, StdGen)
addEnemy r secs (as, us, timeEnemy) | (secs + timeEnemy) > 5 = chooseEnemy (randomR (1, 100) r) secs (as, us)
                                    | otherwise = (as, us, secs + timeEnemy, r)

chooseEnemy :: (Int, StdGen) -> Time -> ([Asteroid], [Ufo]) -> ([Asteroid], [Ufo], Time, StdGen)
chooseEnemy (number, r) secs (as, us) | number <= 20  = (as, newUfo : us, 0, newru)         -- 20% chance for an ufo
                                      | otherwise     = (newAsteroid : as, us, 0, newra)    -- 80% chance for an asteroid
    where
        (newUfo, newru)      = ufoRandom r
        (newAsteroid, newra) = asteroidRandom r