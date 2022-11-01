-- | This module defines how the state changes
--   in response to time and user input
module Controller where
import Model
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game
import System.Random
import Player (movePlayer, setVelocity, setDirection, friction)
import Bullet (updateBullets, addBullet)
import Asteroid(moveAsteroid, updateAsteroid)
import Data.Set (member, insert, delete)

-- | Handle one iteration of the game
step :: Float -> GameState -> IO GameState
step secs gstate = -- Just update the elapsed time
    return $ stepPure secs gstate

stepPure :: Float -> GameState -> GameState
stepPure secs gstate = gstate { elapsedTime = timeUpdate, player = playerUpdate, bullets = bulletUpdate, asteroids = asteroidUpdate, timeEnemy = updateTime, rand = newr }
    where
        timeUpdate = elapsedTime gstate + secs
        playerUpdate = friction secs $ setDirection (keys gstate) secs $ setVelocity (keys gstate) secs $ movePlayer (player gstate) secs
        bulletUpdate = updateBullets secs (bullets gstate)
        (asteroidUpdate, updateTime, newr) = updateAsteroid (rand gstate) secs (timeEnemy gstate) (asteroids gstate)

-- | Handle user input
input :: Event -> GameState -> IO GameState
input e gstate = return (inputKey e gstate)

inputKey :: Event -> GameState -> GameState
inputKey (EventKey (SpecialKey KeySpace) Down _ _) gstate = gstate {bullets = addBullet (player gstate) (bullets gstate)}
inputKey (EventKey k Down _ _) gstate = gstate {keys = insert k (keys gstate)}
inputKey (EventKey k Up _ _) gstate = gstate {keys = delete k (keys gstate)}
inputKey _ gstate = gstate -- Otherwise keep the same