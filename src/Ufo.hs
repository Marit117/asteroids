module Ufo where
import Model
import Constants
import Update (updatePosition)

-- Ufo Movement
moveUfo :: Time -> [Ufo] -> [Ufo]
moveUfo secs = map (\ufo -> ufo { locationUfo = updatePosition (locationUfo ufo) secs})

-- Ufo added every few seconds



-- Ufo shoots every few seconds