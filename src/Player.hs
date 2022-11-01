module Player where
import LocationData (LocationData (LocationData, velocity))
import Vector ( Vector, rotate, vectorScale, vectorAdd)
import Update (updatePosition, updateVelocity)
import Graphics.Gloss.Interface.IO.Game (Key)
import Data.Set ( Set, empty, member, insert, delete )
import Graphics.Gloss.Interface.IO.Interact (Key(Char))
{-
data LocationData = LocationData { velocity :: (Float, Float),
                                   position :: (Float, Float)
                                 }
-}

data Player = Player { lives          :: Int,
                       angle          :: Float,
                       direction      :: Vector,
                       locationPlayer :: LocationData
                     }

-- move player
setVelocity :: Set Key -> Float -> Player -> Player
setVelocity keys secs p = p {locationPlayer = updateVelocity (locationPlayer p) (vectorAdd (velocity (locationPlayer p)) (vectorScale (direction p) ((keyW + keyS) * secs) ))}
    where
        keyW | member (Char 'w') keys =  100 | otherwise = 0
        keyS | member (Char 's') keys = -100 | otherwise = 0

setDirection :: Set Key -> Float -> Player -> Player
setDirection keys secs p = p {direction = rotate (direction p) anglen, angle = angle p - anglen}
    where
        anglen = (keyA + keyD) * secs
        keyA | member (Char 'a') keys =  180 | otherwise = 0
        keyD | member (Char 'd') keys = -180 | otherwise = 0

friction :: Float -> Player -> Player
friction secs p = p {locationPlayer = updateVelocity (locationPlayer p) (vectorScale (velocity (locationPlayer p)) (0.6 ** secs))}

movePlayer :: Player -> Float -> Player
movePlayer p secs = p { locationPlayer = updatePosition (locationPlayer p) secs}