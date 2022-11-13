-- | This module defines how the state changes
--   in response to time and user input
module Controller where
import Model
import Graphics.Gloss ()
import Graphics.Gloss.Interface.IO.Game
import Player (updatePlayerMovement, updatePlayerLives, updateTimeSinceHit, playerDie)
import Bullet (updateBullets, addBullet)
import Asteroid(moveAsteroid)
import DeadAsteroid (updateDeadAsteroid)
import Enemy (addEnemy)
import Ufo (moveUfo, ufosShoot, ufoUpdateTime)
import HighScore (readHighScores)
import Data.Maybe (isNothing)
import Data.Set (member, insert, delete)
import Collision

-- | Handle one iteration of the game
step :: Time -> GameState -> IO GameState -- Just update the elapsed time
step secs gstate | viewState gstate == GameOver && isNothing (highscores gstate)= do
                                                highScores <- readHighScores (score gstate)
                                                return gstate {highscores = Just highScores}
                 | otherwise = return $ stepPure secs gstate

stepPure :: Time -> GameState -> GameState
stepPure secs gstate | viewState gstate /= Game = gstate
                     | otherwise = gstate { elapsedTime = timeUpdate, player = playerUpdate, bullets = bulletUpdate, asteroids = asteroidUpdate,
                                            timeEnemy = updateTime, deadAsteroids = deadAsteroidUpdate, ufos = ufoUpdate, viewState = playerDie gstate, rand = newr,
                                            score = scoreUpdate }
    where
        timeUpdate                              = elapsedTime gstate + secs
        scoreUpdate                             = score gstate + scoreAs + scoreUfo
        
        playerUpdate                            = playerLives $ updatePlayerMovement (keys gstate) secs $ updateTimeSinceHit secs (player gstate)
        playerLives                             = updatePlayerLives $ playerAllCollision (asteroids gstate) (bullets gstate) (ufos gstate) (player gstate)
        
        bulletUpdate                            = updateBullets secs bulletCollision
        bulletCollision                         = bulletAllCollision (asteroids gstate) (ufos gstate) (player gstate) ufobullets
        (ufosTime, ufobullets)                  = ufosShoot (player gstate) (bullets gstate) (ufos gstate)

        deadAsteroidUpdate                      = updateDeadAsteroid secs deadAsCollision

        asteroidUpdate                          = moveAsteroid secs asAdded
        ufoUpdate                               = moveUfo secs $ ufoUpdateTime secs ufoCollision
        (ufoCollision, scoreUfo)                = ufoAllCollision (asteroids gstate) (bullets gstate) (player gstate) ufoAdded
        
        (asAdded, ufoAdded, updateTime, newr)   = addEnemy (rand gstate) secs (asCollision, ufosTime, timeEnemy gstate)
        (asCollision, deadAsCollision, scoreAs) = asteroidAllCollision gstate


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