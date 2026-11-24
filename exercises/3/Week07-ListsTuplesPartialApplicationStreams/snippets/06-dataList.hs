import Data.List

-- Полезни функции от Data.List (трябва import Data.List).
main :: IO()
main = do
    -- group събира еднаквите СЪСЕДНИ елементи в групи ...
    print $ group [1, 1, 2, 3, 3, 3, 1]             -- [[1,1],[2],[3,3,3],[1]]
    -- ... затова за "всички еднакви заедно" първо сортираме.
    print $ group (sort [1, 1, 2, 3, 3, 3, 1])      -- [[1,1,1],[2],[3,3,3]]
    print $ map length (group (sort "mississippi")) -- [4,1,2,4] - i, m, p, s
    -- nub маха повторенията (запазва първото срещане).
    print $ nub [3, 1, 3, 2, 1]                     -- [3,1,2]
    -- inits - всички префикси, tails - всички суфикси.
    print $ inits [1, 2, 3]                         -- [[],[1],[1,2],[1,2,3]]
    print $ tails [1, 2, 3]                         -- [[1,2,3],[2,3],[3],[]]
    print $ isPrefixOf [1, 2] [1, 2, 3]             -- True
    print $ isSuffixOf "ell" "Haskell"              -- True
    print $ isInfixOf "ask" "Haskell"               -- True
    -- takeWhile/dropWhile - като take/drop, но по условие, а не по брой.
    print $ takeWhile even [2, 4, 5, 6]             -- [2,4]
    print $ dropWhile even [2, 4, 5, 6]             -- [5,6]
    -- span връща двете части наведнъж; break спира при първия елемент, за който условието Е вярно.
    print $ span even [2, 4, 5, 6]                  -- ([2,4],[5,6])
    print $ break (> 3) [1, 2, 5, 1]                -- ([1,2],[5,1])
    print $ splitAt 2 [1, 2, 3, 4]                  -- ([1,2],[3,4])
    -- Съседни елементи: zip на списъка с опашката му (drop 1 вместо tail - tail гърми при []).
    print $ zip [1, 2, 3, 4] (drop 1 [1, 2, 3, 4])  -- [(1,2),(2,3),(3,4)]
    print $ zipWith (<) [1, 2, 2, 3] (drop 1 [1, 2, 2, 3])        -- [True,False,True]
    print $ and (zipWith (<=) [1, 2, 2, 3] (drop 1 [1, 2, 2, 3])) -- True - ненамаляващ списък
    -- concat слепва списък от списъци, concatMap = concat . map.
    print $ concat [[1, 2], [3], [4, 5]]            -- [1,2,3,4,5]
    print $ concatMap (\ x -> [x, x]) [1, 2, 3]     -- [1,1,2,2,3,3]
    print $ replicate 3 'x'                         -- "xxx"
    print $ elem 3 [1, 2, 3]                        -- True
    print $ notElem 3 [1, 2, 3]                     -- False
