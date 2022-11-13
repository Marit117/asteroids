module ViewGameOver where
import Graphics.Gloss
import Model
import HighScore (zipScores)
import Constants

viewGameOverState :: GameState -> Picture
viewGameOverState gstate = Pictures [viewGameOver, viewHighScore, viewOwnScore (score gstate), Pictures $ viewScores (highscores gstate)]

viewGameOver :: Picture
viewGameOver = positionGameOver $ largeText $ color white $ Text "Game Over"

viewHighScore :: Picture
viewHighScore = positionHighScore $ mediumText $ color white $ Text "High Scores:"

viewScores :: Maybe [Score] -> [Picture]
viewScores (Just scores) = map (\(y, s) -> translate xPositionScores (highScorePosition - highScoreSize * y) $ smallText $ color white $ Text $ show s) (zipScores scores)
viewScores Nothing       = []

viewOwnScore :: Score -> Picture
viewOwnScore score = positionOwnScore $ smallText $ color green $ Text ("Your score: " ++ show score)