module CollisionUfo where
import Model
import Constants
import Vector(vectorCollision, vectorScale)
import CollisionAsteroid (collisionAsteroid)

ufoBullet :: [Bullet] -> [Ufo] -> [Ufo]
ufoBullet bs = filter ( \ufo -> not $ any (\b -> vectorCollision (position (locationBullet b)) (position (locationUfo ufo)) 20) bs)

ufoPlayer :: Player -> [Ufo] -> [Ufo]
ufoPlayer p = filter (\ufo -> not $ vectorCollision (position (locationUfo ufo)) (position (locationPlayer p)) 30)

ufoAsteroid :: [Asteroid] -> [Ufo] -> [Ufo]
ufoAsteroid as = filter ( \ufo -> not $ any (collisionAsteroid (position (locationUfo ufo))) as)