-- foldr и foldl "сгъват" списък до една стойност с бинарна функция и начална стойност:
--
--   foldr f nv [x1, x2, x3] = f x1 (f x2 (f x3 nv))   -- отдясно наляво
--   foldl f nv [x1, x2, x3] = f (f (f nv x1) x2) x3   -- отляво надясно
--
-- Редът на аргументите на f е РАЗЛИЧЕН:
--   foldr: f :: елемент -> акумулатор -> акумулатор  (както foldr в Racket)
--   foldl: f :: акумулатор -> елемент -> акумулатор  (както foldl от лекциите, НЕ като вградения в Racket)

sumR :: [Int] -> Int
sumR = foldr (+) 0

sumL :: [Int] -> Int
sumL = foldl (+) 0

main :: IO()
main = do
    print $ sumR [1, 2, 3]         -- 6
    print $ sumL [1, 2, 3]         -- 6
    -- При некомутативна операция разликата се вижда.
    print $ foldr (-) 0 [1, 2, 3]  -- 2  = 1 - (2 - (3 - 0))
    print $ foldl (-) 0 [1, 2, 3]  -- -6 = ((0 - 1) - 2) - 3
    -- Редът на прилагане, показан като низ.
    print $ foldr (\ x acc -> "(" ++ show x ++ " op " ++ acc ++ ")") "nv" [1, 2, 3 :: Int] -- "(1 op (2 op (3 op nv)))"
    print $ foldl (\ acc x -> "(" ++ acc ++ " op " ++ show x ++ ")") "nv" [1, 2, 3 :: Int] -- "(((nv op 1) op 2) op 3)"
    -- foldr с (:) и [] възстановява списъка - затова с foldr лесно се изразяват map и filter.
    print $ foldr (:) [] [1, 2, 3]                                            -- [1,2,3]
    print $ foldr (\ x acc -> x * 2 : acc) [] [1, 2, 3]                       -- [2,4,6] - map
    print $ foldr (\ x acc -> if even x then x : acc else acc) [] [1, 2, 3, 4] -- [2,4] - filter
    -- foldl с (:) обръща списъка; flip разменя аргументите, защото (:) иска елемента пръв.
    print $ foldl (flip (:)) [] [1, 2, 3]                                     -- [3,2,1]
    -- Ако f не използва акумулатора, foldr спира рано - работи дори върху безкраен списък.
    print $ foldr (\ x acc -> x > 10 || acc) False [1 ..]                     -- True
    -- foldl трябва да стигне до края на списъка - върху безкраен не приключва.
    -- sum, product, maximum, and, or, concat са все fold-ове.
    print $ foldr max 0 [3, 9, 2]                                             -- 9
    print $ foldr (&&) True [True, False]                                     -- False
