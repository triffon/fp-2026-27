-- Кортеж (tuple): фиксиран брой елементи, които могат да са от различни типове.
-- За разлика от списъка, броят и типовете на елементите са част от типа на кортежа.
myFirstHaskellTuple :: (Int, Int)
myFirstHaskellTuple = (2, 4)
-- std::pair<int, int>

moreComplexTuple :: (Int, [Double], Char)
moreComplexTuple = (2, [2.3, 4.6, 10.3], 'p')
-- std::tuple<int, std::vector<double>, char>

-- type въвежда само синоним (ново име) на съществуващ тип.
type Point2D = (Double, Double)
-- typedef std::pair<double, double> Point2D;

-- Pattern matching върху кортеж: аргументът се "разглобява" на компонентите си x и y.
sumOfCoordinates :: Point2D -> Double
sumOfCoordinates (x, y) = x + y

-- fst и snd вземат компонентите на наредена ДВОЙКА (само за двойки; за тройки
-- и нагоре ползваме pattern matching).
-- zip "закопчава" два списъка в списък от двойки - до дължината на по-късия.
-- zipWith комбинира съответните елементи с подадена функция, а unzip е обратното на zip.
main :: IO()
main = do
    print myFirstHaskellTuple                       -- (2,4)
    print moreComplexTuple                          -- (2,[2.3,4.6,10.3],'p')
    print $ fst myFirstHaskellTuple                 -- 2
    print $ snd myFirstHaskellTuple                 -- 4
    print $ sumOfCoordinates (1.5, 2.5)             -- 4.0
    print $ zip [1, 2, 3] "abc"                     -- [(1,'a'),(2,'b'),(3,'c')]
    print $ zip [1, 2, 3] [10, 20]                  -- [(1,10),(2,20)] - до по-късия
    print $ zipWith (+) [1, 2, 3] [10, 20, 30]      -- [11,22,33]
    print $ zipWith (\ x y -> x * 10 + y) [1, 2] [3, 4] -- [13,24]
    print $ unzip [(1, 'a'), (2, 'b')]              -- ([1,2],"ab")
    -- Съседни елементи: zip на списъка с опашката му (drop 1 вместо tail, защото
    -- tail гърми върху празен списък и GHC предупреждава за това).
    print $ zip [1, 2, 3, 4] (drop 1 [1, 2, 3, 4])  -- [(1,2),(2,3),(3,4)]
    -- Списък от двойки се обхожда с pattern matching в ламбда.
    print $ map (\ (x, y) -> x + y) [(1, 2), (3, 4)] -- [3,7]
