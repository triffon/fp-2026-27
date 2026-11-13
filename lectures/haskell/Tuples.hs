type Person = (String, Int)
type Product = (String, Int)

sayHello :: Person -> String
sayHello p = "Hello, " ++ fst p ++ "!"

ivan :: Person
ivan = ("Ivan", 21)

-- >>> sayHello ivan
-- "Hello, Ivan!"

boxes :: Product
boxes = ("Box", 5)

-- >>> sayHello boxes
-- "Hello, Box!"

-- >>> (2, 3)
-- (2,3)

-- >>> (2, 3) :: (Int, Int)
-- (2,3)

-- >>> () :: ()
-- ()

{-
f x y :: ()
f _ _ = ()
-}
