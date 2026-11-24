main :: IO()
main = do
    print $ elevatorStops 1 == 0
    print $ elevatorStops 6 == 8
    print $ elevatorStops 27 == 111

    print $ longestElevatorRide 10 == (9, 19)
    print $ longestElevatorRide 100 == (97, 118)
    print $ longestElevatorRide 1000 == (871, 178)

-- Броим пътуванията до етаж 1: от четен етаж слизаме наполовина,
-- от нечетен се качваме на 3n + 1. Етаж 1 е базовият случай - 0 пътувания.
elevatorStops :: Int -> Int
elevatorStops 1 = 0
elevatorStops n
 | even n = 1 + elevatorStops (div n 2)
 | otherwise = 1 + elevatorStops (3 * n + 1)

-- Кортежите се сравняват лексикографски - първо по първата компонента, при
-- равенство по втората. Слагаме броя пътувания отпред, за да може maximum да
-- избере най-дългото пътуване, и накрая разменяме компонентите.
longestElevatorRide :: Int -> (Int, Int)
longestElevatorRide n = (floor', stops)
 where
    (stops, floor') = maximum [ (elevatorStops k, k) | k <- [1 .. n]]
