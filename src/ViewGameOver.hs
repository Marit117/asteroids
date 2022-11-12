module ViewGameOver where
import Graphics.Gloss
import Model
import HighScore (zipScores)

viewGameOverState :: GameState -> Picture
viewGameOverState gstate = Pictures [viewGameOver, viewHighScore, viewOwnScore (score gstate), Pictures $ viewScores (highscores gstate)]

viewGameOver :: Picture
viewGameOver = translate (-200) 300 $ scale 0.5 0.5 $ color white $ Text "Game Over"

viewOwnScore :: Score -> Picture
viewOwnScore score = translate (-150) (-100) $ scale 0.25 0.25 $ color green $ Text ("Your score: " ++ show score)

viewHighScore :: Picture
viewHighScore = translate (-150) 225 $ scale 0.35 0.35 $ color white $ Text "High Scores:"

viewScores :: Maybe [Score] -> [Picture]
viewScores (Just scores) = map (\(y, s) -> translate (-150) (200 - 50 * y) $ scale 0.25 0.25 $ color white $ Text $ show s) (zipScores scores)
viewScores Nothing       = []