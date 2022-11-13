module Update where
import Model
import Vector ( vectorAdd, vectorScale, vectorMod )
import Constants (wholeScreen)

updatePosition :: LocationData -> Time -> LocationData
updatePosition l secs = updateBorders $ l{ position = vectorAdd (position l) (vectorScale (velocity l) secs) }

updateVelocity :: LocationData -> Velocity -> LocationData
updateVelocity l v = l{ velocity = v }

updateBorders :: LocationData -> LocationData
updateBorders l = l {position = vectorMod (position l) wholeScreen}