module DeadAsteroid where
import Model
import Constants

updateDeadAsteroid :: Float -> [DeadAsteroid] -> [DeadAsteroid]
updateDeadAsteroid secs da = deadAsteroidEnd $ deadAsteroidTimeUpdate secs da

deadAsteroidEnd :: [DeadAsteroid] -> [DeadAsteroid]
deadAsteroidEnd = filter (\da -> timeSinceDeath da < 0.75)

deadAsteroidTimeUpdate :: Float -> [DeadAsteroid] -> [DeadAsteroid]
deadAsteroidTimeUpdate secs = map (\da -> da {timeSinceDeath = timeSinceDeath da + secs})