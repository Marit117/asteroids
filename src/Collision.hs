module Collision where
import Model
import CollisionAsteroid ( asteroidBullet, asteroidUfo, asteroidPlayer )
import CollisionBullet ( bulletAsteroid, bulletPlayer, bulletUfo )
import CollisionPlayer ( playerBullet, playerAsteroid, playerUfo )
import CollisionUfo ( ufoBullet, ufoPlayer, ufoAsteroid )
import Score (scoreUfo)

-- collision for asteroids
asteroidAllCollision :: GameState -> ([Asteroid], [DeadAsteroid], Score)
asteroidAllCollision GameState {player = p, bullets = bs, ufos = us, asteroids = as, deadAsteroids = das} = asteroidBullet bs $ asteroidUfo us $ asteroidPlayer p (as, das)

-- collision for bullets
bulletAllCollision :: [Asteroid] -> [Ufo] -> Player -> [Bullet] -> [Bullet]
bulletAllCollision as us p bs = bulletAsteroid as $ bulletPlayer p $ bulletUfo us bs

-- collision for player
playerAllCollision :: [Asteroid] -> [Bullet] -> [Ufo] -> Player -> Bool
playerAllCollision as bs us p = playerBullet bs p || playerAsteroid as p || playerUfo us p

-- collision for ufo
ufoAllCollision :: [Asteroid] -> [Bullet] -> Player -> [Ufo] -> ([Ufo], Score)
ufoAllCollision as bs p us = (listUfo, score)
    where
        listUfo = ufoBullet bs $ ufoPlayer p $ ufoAsteroid as us
        score   = scoreUfo us listUfo