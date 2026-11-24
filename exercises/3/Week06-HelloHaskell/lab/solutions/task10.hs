main :: IO()
main = do
    print $ scholarship 4.99 == 0
    print $ scholarship 5.0 == 100
    print $ scholarship 5.49 == 100
    print $ scholarship 5.5 == 150
    print $ scholarship 5.89 == 150
    print $ scholarship 5.9 == 200
    print $ scholarship 6 == 200

    print $ monthsToLaptop 5.75 1300 == 9
    print $ monthsToLaptop 6 1300 == 7
    print $ monthsToLaptop 4 1300 == -1

-- Guards се проверяват отгоре надолу и се избира първото вярно условие,
-- затова е достатъчно да проверяваме само долната граница на всеки интервал.
scholarship :: Double -> Int
scholarship avg
 | avg >= 5.9 = 200
 | avg >= 5.5 = 150
 | avg >= 5.0 = 100
 | otherwise = 0

-- Стипендията е Int, а цената - Double, затова преобразуваме с fromIntegral,
-- преди да делим. ceiling закръгля нагоре - и 8.67 месеца са 9 месеца чакане.
-- Случаят "няма стипендия" няма смислен брой месеци - връщаме -1 (по-късно
-- в курса ще видим по-подходящ начин за това - Maybe).
monthsToLaptop :: Double -> Double -> Int
monthsToLaptop avg price
 | monthly == 0 = -1
 | otherwise = ceiling (price / fromIntegral monthly)
 where
    monthly :: Int
    monthly = scholarship avg
