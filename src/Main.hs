module Main where
import Controller ( input, step )
import InitialState ( initialState )
import View ( view )
import Graphics.Gloss.Interface.IO.Game
import System.Random (getStdGen)
import Constants

main :: IO ()
main = do 
        rand <- getStdGen
        playIO (InWindow "Counter" screenSizeWhole screenStartPosition) -- Or FullScreen
              black            -- Background color
              framesPerSecond  -- Frames per second
              (initialState rand) -- Initial state
              view             -- View function
              input            -- Event function
              step             -- Step function

