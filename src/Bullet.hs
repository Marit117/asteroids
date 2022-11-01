module Bullet where
import LocationData (LocationData(LocationData, position, velocity))
import Update (updatePosition, updateVelocity)
import Player (Player(..), locationPlayer)
import Vector (vectorScale, vectorAdd)

data Bullet = Bullet { locationBullet :: LocationData,
                       lifeTime       :: Float
                     }

updateBullets :: Float -> [Bullet] -> [Bullet]
updateBullets secs bs = updateLifetime secs (moveBullets secs (removeBullet bs))

moveBullets :: Float -> [Bullet] -> [Bullet]
moveBullets secs = map (\b -> b { locationBullet = updatePosition (locationBullet b) secs})

updateLifetime :: Float -> [Bullet] -> [Bullet]
updateLifetime secs = map (\b -> b { lifeTime = lifeTime b - secs})

addBullet :: Player -> [Bullet] -> [Bullet]
addBullet p bs  = Bullet (LocationData vel pos ) 5 : bs
    where
        vel = vectorAdd (vectorScale (direction p) 200) (velocity (locationPlayer p))
        pos = vectorAdd (position (locationPlayer p)) (vectorScale (direction p) 10)

removeBullet :: [Bullet] -> [Bullet]
removeBullet = filter alive
    where
        alive bullet = lifeTime bullet > 0