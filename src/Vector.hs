module Vector where

import Data.Fixed (mod')

type Vector = (Float, Float)

vectorAdd :: Vector -> Vector -> Vector
vectorAdd (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

vectorScale :: Vector -> Float -> Vector
vectorScale (x, y) n = (x * n, y * n)

vectorMod :: Vector -> Float -> Vector
vectorMod (x, y) f = (mod' (x + 400) f - 400, mod' (y + 400) f - 400)

rotate :: Vector -> Float -> Vector
rotate (x, y) fg = (xn, yn)
  where
    fr = fg * (pi / 180)
    xn = cos fr * x - sin fr * y
    yn = sin fr * x + cos fr * y