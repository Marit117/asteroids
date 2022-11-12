module Score where
import Model

scoreAsteroids :: [Asteroid] -> Score
scoreAsteroids = foldr f 0 
    where
        f asteroid r = case size asteroid of
                        Small  -> 100 + r
                        Medium -> 50  + r
                        Large  -> 25  + r