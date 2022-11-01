module LocationData where
import Vector (Vector)

type Position = Vector
type Velocity = Vector

data LocationData = LocationData { velocity :: Velocity,
                                   position :: Position
                                 }