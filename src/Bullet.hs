module Bullet where
import Model
import Constants
import Update (updatePosition, updateVelocity)
import Vector (vectorScale, vectorAdd)

updateBullets :: Float -> [Bullet] -> [Bullet]
updateBullets secs bs = updateLifetime secs (moveBullets secs (removeBullet bs))

moveBullets :: Float -> [Bullet] -> [Bullet]
moveBullets secs = map (\b -> b { locationBullet = updatePosition (locationBullet b) secs})

updateLifetime :: Float -> [Bullet] -> [Bullet]
updateLifetime secs = map (\b -> b { lifeTime = lifeTime b - secs})

removeBullet :: [Bullet] -> [Bullet]
removeBullet = filter (\bullet -> lifeTime bullet > bulletTimeDie)

addBullet :: Player -> [Bullet] -> [Bullet]
addBullet p bs  = Bullet (LocationData vel pos ) bulletLifeTime : bs
    where
        vel = vectorAdd (vectorScale (direction p) bulletSpeed) (velocity (locationPlayer p))
        pos = vectorAdd (vectorScale (direction p) bulletStartPosition) (position (locationPlayer p))