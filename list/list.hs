module Main where

mySum :: [Int] -> Int      -- Intのリストを受け取ってIntを返す
mySum [] = 0               -- リストがからなら0を返す
mySum(x:xs) = x + mySum xs -- 先頭xと残りxsに分解して x + 残りの合計
-- : は先頭と残りに分ける

main :: IO()
main = do
  print (mySum [1,2,3,4,5])
  print (mySum [])
  print (mySum [10, 20, 30])
