main :: IO()
main = do
    print $ squareThenAddOne 3           -- 10
    print $ addOneThenSquare 3           -- 16
    print $ squareThenAddOne' 3          -- 10
    print $ isEvenAfterAddOne 3          -- True - 3 + 1 = 4
    print $ (addOne . square) 5          -- 26 - композицията може да се ползва и без име
    print $ map (addOne . square) [1, 2, 3] -- [2,5,10]

square :: Int -> Int
square x = x * x

addOne :: Int -> Int
addOne x = x + 1

-- Композиция на функции: (f . g) x = f (g x) - първо се прилага g, после f.
-- Чете се отдясно наляво, както в математиката (f ∘ g).
squareThenAddOne :: Int -> Int
squareThenAddOne = addOne . square -- x -> addOne (square x)

addOneThenSquare :: Int -> Int
addOneThenSquare = square . addOne -- x -> square (addOne x)

-- Дефинициите по-горе нямат явен аргумент (point-free стил): казваме КОИ
-- функции се редят, без да споменаваме x. Напълно еквивалентно е на:
squareThenAddOne' :: Int -> Int
squareThenAddOne' x = addOne (square x)

-- Може да се редят произволно много функции.
isEvenAfterAddOne :: Int -> Bool
isEvenAfterAddOne = even . addOne

-- $ и . си приличат, но са различни:
--   f $ x  прилага f върху x веднага (само спестява скобите): f (x)
--   f . g  прави НОВА функция, която още не е приложена върху нищо
-- Затова "print . square 3" е грешка, а "print $ square 3" и "(print . square) 3" работят.
