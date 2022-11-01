-- | This module contains the data types
--   which represent the state of the game
module Model where
import Bullet (Bullet (Bullet))
import Player (Player (..))
import Asteroid (Asteroid (..), asteroidRandom)
import LocationData ( LocationData(..) )
import Graphics.Gloss.Interface.IO.Game (Key)
import Data.Set (Set, empty)
import System.Random (StdGen, mkStdGen)

--- onze code
data GameState = GameState {   score       :: Int,
                               player      :: Player,
                               asteroids   :: [Asteroid],
                               timeEnemy   :: Float,
                               ufos        :: [Ufo],
                               bullets     :: [Bullet],
                               keys        :: Set Key,
                               elapsedTime :: Float,
                               rand        :: StdGen
                             }

initialState :: StdGen -> GameState
initialState r = GameState {
                           score       = 0,
                           player      = Player {lives = 3, angle = 0, direction = (0, 1), locationPlayer = (LocationData {velocity = (0,0), position = (0,0)})},
                           asteroids   = [newAsteroid],
                           timeEnemy   = 0,
                           ufos        = [],
                           bullets     = [],
                           keys        = empty,
                           elapsedTime = 0,
                           rand        = newr
                          }
    where
        (newAsteroid, newr) = asteroidRandom r

data Ufo = Ufo { aim         :: Aim,
                 locationUfo :: LocationData
               }

data Aim = RandomAim | PlayerAim