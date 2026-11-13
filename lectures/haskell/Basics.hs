module Basics where

{-
fact 0 = 1
fact n = n * fact (n - 1)
-}

-- >>> 2 + 2
-- 4

-- >>> fact 5
-- 120

-- int x;
-- int x = 2;

x :: Num a => a
x = 2
-- >>> x + 2
-- 4


y :: Double
-- y = y
-- type coercion
y = x^2 + 7.5
-- y = fromIntegral x^2 + 7.5 + 5
-- >>> y
-- 11.5

t :: Float
t = realToFrac y + 2.3

z :: String
z = "Hello, Haskell"

twice :: (t -> t) -> t -> t
twice f x = f (f x)
-- >>> twice fact 4
-- 620448401733239439360000

-- >>> 13 `div` 5
-- 2

-- >>> fact `twice` 4
-- 620448401733239439360000

-- >>> (+) 2 4
-- 6

fact n
  | n == 0       = 1
  | n >  0       = fact (n - 1) * n
  | otherwise    = error "fact очаква неотрицателно число!"

-- >>> fact 4
-- 24

-- >>> fact (-5)
-- fact очаква неотрицателно число!

-- >>> 2 + (let y = 3 in 6 + (let z = 6 in y * z) - y)
-- 23

{-
!!!
g x = let y = x * 2 in
    | x > 0 = 2
    | y > 0 = 4
    ...
-}

g x
 | x > 0 = 2
 | y > 0 = 4
 where { y = x * 2; z = y + 8 }

(%) = mod

-- >>> 5 % 3
-- 2

x ✈ y = "Flying from " ++ x ++ " to " ++ y

-- >>> "Sofia" ✈ "Varna"
-- "Flying from Sofia to Varna"

-- >>> (2 > 3) && (0 / 0 < 5)
-- False