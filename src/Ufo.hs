module Ufo where
import Model
import Constants
import Update (updatePosition)
import System.Random (StdGen, Random (randomR))
import Vector (rotate, vectorAdd, vectorSubstract, vectorScale, vectorLength)

-- Ufo Movement
moveUfo :: Time -> [Ufo] -> [Ufo]
moveUfo secs = map (\ufo -> ufo { locationUfo = updatePosition (locationUfo ufo) secs})

-- Ufo added with random direction, speed and aim
ufoRandom :: StdGen ->  (Ufo, StdGen)
ufoRandom r1 = (Ufo {aim = rAim, timeSinceShot = resetTime, locationUfo = LocationData { velocity = vel, position = pos }}, r4)
    where
        vel                = rotate (0, speed) rot
        pos                = (halfScreen, posy)
        (posy, r3)         = randomR screenSize r2
        (rAim, r4)         = ufoRandomAim r3
        ((rot, speed), r2) = randomR (randomRotation, randomSpeed) r1

ufoRandomAim :: StdGen -> (Aim, StdGen)
ufoRandomAim r | n >= chancePlayerAim = (PlayerAim, newr)
               | otherwise            = (FrontAim, newr)
    where
        n :: Int
        (n, newr) = randomR randomChance r

-- Ufo shoots every few seconds
ufoUpdateTime :: Time -> [Ufo] -> [Ufo]
ufoUpdateTime secs = map (\ufo -> ufo{ timeSinceShot = timeSinceShot ufo + secs})

ufosShoot :: Player -> [Bullet] -> [Ufo] -> ([Ufo], [Bullet])
ufosShoot p bs us = (newUfo, concat addBullet ++ bs)
    where
        (newUfo, addBullet) = unzip $ map (shoot p) us

shoot :: Player -> Ufo -> (Ufo, [Bullet])
shoot p ufo | timeSinceShot ufo > shootSpeed = (ufo {timeSinceShot = resetTime}, [Bullet (LocationData vel pos) ufoBulletLifeTime])
            | otherwise                      = (ufo, [])
    where
        vel       = vectorAdd (vectorScale direction bulletSpeed) (velocity (locationUfo ufo))
        pos       = vectorAdd (vectorScale direction bulletStartPosition) (position (locationUfo ufo))
        direction = ufoShootDirection ufo p

ufoShootDirection :: Ufo -> Player -> Vector
ufoShootDirection ufo p = vectorScale direction (1 / vectorLength direction)
    where
        directionFront  = vectorSubstract (position (locationUfo ufo)) (vectorSubstract (position (locationUfo ufo)) (velocity (locationUfo ufo)))
        directionPlayer = vectorSubstract (position (locationPlayer p)) (position (locationUfo ufo))
        direction = case aim ufo of
                    FrontAim  -> directionFront
                    PlayerAim -> directionPlayer