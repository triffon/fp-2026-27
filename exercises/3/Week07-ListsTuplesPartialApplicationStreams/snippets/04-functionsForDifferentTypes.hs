-- Полиморфни функции: a и b са типови променливи - myMap работи за всеки тип
-- елементи, стига f да приема a и да връща b. Това е същата myMap като map от Prelude.
myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs


myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs) = if p x then x : myFilter p xs else myFilter p xs
