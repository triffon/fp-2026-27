-- Ламбда: \ аргументи -> тяло. Знакът \ наподобява буквата λ.
-- filter запазва елементите, за които предикатът връща True.
getEven :: [Int] -> [Int]
getEven xs = filter (\ x -> even x) xs

-- map прилага функцията към всеки елемент.
double :: [Int] -> [Int]
double xs = map (\ x -> 2 * x) xs

-- all/any проверяват дали предикатът е верен за всички/поне един елемент.
areAllOdd :: [Int] -> Bool -- any
areAllOdd xs = all odd xs

main :: IO ()
main = do
    -- Ламбдата е стойност като всяка друга - можем да я извикаме веднага.
    print $ (\ x y z -> x + y + z) 1 2 3
    print $ getEven [1 .. 10]
    print $ double [1, 2, 3]
    print $ areAllOdd [1, 3, 5]
    print $ areAllOdd [1, 2, 5]
