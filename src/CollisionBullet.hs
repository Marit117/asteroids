module CollisionBullet where
import Model
import Constants
import Vector(vectorCollision, vectorScale)
import CollisionAsteroid (collisionAsteroid)

bulletAllCollision :: [Asteroid] -> [Ufo] -> Player -> [Bullet] -> [Bullet]
bulletAllCollision as us p bs = bulletAsteroid as $ bulletPlayer p $ bulletUfo us bs

bulletAsteroid :: [Asteroid] -> [Bullet] -> [Bullet]
bulletAsteroid as = filter ( \b -> not $ any (collisionAsteroid (position (locationBullet b))) as)

bulletPlayer :: Player -> [Bullet] -> [Bullet]
bulletPlayer p = filter (\b -> not $ vectorCollision (position (locationBullet b)) (position (locationPlayer p)) bulletPlayerCollision)

bulletUfo :: [Ufo] -> [Bullet] -> [Bullet]
bulletUfo us = filter ( \b -> not $ any (\ufo -> vectorCollision (position (locationBullet b)) (position (locationUfo ufo)) 20) us)