module ViewGameOver where
import Graphics.Gloss
import Model
import HighScore (zipScores)
import Constants (highScorePosition, highScoreSize, smallText, mediumText, largeText)

viewGameOverState :: GameState -> Picture
viewGameOverState gstate = Pictures [viewGameOver, viewHighScore, viewOwnScore (score gstate), Pictures $ viewScores (highscores gstate)]

viewGameOver :: Picture
viewGameOver = translate (-200) 300 $ largeText $ color white $ Text "Game Over"

viewHighScore :: Picture
viewHighScore = translate (-150) 225 $ mediumText $ color white $ Text "High Scores:"

viewScores :: Maybe [Score] -> [Picture]
viewScores (Just scores) = map (\(y, s) -> translate (-150) (highScorePosition - highScoreSize * y) $ smallText $ color white $ Text $ show s) (zipScores scores)
viewScores Nothing       = []

viewOwnScore :: Score -> Picture
viewOwnScore score = translate (-150) (-100) $ smallText $ color green $ Text ("Your score: " ++ show score)