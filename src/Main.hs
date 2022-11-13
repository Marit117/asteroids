module Main where
import Controller ( input, step )
import InitialState ( initialState )
import View ( view )
import Graphics.Gloss.Interface.IO.Game
import System.Random (getStdGen)

main :: IO ()
main = do 
        rand <- getStdGen
        playIO (InWindow "Counter" (800, 800) (0, 0)) -- Or FullScreen
              black            -- Background color
              60               -- Frames per second
              (initialState rand) -- Initial state
              view             -- View function
              input            -- Event function
              step             -- Step function

