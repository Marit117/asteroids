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
        alive = filter ( \a -> not $ any (\b -> collisionAsteroid (position (locationBullet b)) asteroidBulletRadius a) bs) as
        hit   = filter ( \a ->       any (\b -> collisionAsteroid (position (locationBullet b)) asteroidBulletRadius a) bs) as

asteroidUfo :: [Ufo] -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid])
asteroidUfo us (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( \a -> not $ any (\ufo -> collisionAsteroid (position (locationUfo ufo)) asteroidUfoRadius a) us) as
        hit   = filter ( \a ->       any (\ufo -> collisionAsteroid (position (locationUfo ufo)) asteroidUfoRadius a) us) as

asteroidPlayer :: Player -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid])
asteroidPlayer p (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( not . collisionAsteroid (position (locationPlayer p)) asteroidPlayerRadius) as
        hit   = filter (       collisionAsteroid (position (locationPlayer p)) asteroidPlayerRadius) as

collisionAsteroid :: Vector -> Float -> Asteroid -> Bool
collisionAsteroid v radiusObject a = vectorCollision v (position (locationAsteroid a)) n
    where
        n = case size a of -- different size asteroids should have a different radius for collision
          Small  -> asteroidSmallRadius + radiusObject
          Medium -> asteroidMediumRadius + radiusObject
          Large  -> asteroidLargeRadius + radiusObject