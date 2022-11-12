-- | This module contains the data types
--   which represent the state of the game
module Model where
import Graphics.Gloss.Interface.IO.Game (Key)
import Data.Set (Set, empty)
import System.Random (StdGen, mkStdGen)

-- GameState
data GameState = GameState {   score         :: Int,
                               player        :: Player,
                               asteroids     :: [Asteroid],
                               timeEnemy     :: Float,
                               deadAsteroids :: [DeadAsteroid],
                               ufos          :: [Ufo],
                               bullets       :: [Bullet],
                               keys          :: Set Key,
                               viewState     :: ViewState,
                               elapsedTime   :: Float,
                               rand          :: StdGen
                             }

initialState :: StdGen -> GameState
initialState r = GameState {
                           score         = 0,
                           player        = Player {lives = 3, timeSinceHit = 0, angle = 0, direction = (0, 1), locationPlayer = (LocationData {velocity = (0,0), position = (0,0)})},
                           asteroids     = [],
                           timeEnemy     = 0,
                           deadAsteroids = [],
                           ufos          = [],
                           bullets       = [],
                           keys          = empty,
                           viewState     = Game,
                           elapsedTime   = 0,
                           rand          = r
                          }
    --where
        --(newAsteroid, newr) = asteroidRandom r

-- ViewState
data ViewState = Game | Paused | GameOver
    deriving (Eq)

-- Player
data Player = Player { lives          :: Int,
                       timeSinceHit   :: Float,
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
                                  timeSinceDeath :: Float
                                 }

-- Bullet
data Bullet = Bullet { locationBullet :: LocationData,
                       lifeTime       :: Float
                     }

-- Ufo
data Ufo = Ufo { aim         :: Aim,
                 locationUfo :: LocationData
               }

data Aim = RandomAim | PlayerAim

-- LocationData
data LocationData = LocationData { velocity :: Velocity,
                                   position :: Position
                                 }

-- Types
type Vector = (Float, Float)
type Position = Vector
type Velocity = Vector