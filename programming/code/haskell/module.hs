module Main where

import           Data.List
import qualified Data.Map  as Map
numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub
-- \xs -> length (nub xs) と同型
findKey :: (Eq k) => k -> [(k,v)] -> Maybe v
findKey _ [] = Nothing
findKey key ((k,v):xs)
    | key == k = Just v
    | otherwise = findKey key xs
findKey' :: (Eq k) => k -> [(k,v)] -> Maybe v
findKey' key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing
main :: IO ()
main = putStrLn "Hello World"

phonebook :: Map.Map String String
phonebook = Map.fromList [("betty", "1010101")]

data Shape = Circle Float Float Float | Rectangle Float Float Float Float
             deriving (Show)

data Person = Person { firstName                :: String
                                  , lastName    :: String
                                  , age         :: Int
                                  , height      :: Float
                                  , phoneNumber :: String
                                  , flavor      :: String
                                  } deriving (Show)
data Maybe' a = Nothing' | Just' a

data Car a b c = Car { company :: a
                     , model   :: b
                     , year    :: c
                     } deriving (Show)

tellCar :: (Show a) => Car String String a -> String
tellCar Car {company = c, model = m, year = y} = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y

data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n  
