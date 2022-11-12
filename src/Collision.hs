module Collision where
import Model
import Constants
import Asteroid (killAsteroid)
import Vector(vectorCollision, vectorScale)
import Score (scoreAsteroids)

-- collision for asteroids
asteroidBullet :: [Bullet] -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid], Score)
asteroidBullet bs (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids, scoreAsteroids hit)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( \a -> not $ any (\b -> collisionAsteroid (position (locationBullet b)) a) bs) as
        hit   = filter ( \a -> any (\b -> collisionAsteroid (position (locationBullet b)) a) bs) as

asteroidPlayer :: Player -> ([Asteroid], [DeadAsteroid]) -> ([Asteroid], [DeadAsteroid])
asteroidPlayer p (as, das) = (alive ++ smallerAsteroids, das ++ deadAsteroids)
    where
        (smallerAsteroids, deadAsteroids) = killAsteroid hit
        alive = filter ( not . collisionAsteroid (position (locationPlayer p))) as
        hit   = filter ( collisionAsteroid (position (locationPlayer p))) as

collisionAsteroid :: Vector -> Asteroid -> Bool
collisionAsteroid v a = vectorCollision v (position (locationAsteroid a)) n
    where
        n = case size a of -- different size asteroids should have a different radius for collision
          Small  -> asteroidSmallCollision
          Medium -> asteroidMediumCollision
          Large  -> asteroidLargeCollision

-- collision for bullets
bulletAsteroid :: [Asteroid] -> [Bullet] -> [Bullet]
bulletAsteroid as = filter ( \b -> not $ any (collisionAsteroid (position (locationBullet b))) as)

bulletPlayer :: Player -> [Bullet] -> [Bullet]
bulletPlayer p = filter (\b -> not $ vectorCollision (position (locationBullet b)) (position (locationPlayer p)) bulletPlayerCollision)

-- collision for player
playerBullet :: [Bullet] -> Player -> Bool
playerBullet bs p = any (\b -> vectorCollision (position (locationBullet b)) (position (locationPlayer p)) bulletPlayerCollision) bs

playerAsteroid :: [Asteroid] -> Player -> Bool
playerAsteroid as p = any (collisionAsteroid (position (locationPlayer p))) as