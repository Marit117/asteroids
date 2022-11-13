module Score where
import Model
import Constants

scoreAsteroids :: [Asteroid] -> Score
scoreAsteroids = foldr score minPoints 
    where
        score asteroid r = case size asteroid of
                        Small  -> pointsSmallAsteroid + r
                        Medium -> pointsMediumAsteroid  + r
                        Large  -> pointsLargeAsteroid  + r

scoreUfo :: [Ufo] -> [Ufo] -> Score
scoreUfo us1 us2 = abs (length us1 - length us2) * pointsUfo