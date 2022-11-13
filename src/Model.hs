-- | This module contains the data types
--   which represent the state of the game
module Model where
import Graphics.Gloss.Interface.IO.Game (Key)
import Data.Set (Set, empty)
import System.Random (StdGen, mkStdGen)

-- Types
type Score    = Int
type Time     = Float
type Vector   = (Float, Float)
type Position = Vector
type Velocity = Vector

-- GameState
data GameState = GameState {   score         :: Score,
                               highscores    :: Maybe [Score],
                               player        :: Player,
                               asteroids     :: [Asteroid],
                               timeEnemy     :: Time,
                               deadAsteroids :: [DeadAsteroid],
                               ufos          :: [Ufo],
                               bullets       :: [Bullet],
                               keys          :: Set Key,
                               viewState     :: ViewState,
                               elapsedTime   :: Time,
                               rand          :: StdGen
                           }

-- ViewState
data ViewState = Game | Paused | GameOver
    deriving (Eq)

-- Player
data Player = Player { lives          :: Int,
                       timeSinceHit   :: Time,
                       angle          :: Float,
                       direction      :: Vector,
                       locationPlayer :: LocationData
                     }

-- Asteroid
data Asteroid = Asteroid { size             :: AsteroidSize,
                           locationAsteroid :: LocationData
                         }

data AsteroidSize = Small | Medium | Large
    deriving (Eq, Ord, Enum)

data DeadAsteroid = DeadAsteroid {deathPosition  :: Position,
                                  timeSinceDeath :: Time
                                 }

-- Bullet
data Bullet = Bullet { locationBullet :: LocationData,
                       lifeTime       :: Time
                     }

-- Ufo
data Ufo = Ufo { aim           :: Aim,
                 timeSinceShot :: Time,
                 locationUfo   :: LocationData
               }

data Aim = FrontAim | PlayerAim
    deriving (Eq)

-- LocationData
data LocationData = LocationData { velocity :: Velocity,
                                   position :: Position
                                 }