<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [すごいHaskell楽しく学ぼう](#%E3%81%99%E3%81%94%E3%81%84haskell%E6%A5%BD%E3%81%97%E3%81%8F%E5%AD%A6%E3%81%BC%E3%81%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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
