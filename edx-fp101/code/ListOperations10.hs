combinations :: Int -> [a] => [[a]]
combinations _ [] = []
combinations 1 xs = map (\x -> [x]) xs
combinations n (x:xs) = map (x:)(combinations (n-1) xs) ++ combinations n xs
