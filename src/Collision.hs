module Collision where
import Bullet (Bullet (locationBullet))
import Asteroid (Asteroid (Asteroid, locationAsteroid, size), AsteroidSize(..), killAsteroid)
import Vector(Vector, vectorCollision, vectorScale)
import LocationData (LocationData (position, velocity))
import Player (Player(locationPlayer, lives))


-- collision for asteroids
asteroidBullet :: [Bullet] -> [Asteroid] -> [Asteroid]
asteroidBullet bs as = alive ++ killAsteroid dead
    where
        alive = filter ( \a -> not $ any (`asteroidCollision` a) bs) as
        dead  = filter ( \a -> any (`asteroidCollision` a) bs) as

asteroidCollision :: Bullet -> Asteroid -> Bool
asteroidCollision b a = vectorCollision (position (locationBullet b)) (position (locationAsteroid a))

asteroidPlayer :: Player -> [Asteroid] -> [Asteroid]
asteroidPlayer p as = alive ++ killAsteroid dead
    where
        alive = filter ( \a -> not $ vectorCollision (position (locationAsteroid a)) (position (locationPlayer p))) as
        dead  = filter ( \a -> vectorCollision (position (locationAsteroid a)) (position (locationPlayer p))) as

-- collision for bullets
bulletAsteroid :: [Asteroid] -> [Bullet] -> [Bullet]
bulletAsteroid as = filter ( \b -> not $ any (`bulletCollision` b) as)

bulletCollision :: Asteroid -> Bullet -> Bool
bulletCollision a b = vectorCollision (position (locationBullet b)) (position (locationAsteroid a))

bulletPlayer :: Player -> [Bullet] -> [Bullet]
bulletPlayer p = filter (\b -> not $ vectorCollision (position (locationBullet b)) (position (locationPlayer p)))

-- collision for player
playerBullet :: [Bullet] -> Player -> Bool
playerBullet bs p = any (\b -> vectorCollision (position (locationBullet b)) (position (locationPlayer p))) bs

playerAsteroid :: [Asteroid] -> Player -> Bool
playerAsteroid as p = any (\a -> vectorCollision (position (locationAsteroid a)) (position (locationPlayer p))) as