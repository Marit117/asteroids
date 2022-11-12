module Constants where

-- Asteroid
timeAddAsteroid :: Float
timeAddAsteroid = 5

newAsteroidSpeedLow :: Float
newAsteroidSpeedLow = 0.5

newAsteroidSpeedHigh :: Float
newAsteroidSpeedHigh = 1.5

asteroidOutline :: [(Float, Float)]
asteroidOutline =[(-10,20), (10,15), (0,5), (10,0), (15,-10), (0,-20), (-20,-10), (-20,10), (-10,20)]

-- Bullet
bulletLifeTime :: Float
bulletLifeTime = 2

bulletTimeDie :: Float
bulletTimeDie = 0

bulletSpeed :: Float
bulletSpeed = 300

bulletStartPosition :: Float
bulletStartPosition = 25

-- Player
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
asteroidSmallCollision :: Float
asteroidSmallCollision = 15

asteroidMediumCollision :: Float
asteroidMediumCollision = 20

asteroidLargeCollision :: Float
asteroidLargeCollision = 25

bulletPlayerCollision :: Float
bulletPlayerCollision = 15