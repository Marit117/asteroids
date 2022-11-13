module CollisionAsteroid where
import Model
import Constants
import Asteroid (killAsteroid)
import Vector(vectorCollision, vectorScale)
import Score (scoreAsteroids)

asteroidBullet :: [Bullet] -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid], Score)
asteroidBullet bs (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids, scoreAsteroids hit)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( \a -> not $ any (\b -> collisionAsteroid (position (locationBullet b)) a) bs) as
        hit   = filter ( \a ->       any (\b -> collisionAsteroid (position (locationBullet b)) a) bs) as

asteroidUfo :: [Ufo] -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid])
asteroidUfo us (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( \a -> not $ any (\ufo -> collisionAsteroid (position (locationUfo ufo)) a) us) as
        hit   = filter ( \a ->       any (\ufo -> collisionAsteroid (position (locationUfo ufo)) a) us) as

asteroidPlayer :: Player -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid])
asteroidPlayer p (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( not . collisionAsteroid (position (locationPlayer p))) as
        hit   = filter (       collisionAsteroid (position (locationPlayer p))) as

collisionAsteroid :: Vector -> Asteroid -> Bool
collisionAsteroid v a = vectorCollision v (position (locationAsteroid a)) n
    where
        n = case size a of -- different size asteroids should have a different radius for collision
          Small  -> asteroidSmallRadius
          Medium -> asteroidMediumRadius
          Large  -> asteroidLargeRadius