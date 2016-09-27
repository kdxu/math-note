　# プログラミングElixir独習
 
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

