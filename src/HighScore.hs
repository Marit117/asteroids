module HighScore where
import Data.List (sort)
import System.IO (readFile')
import Model

readHighScores :: Score -> IO ([Score])
readHighScores score = do
                    contents <- readFile' "highscores.txt"
                    let newcontent = scoreInHighScore score (map read (lines contents))
                    writeFile "highscores.txt" (unlines (map show newcontent))
                    return newcontent

scoreInHighScore :: Score -> [Score] -> [Score]
scoreInHighScore score sx = take 5 $ reverse $ sort (score : sx)

zipScores :: [Score] -> [(Float, Score)]
zipScores = zip [1..5]