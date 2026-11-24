import System.Console.Terminfo (restoreDefaultColors)

-- map length [[1, 2], [3, 4, 5], [6, 2, 10, 11]]
-- filter even [1, 2, 3, 4, 8, 10, 32, 4, 3, 7, 8]
-- Show ((a0 -> b0 -> b0) -> b0 -> [a0] -> b0)
-- foldr (\ elem res -> res + elem) 0 [1, 2, 3, 4]

add1 :: Num a => a -> a
add1 x = x + 1

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

map1 :: (t -> a) -> [t] -> [a]
map1 _ [] = []
map1 f (x:xs) = f x : map1 f xs

filter1 _ [] = []
filter1 p (x:xs) = if p then x : rest else rest
    where rest = filter1 p xs

myfoldr _ nv [] = nv
myfoldr f nv (x:xs) = myfoldr f (f x nv) xs

($$) :: Floating a => (a, a) -> (a, a) -> a
($$) (x1, y1) (x2, y2) = sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

len [] = 0
len (x:xs) = 1 + (len xs )

len2 l = foldr (\ x res -> 1 + res) 0 l

composeN _ 0 = id
composeN f n = composeN f (n-1) . f

join xs = foldr (++) "" xs

isPrefix [] _ = True
isPrefix _ [] = False
isPrefix (x:xs) (y:ys) = (x == y) && isPrefix xs ys

isInfixOf [] _ = True
isInfixOf  _ [] = False
isInfixOf xs (y:ys) = isPrefix xs (y:ys) || isInfixOf xs ys


quickSort [] = []
quickSort (x:xs) = quickSort (filter (< x) xs) ++ [x] ++ quickSort (filter (>= x) xs)

insert y [] = [y]
insert y (x:xs) = if x < y then x : insert y xs else y : (x:xs)

insertSort xs = foldr insert [] xs



main :: IO ()
main = do
  print (fib 10)
  print (add1 10)
