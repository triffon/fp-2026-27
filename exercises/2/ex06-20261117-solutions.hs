-- Зад.1
-- if then else
fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)

-- Зад.2
-- guard-ове (пазачи) - за разглеждане на случаи
fib2 n
  | n < 2     = n
  | otherwise = fib2 (n - 1) + fib2 (n - 2)

-- pattern matching - за предпочитане
fib3 0 = 0
fib3 1 = 1
fib3 n = fib3 (n - 1) + fib3 (n - 2)

-- case
fib4 n = case n of 0 -> 0
                   1 -> 1
                   _ -> fib4 (n - 1) + fib4 (n - 2)

-- Зад.3
fastPow _ 0 = 1
fastPow x 1 = x
fastPow x n
  | even n    = (fastPow x (div n 2))^2
  | otherwise = x * (fastPow x (div n 2))^2

-- Зад.4
-- Следните две дефиниции са еквивалентни - но коя е по-удобна?
--complAdd c1 c2 = (fst c1 + fst c2, snd c1 + snd c2)
complAdd (x1,y1) (x2,y2) = (x1+x2, y1+y2)
complSub (x1,y1) (x2,y2) = (x1-x2, y1-y2)
complMul (a,b) (c,d) = (a*b - c*d, a*d + b*c)

-- Зад.5
distance (x1,y1) (x2,y2) = sqrt (dx^2 + dy^2)
  where dx = (x1-x2)
        dy = (y1-y2)

-- Пример за локално дефинирани функции
prime 1 = False
prime n = loop 2
  where loop d
          | d == n       = True
          | mod d k == 0 = False
          | otherwise    = loop (d + 1)
