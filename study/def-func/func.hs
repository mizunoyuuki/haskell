module Main where

fact :: Int -> Int
fact 1 =1
fact n = n * fact(n - 1)

main :: IO()
main = print (fact 3)




