module Main where

x :: Int
x = 21 + 21

main :: IO()
main = x `seq` return()
