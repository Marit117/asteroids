module CollisionPlayer where
import Model
import Constants
import Vector(vectorCollision, vectorScale)
import CollisionAsteroid (collisionAsteroid)

playerAllCollision :: [Asteroid] -> [Bullet] -> [Ufo] -> Player -> Bool
playerAllCollision as bs us p = playerBullet bs p || playerAsteroid as p || playerUfo us p

playerBullet :: [Bullet] -> Player -> Bool
playerBullet bs p = any (\b -> vectorCollision (position (locationBullet b)) (position (locationPlayer p)) bulletPlayerRadius) bs

playerAsteroid :: [Asteroid] -> Player -> Bool
playerAsteroid as p = any (collisionAsteroid (position (locationPlayer p))) as

playerUfo :: [Ufo] -> Player -> Bool
playerUfo us p = any (\ufo -> vectorCollision (position (locationUfo ufo)) (position (locationPlayer p)) ufoPlayerRadius) us