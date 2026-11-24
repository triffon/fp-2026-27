main :: IO()
main = do
    print $ pythagoreanTriples 20 == [(3,4,5),(5,12,13),(6,8,10),(8,15,17),(9,12,15),(12,16,20)]
    print $ pythagoreanTriples 5 == [(3,4,5)]

    print $ goldbach 4 == (2,2)
    print $ goldbach 28 == (5,23)
    print $ goldbach 100 == (3,97)

-- Всеки следващ генератор започва след предишния (b от a + 1, c от b + 1),
-- така директно получаваме a < b < c и всяка тройка само веднъж. Външният
-- генератор се мени най-бавно, затова резултатът е в лексикографски ред.
pythagoreanTriples :: Int -> [(Int, Int, Int)]
pythagoreanTriples n = [ (a, b, c) | a <- [1 .. n], b <- [a + 1 .. n], c <- [b + 1 .. n], a * a + b * b == c * c]

intSqrt :: Int -> Int
intSqrt = floor . sqrt . fromIntegral

-- isPrime от задача 8.
isPrime :: Int -> Bool
isPrime n = n > 1 && all (\ x -> mod n x /= 0) [2 .. intSqrt n]

-- Достатъчно е да обходим p до n / 2 - тогава q = n - p >= p и всяка двойка
-- се среща веднъж. Списъкът е мързелив, затова взимането на първия елемент
-- спира още при първата намерена двойка и не пресмята останалите.
-- (Може и с head, но GHC предупреждава за нея, защото гърми върху празен
-- списък - pattern matching-ът казва същото явно.)
goldbach :: Int -> (Int, Int)
goldbach n = firstPair [ (p, n - p) | p <- [2 .. div n 2], isPrime p, isPrime (n - p)]
 where
    firstPair :: [(Int, Int)] -> (Int, Int)
    firstPair (pair:_) = pair
