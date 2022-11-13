module InitialState where
import System.Random (StdGen)
import Data.Set (empty)
import Model
import Asteroid (asteroidRandom)

-- GameState
initialState :: StdGen -> GameState
initialState r = GameState {
                           score         = 0,
                           highscores    = Nothing,
                           player        = initialPlayer,
                           asteroids     = [newAsteroid],
                           timeEnemy     = 0,
                           deadAsteroids = [],
                           ufos          = [],
                           bullets       = [],
                           keys          = empty,
                           viewState     = Game,
                           elapsedTime   = 0,
                           rand          = newr
                           }
    where
        (newAsteroid, newr) = asteroidRandom r

-- Player
initialPlayer :: Player
initialPlayer = Player {lives = 3, timeSinceHit = 0, angle = 0, direction = (0, 1), locationPlayer = (LocationData {velocity = (0,0), position = (0,0)})}