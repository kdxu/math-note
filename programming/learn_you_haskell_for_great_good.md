# すごいHaskell楽しく学ぼう

最新の stack ghciでは

```haskell
Prelude> :load module.hs
```

のように外部モジュールをインポートする

```haskell
Map.lookup :: Ord k => k -> Map.Map k a -> Maybe a
```


if ... then ... else  より Control.Monad.unless
で

```haskell
main = do
    line <- getLine
    unless (null line) $ do
            putStrLn line
            main
```

みたいに書いたほうがいい
