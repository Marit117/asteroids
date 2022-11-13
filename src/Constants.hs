module Constants where
import Graphics.Gloss (scale)
import Graphics.Gloss.Data.Picture (translate)

-- General
framesPerSecond :: Int
framesPerSecond = 60

screenStartPosition :: (Int, Int)
screenStartPosition = (0, 0)

wholeScreen :: Float
wholeScreen = 800

halfScreen :: Float
halfScreen = 400

screenSize :: (Float, Float)
screenSize = (-halfScreen, halfScreen)

screenSizeWhole :: (Int, Int)
screenSizeWhole = (800, 800)

resetTime :: Float
resetTime = 0

-- Enemy
timeAddEnemy :: Float
timeAddEnemy = 5

randomSpeed :: (Float, Float)
randomSpeed = (360, 100)

randomRotation :: (Float, Float)
randomRotation = (0, 20)

randomChance :: (Int, Int)
randomChance = (1, 100)

chanceUfoMax :: Int
chanceUfoMax = 50

decreaseChanceSpeed :: Float
decreaseChanceSpeed = 2

-- Ufo
ufoOutline :: [(Float, Float)]
ufoOutline = [(15, 0), (10, 15), (0, 20), (-10, 15), (-15, 0), (-25, -10), (-10, -15), (10, -15), (25, -10), (15, 0), (-15, 0)]

shootSpeed :: Float
shootSpeed = 1

ufoBulletLifeTime :: Float
ufoBulletLifeTime = 1

chancePlayerAim :: Int
chancePlayerAim = 50

-- Asteroid
asteroidOutline :: [(Float, Float)]
asteroidOutline = [(-10,20), (10,15), (0,5), (10,0), (15,-10), (0,-20), (-20,-10), (-20,10), (-10,20)]

newAsteroidSpeedLow :: Float
newAsteroidSpeedLow = -0.75

newAsteroidSpeedHigh :: Float
newAsteroidSpeedHigh = 1.5

asteroidScaleSmall :: Float
asteroidScaleSmall = 0.75

asteroidScaleMedium :: Float
asteroidScaleMedium = 1

asteroidScaleLarge :: Float
asteroidScaleLarge = 1.5

-- Bullet
bulletSize :: Float
bulletSize = 3

bulletLifeTime :: Float
bulletLifeTime = 2

bulletTimeDie :: Float
bulletTimeDie = 0

bulletSpeed :: Float
bulletSpeed = 300

bulletStartPosition :: Float
bulletStartPosition = 25

-- Player
playerOutline :: [(Float, Float)]
playerOutline = [(0, 20), (20, -10), (0, 0), (-20, -10)]

playerSpeed :: Float
playerSpeed = 200

playerMinSpeed :: Float
playerMinSpeed = 0

playerRotationSpeed :: Float
playerRotationSpeed = 180

playerMinRotationSpeed :: Float
playerMinRotationSpeed = 0

playerFriction :: Float
playerFriction = 0.6

playerCooldown :: Float
playerCooldown = 2

playerMinLives :: Int
playerMinLives = 1

-- Collision
asteroidSmallRadius :: Float
asteroidSmallRadius = 15

asteroidMediumRadius :: Float
asteroidMediumRadius = 20

asteroidLargeRadius :: Float
asteroidLargeRadius = 25

asteroidPlayerRadius :: Float
asteroidPlayerRadius = 15

asteroidBulletRadius :: Float
asteroidBulletRadius = 3

asteroidUfoRadius :: Float
asteroidUfoRadius = 20

bulletPlayerRadius :: Float
bulletPlayerRadius = 15

bulletUfoRadius :: Float
bulletUfoRadius = 20

ufoPlayerRadius :: Float
ufoPlayerRadius = 30

-- High Scores
numberHighScores :: Int
numberHighScores = 5

numberScores :: Float
numberScores = 5

-- Scores
minPoints :: Int
minPoints = 0

pointsLargeAsteroid :: Int
pointsLargeAsteroid = 25

pointsMediumAsteroid :: Int
pointsMediumAsteroid = 50

pointsSmallAsteroid :: Int
pointsSmallAsteroid = 100

pointsUfo :: Int
pointsUfo = 200

-- View
smallerText = scale 0.2 0.2
smallText   = scale 0.25 0.25
mediumText  = scale 0.35 0.35
largeText   = scale 0.5 0.5 
largerText  = scale 0.75 0.75

-- View Game Over
highScorePosition :: Float
highScorePosition = 200

highScoreSize :: Float
highScoreSize = 50

positionGameOver = translate (-200) 300
positionHighScore = translate (-150) 225
positionOwnScore = translate (-150) (-100)

xPositionScores :: Float
xPositionScores = -150

-- View Game
positionLives = translate (-375) 350
positionScore = translate 200 350

-- View Paused
positionPaused = translate (-150) 0
positionPressEsc = translate (-225) (-50)