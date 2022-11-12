-- | This module defines how the state changes
--   in response to time and user input
module Controller where
import Model
import Graphics.Gloss ()
import Graphics.Gloss.Interface.IO.Game
import System.Random ()
import Player (updatePlayerMovement, updatePlayerLives, updateTimeSinceHit, playerDie)
import Bullet (updateBullets, addBullet)
import Asteroid(moveAsteroid, updateAsteroid)
import DeadAsteroid (updateDeadAsteroid)
import Data.Set (member, insert, delete)
import Collision

-- | Handle one iteration of the game
step :: Float -> GameState -> IO GameState
step secs gstate = -- Just update the elapsed time
    return $ stepPure secs gstate

stepPure :: Float -> GameState -> GameState
stepPure secs gstate | viewState gstate /= Game = gstate
                     | otherwise = gstate { elapsedTime = timeUpdate, player = playerUpdate, bullets = bulletUpdate, asteroids = asteroidUpdate, 
                                            timeEnemy = updateTime, deadAsteroids = deadAsteroidUpdate, viewState = playerDie gstate, rand = newr }
    where
        timeUpdate                         = elapsedTime gstate + secs
        playerUpdate                       = playerLives $ updatePlayerMovement (keys gstate) secs $ updateTimeSinceHit secs (player gstate)
        playerLives                        = updatePlayerLives (playerBullet (bullets gstate) (player gstate)) (playerAsteroid (asteroids gstate) (player gstate))
        bulletUpdate                       = updateBullets secs $ bulletPlayer (player gstate) $ bulletAsteroid (asteroids gstate) (bullets gstate)
        deadAsteroidUpdate                 = updateDeadAsteroid secs deadAsteroidCollision
        (asteroidUpdate, updateTime, newr) = updateAsteroid (rand gstate) secs (timeEnemy gstate) asteroidCollision
        (asteroidCollision, deadAsteroidCollision) = asteroidPlayer (player gstate) $ asteroidBullet (bullets gstate) (asteroids gstate, deadAsteroids gstate)


-- | Handle user input
input :: Event -> GameState -> IO GameState
input e gstate = return (inputKey e gstate)

inputKey :: Event -> GameState -> GameState
inputKey e gstate = case viewState gstate of
                    Game     -> inputKeyGame e gstate
                    Paused   -> inputKeyPaused e gstate
                    GameOver -> gstate

inputKeyGame :: Event -> GameState -> GameState
inputKeyGame (EventKey (SpecialKey KeySpace) Down _ _) gstate = gstate {bullets = addBullet (player gstate) (bullets gstate)}
inputKeyGame (EventKey (SpecialKey KeyEsc) Down _ _) gstate   = gstate {viewState = Paused}
inputKeyGame (EventKey k Down _ _) gstate                     = gstate {keys = insert k (keys gstate)}
inputKeyGame (EventKey k Up _ _) gstate                       = gstate {keys = delete k (keys gstate)}
inputKeyGame _ gstate = gstate -- Otherwise keep the same

inputKeyPaused :: Event -> GameState -> GameState
inputKeyPaused (EventKey (SpecialKey KeyEsc) Down _ _) gstate = gstate {viewState = Game}
inputKeyPaused _ gstate = gstate -- Otherwise keep the same