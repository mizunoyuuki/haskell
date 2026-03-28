module Main where

myMap :: (Int -> Int) -> [Int] -> [Int]
myMap f [] = []
myMap f(x:xs) = f x : myMap f xs

double :: Int -> Int
double n = n * 2

square :: Int -> Int
square n = n * n

main :: IO()

main =  do
  print (myMap double[1,2,3,4,5])
  print (myMap square[1,2,3,4,5])
  print (myMap (\x -> x + 10)[1,2,3,4,5])
