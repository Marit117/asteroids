module DeadAsteroid where
import Model
import Constants

updateDeadAsteroid :: Time -> [DeadAsteroid] -> [DeadAsteroid]
updateDeadAsteroid secs da = deadAsteroidEnd $ deadAsteroidTimeUpdate secs da

deadAsteroidEnd :: [DeadAsteroid] -> [DeadAsteroid]
deadAsteroidEnd = filter (\da -> timeSinceDeath da < asteroidScaleSmall)

deadAsteroidTimeUpdate :: Time -> [DeadAsteroid] -> [DeadAsteroid]
deadAsteroidTimeUpdate secs = map (\da -> da {timeSinceDeath = timeSinceDeath da + secs})