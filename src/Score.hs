module Score where
import Model

scoreAsteroids :: [Asteroid] -> Score
scoreAsteroids = foldr score 0 
    where
        score asteroid r = case size asteroid of
                        Small  -> 100 + r
                        Medium -> 50  + r
                        Large  -> 25  + r

scoreUfo :: [Ufo] -> [Ufo] -> Score
scoreUfo us1 us2 = abs (length us1 - length us2) * 200