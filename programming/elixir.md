# プログラミングElixir独習

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [第1章　`赤いカプセルを取れ`](#%E7%AC%AC1%E7%AB%A0%E3%80%80%E8%B5%A4%E3%81%84%E3%82%AB%E3%83%97%E3%82%BB%E3%83%AB%E3%82%92%E5%8F%96%E3%82%8C)
  - [1.1](#11)
  - [パイプラインによる変換の組み合わせ](#%E3%83%91%E3%82%A4%E3%83%97%E3%83%A9%E3%82%A4%E3%83%B3%E3%81%AB%E3%82%88%E3%82%8B%E5%A4%89%E6%8F%9B%E3%81%AE%E7%B5%84%E3%81%BF%E5%90%88%E3%82%8F%E3%81%9B)
  - [関数 = データ変換器](#%E9%96%A2%E6%95%B0--%E3%83%87%E3%83%BC%E3%82%BF%E5%A4%89%E6%8F%9B%E5%99%A8)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 第1章　`赤いカプセルを取れ`

 Elixirは普遍的な状態を用いた関数プログラミングと並行性(concurrent)へのactorベースのアプローチをモダンな文法にラップしたもの

### 1.1

 - プログラミングではデータを隠蔽したいのではなく、変換したい。
 - 私たちは仕事を済ませたいのであって、維持したいのではない。

### パイプラインによる変換の組み合わせ

 コマンドパイプラインは並列に実行できる。

 ```bash
 grep Elixir *.pml | wc -l
 ```

 上の例だと、 `wc` と `grep` は並列に実行される。`grep` により出力された先から `wc` に渡され処理される。

 Elixirで書かれた以下の `pmap` はこのような並列性を示唆するものである。

 ```elixir
 defmodule Parallel do
  def pmap(collection, func) do
    collection
      |> Enum.map(&(Task.async(fn -> func. (&1) end)))
      |> Enum.map(&Task.await/1)
  end
end

result = Parallel.pmap 1..1000, &(&1, * &1)
```

これは1000個のバックグラウンドプロセスを起動する。


### 関数 = データ変換器

Elixirでの問題の解き方はUnix シェルと同様であり、コマンドライン関数の代わりにElixirの関数がある。
関数を並列に走らせたり、互いにmessage passingをさせたりできる。
プログラミング一般の考え方では、関数は入力を出力に変換させるものである。
オブジェクト指向の考え方に慣れていると大変かもしれませんが、関数型を楽しくやっていこう！
みたいな良い話
