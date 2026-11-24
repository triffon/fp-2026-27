main :: IO()
main = do
    print $ areAmicable 200 300 == False
    print $ areAmicable 220 284 == True
    print $ areAmicable 284 220 == True
    print $ areAmicable 1184 1210 == True
    print $ areAmicable 2620 2924 == True
    print $ areAmicable 6232 6368 == True

getSumOfDivisors :: Int -> Int
areAmicable :: Int -> Int -> Bool

-- Сума на собствените делители (без самото число). Няма делител на n,
-- който е по-голям от n / 2, затова спираме дотам.
getSumOfDivisors n = sum [x | x <- [1 .. div n 2], mod n x == 0]

areAmicable x y = getSumOfDivisors x == y && x == getSumOfDivisors y
