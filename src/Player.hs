module Player where
import Model
import Constants
import Vector ( rotate, vectorScale, vectorAdd)
import Update (updatePosition, updateVelocity)
import Data.Set ( Set, empty, member, insert, delete )
import Graphics.Gloss.Interface.IO.Interact (Key(Char))

-- Player Movement
updatePlayerMovement :: Set Key -> Float -> Player -> Player
updatePlayerMovement keys secs p = friction secs $ setDirection keys secs $ setVelocity keys secs $ movePlayer p secs

movePlayer :: Player -> Float -> Player
movePlayer p secs = p { locationPlayer = updatePosition (locationPlayer p) secs}

setVelocity :: Set Key -> Float -> Player -> Player
setVelocity keys secs p = p {locationPlayer = updateVelocity (locationPlayer p) (vectorAdd (velocity (locationPlayer p)) (vectorScale (direction p) ((keyW + keyS) * secs) ))}
    where
        keyW | member (Char 'w') keys =  playerSpeed | otherwise = playerMinSpeed
        keyS | member (Char 's') keys = -playerSpeed | otherwise = playerMinSpeed

setDirection :: Set Key -> Float -> Player -> Player
setDirection keys secs p = p {direction = rotate (direction p) anglen, angle = angle p - anglen}
    where
        anglen = (keyA + keyD) * secs
        keyA | member (Char 'a') keys =  playerRotationSpeed | otherwise = playerMinRotationSpeed
        keyD | member (Char 'd') keys = -playerRotationSpeed | otherwise = playerMinRotationSpeed

friction :: Float -> Player -> Player
friction secs p = p {locationPlayer = updateVelocity (locationPlayer p) (vectorScale (velocity (locationPlayer p)) (playerFriction ** secs))}

-- Player Lives
updatePlayerLives :: Bool -> Bool -> Player -> Player
updatePlayerLives collBullet collAsteroid p | (collBullet || collAsteroid) && timeSinceHit p > playerCooldown = playerRespawn p
                                            | otherwise = p

playerRespawn :: Player -> Player
playerRespawn p = p { lives = lives p - 1, timeSinceHit = 0, angle = 0, direction = (0, 1), locationPlayer = (LocationData {velocity = (0,0), position = (0,0)}) }

updateTimeSinceHit :: Float -> Player -> Player
updateTimeSinceHit secs p = p {timeSinceHit = timeSinceHit p + secs}

playerDie :: GameState -> ViewState
playerDie gstate | lives (player gstate) < playerMinLives = GameOver
                 | otherwise = viewState gstate