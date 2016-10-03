# プログラミングElixir独習

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [第1章　`赤いカプセルを取れ`](#%E7%AC%AC1%E7%AB%A0%E3%80%80%E8%B5%A4%E3%81%84%E3%82%AB%E3%83%97%E3%82%BB%E3%83%AB%E3%82%92%E5%8F%96%E3%82%8C)
  - [1.1](#11)
  - [パイプラインによる変換の組み合わせ](#%E3%83%91%E3%82%A4%E3%83%97%E3%83%A9%E3%82%A4%E3%83%B3%E3%81%AB%E3%82%88%E3%82%8B%E5%A4%89%E6%8F%9B%E3%81%AE%E7%B5%84%E3%81%BF%E5%90%88%E3%82%8F%E3%81%9B)
  - [関数 = データ変換器](#%E9%96%A2%E6%95%B0--%E3%83%87%E3%83%BC%E3%82%BF%E5%A4%89%E6%8F%9B%E5%99%A8)
- [第2章](#%E7%AC%AC2%E7%AB%A0)
  - [代入](#%E4%BB%A3%E5%85%A5)
  - [リストのマッチ](#%E3%83%AA%E3%82%B9%E3%83%88%E3%81%AE%E3%83%9E%E3%83%83%E3%83%81)
  - [アンダースコア](#%E3%82%A2%E3%83%B3%E3%83%80%E3%83%BC%E3%82%B9%E3%82%B3%E3%82%A2)
  - [pin operator](#pin-operator)
  - [パイプ演算子](#%E3%83%91%E3%82%A4%E3%83%97%E6%BC%94%E7%AE%97%E5%AD%90)
  - [モジュール](#%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB)
    - [モジュールのディレクティブ](#%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%86%E3%82%A3%E3%83%96)
    - [モジュール属性](#%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E5%B1%9E%E6%80%A7)
  - [Elixir, Erlang, アトム](#elixir-erlang-%E3%82%A2%E3%83%88%E3%83%A0)
    - [Erlangライブラリの呼び出し](#erlang%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AE%E5%91%BC%E3%81%B3%E5%87%BA%E3%81%97)
- [第7章 リストと再帰](#%E7%AC%AC7%E7%AB%A0-%E3%83%AA%E3%82%B9%E3%83%88%E3%81%A8%E5%86%8D%E5%B8%B0)
- [第8章 マップ、キーワードリスト、セット、構造体](#%E7%AC%AC8%E7%AB%A0-%E3%83%9E%E3%83%83%E3%83%97%E3%80%81%E3%82%AD%E3%83%BC%E3%83%AF%E3%83%BC%E3%83%89%E3%83%AA%E3%82%B9%E3%83%88%E3%80%81%E3%82%BB%E3%83%83%E3%83%88%E3%80%81%E6%A7%8B%E9%80%A0%E4%BD%93)
  - [map vs keyword list](#map-vs-keyword-list)
  - [キーワードリスト](#%E3%82%AD%E3%83%BC%E3%83%AF%E3%83%BC%E3%83%89%E3%83%AA%E3%82%B9%E3%83%88)
  - [マップ](#%E3%83%9E%E3%83%83%E3%83%97)
    - [パターンマッチ](#%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%83%9E%E3%83%83%E3%83%81)
    - [パターンマッチはキーに値を束縛できない](#%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%83%9E%E3%83%83%E3%83%81%E3%81%AF%E3%82%AD%E3%83%BC%E3%81%AB%E5%80%A4%E3%82%92%E6%9D%9F%E7%B8%9B%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84)
  - [マップの更新](#%E3%83%9E%E3%83%83%E3%83%97%E3%81%AE%E6%9B%B4%E6%96%B0)
- [構造体](#%E6%A7%8B%E9%80%A0%E4%BD%93)

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

## 第2章

### 代入

```elixir
iex > a = 1
1
iex > 1 = a
1
iex > 2 = a
 //=> MatchError

```

Elixirの比較は代入というより代数的な比較に近い。

### リストのマッチ

- 練習問題
[[a]] = [[1, 2, 3]]
[a,b] = [1, 2, 3]
はマッチされない。なぜなら、値の中に対応する  `単一の`項がないからだ。

### アンダースコア

```elixir
iex> [1, 2, _] = [1,2,3]
```
ワイルドカード的に使える。

### pin operator


```elixir

iex> a = 1
1
iex> a = 2
2
iex>^a = 1
#\> MatchError
```

すでにある変数の値を使いたいときはキャレット(^)演算子を用いる。

Elixirではすべてのデータが不変である。いわゆるストリクトな関数型とここらへんは近い。

```elixir
defmodule Chop do
  def guess(actual, a..b) do
    midp = a + div(b-a, 2)
    IO.puts("Is it #{midp}")
    compare(actual, midp, a..b)
  end

  defp compare(actual, midpoint, _.._) when actual == midpoint do
    IO.puts("It is #{actual}")
  end

  defp compare(actual, midpoint, a.._) when actual < midpoint do
    guess(actual, a..midpoint)
  end

  defp compare(actual, midpoint, _..b) when actual >= midpoint do
    guess(actual, midpoint..b)
  end

end

```


### パイプ演算子

```elixir
filling = DB.find_customers
          |> Orders.for_customers
          |> sales_tax(2015)
          |> prepare_filling
```

`|>`　演算子は左の項の式の結果をとって右の関数の第一パラメータとして渡すことができる。

`val |> f(a,b)` === `f(val, a, b)` となる。

### モジュール

定義するものにネームスペースを提供する。

```elixir
defmodule Mix.Tasks.Doctest do
  def run do
  end
end
```

Elixirは単純に外側のモジュールの名前を内側のモジュールの名前にドットを挟んで定義している

#### モジュールのディレクティブ

- import ディレクティブ

モジュールの関数やマクロをカレントスコープに持ってくる。

```elixir

defmodule Example do
  def func1 do
    List.flatten [1, [2,3], 4]
  end
  def func2 do
    import List, only: [flatten: 1]
    flatten [5,[6,7],8]
  end
end

```

`import List, only: [flatten:1, duplicate:2]`

- alias ディレクレィブ

```elixir

defmodule Example do

  def compile do
    alias My.Other.Module.Parser, as: Parser
    source
      |> Parser.parse
  end

end

```

モジュール名のエイリアスを作るディレクティブ。

- require ディレクティブ

モジュールで定義したマクロを使う時にそのモジュールをrequireするとマクロ定義が有効になっていることが保証されるらしい。詳しくはマクロの章で。

#### モジュール属性

```elixir

defmodule Example do
  @author "Dave Thomas"
  def get_author do
    @author
  end
end

```
メタデータの属性に`@name value`で値を与えることができる。
同じ属性に何度も値を与えることもできる。定数のようなもの

### Elixir, Erlang, アトム

Elixirのモジュールの名前はアトムに過ぎない。
`IO` などの大文字から始まる名前を書いた時`Elixir.IO`という名前に内部で変換される。

```
iex(IEX-8684@gergate)1> is_atom IO
true
iex(IEX-8684@gergate)2> to_string IO
"Elixir.IO"
iex(IEX-8684@gergate)3> "Elixir.IO" === IO
false
iex(IEX-8684@gergate)4> :"Elixir.IO" === IO
true
```

`IO.puts`は`:"Elixir.IO".puts` というふうに呼び出すこともできる。

#### Erlangライブラリの呼び出し

```elixir
iex(IEX-8684@gergate)5> :io.format("The number is ~3.1f~n", [5.678])
The number is 5.7
:ok
```

小文字のアトムとして呼び出す。

- 練習問題

1. `:lists.flatten(:io_lib.format("~p", [3.14]))``
2. `System.get_env`
3. `Path.extname("aa/aa.txt")`
4. `System.cwd`
5. https://github.com/h4cc/awesome-elixir#json
6. `:os.cmd(pwd)`

## 第7章 リストと再帰

このへんはHaskellやAgdaで慣れているのでさらっと

```elixir
iex(IEX-8684@gergate)13> [head | tail] = [1,2,3]
[1, 2, 3]
iex(IEX-8684@gergate)14> head
1
iex(IEX-8684@gergate)15> tail
[2, 3]
```

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)
end
```

```elixir
iex(IEX-8684@gergate)17> MyList.len([1,2,3])
3
iex(IEX-8684@gergate)18> MyList.len([])
0
```

うんうんNilとConsだね

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do:[]
  def square([head | tail]), do: [head*head | square(tail)]
end
```

末尾再帰 :innocent:

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do:[]
  def square([head | tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([head | tail], func) do: [func.(head) | map(tail, func)]
end
```

```elixir

iex(IEX-8684@gergate)22> MyList.map [1,2,3,4], fn (n) -> n*n end
[1, 4, 9, 16]

```

`List.map`だね

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum(list), do: _sum(list, 0)

  # private function
  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum([tail], head + total)

end
```

ヘルパー関数を使って再帰的にsumを実装

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum(list), do: _sum(list, 0)

  # private function
  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum([tail], head + total)

  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end
end
```

`foldLeft`!

- 練習問題

1.
```elixir
def mapsum(list, func) do
  reduce(map(list, func), 0, (&(&1 + &2)))
end
```

2.
```elixir
def max([]), do: 0
def max([head | tail]),do: reduce([head | tail], head, &(compare(&1, &2)))

def compare(p1, p2) when p1 > p2, do: p1
def compare(p1, p2) when p1 <= p2, do: p2
```

3.
```elixir
def caesar(list, n) do
  map(list, fn x -> _decode_char(x, n) end)
end

defp _decode_char(char, num) when char + num > 122 do
  char + num - 26
end
defp _decode_char(char, num) when char + num < 122 do
    char + num
end
```

4.
```elixir
def span(from, to) when from < to do
  [from | span(from + 1, to)]
end
def span(from, to) when from == to, do: [to]
```

## 第8章 マップ、キーワードリスト、セット、構造体

### map vs keyword list

- パターンマッチを行いたい時はmap
- 同じキーを持つエントリが複数現れる時はkeyword
- 要素の順番を保証しないといけない時はkeyword
- それ以外はmap

### キーワードリスト

```elixir
defmodule Canvas do
  @defaults [fg: "black", bg: "white", font: "Merriweather"]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Foreground : #{options[:fg]}"
    IO.puts "Background : #{Keyword.get(options, :bg)}"
    IO.puts "Font : #{Keyword.get(options,:font)}"
    IO.puts "Style : #{inspect Keyword.get_values(options, :style)}"
  end
end
```

### マップ

```elixir

iex(IEX-8684@gergate)67> map = %{name: "Dave", likes: "Programming", where: "Daras"}
%{likes: "Programming", name: "Dave", where: "Daras"}
iex(IEX-8684@gergate)68> Map.keys map
[:likes, :name, :where]
iex(IEX-8684@gergate)69> Map.values map
["Programming", "Dave", "Daras"]
iex(IEX-8684@gergate)70> map[:name]
"Dave"
iex(IEX-8684@gergate)71> map1 = Map.d
delete/2    drop/2
iex(IEX-8684@gergate)71> map1 = Map.drop map, [:where, :likes]
%{name: "Dave"}
iex(IEX-8684@gergate)72> map1 = Map.p map, [:where, :likes]
pop/2             pop/3             pop_lazy/3        put/3
put_new/3         put_new_lazy/3
iex(IEX-8684@gergate)72> map1 = Map.put map, :also_likes, "Ruby"
%{also_likes: "Ruby", likes: "Programming", name: "Dave", where: "Daras"}
iex(IEX-8684@gergate)73> Map.has_key? map1, :where
true
iex(IEX-8684@gergate)74> {value, updated_map} = Map.pop map1, :also_likes
{"Ruby", %{likes: "Programming", name: "Dave", where: "Daras"}}

```

MapのAPIでいろいろできる

#### パターンマッチ

```elixir
iex(IEX-8684@gergate)75> person = %{name: "Dave", height: 1.88}
%{height: 1.88, name: "Dave"}
iex(IEX-8684@gergate)76> %{name: a_name} = person
%{height: 1.88, name: "Dave"}
iex(IEX-8684@gergate)77> a_name
"Dave"
iex(IEX-8684@gergate)78> %{name: _, height: _} = person
%{height: 1.88, name: "Dave"}
iex(IEX-8684@gergate)79> %{name: "Dave"} = person
%{height: 1.88, name: "Dave"}
iex(IEX-8684@gergate)80> %{name: _, weight: _} = person
** (MatchError) no match of right hand side value: %{height: 1.88, name: "Dave"}

```

キーや値に対してパターンマッチをすることができる。

```elixir
people = [
  %{ name: "Grumpy", height: 1.24 },
  %{ name: "Dave", height: 1.88 },
  %{ name: "Dopey", height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Snezzy", height: 1.28 }
]

IO.inspect(for person = %{height: height} <- people, height > 1.5, do: person)
#=> [%{height: 1.88, name: "Dave"}, %{height: 2.16, name: "Shaquille"}]
```

マップのリストを内包表記してそれぞれのマップをpersonに束縛し変数heightでフィルタし、doブロックでperson全体を出力している。


#### パターンマッチはキーに値を束縛できない

`%{2 => state} = %{1 => :ok, 2 => :error}`

はできるけど、

`%{item => :ok} = %{1 => :ok, 2 => :error}`

のように書くことはできない。

ピン演算子に変数を束縛することもできる。

```elixir

iex(IEX-8684@gergate)81> data = %{name: "Dave", state: "TX", likes: "Elixir"}
%{likes: "Elixir", name: "Dave", state: "TX"}
iex(IEX-8684@gergate)82> for key <- [:name, :likes] do
...(IEX-8684@gergate)82> %{^key => value} = data
...(IEX-8684@gergate)82> value
...(IEX-8684@gergate)82> end
["Dave", "Elixir"]

```

### マップの更新

```elixir
new_map = %{old_map | key => value, ...}
```

のような書き方でマップを更新できる。
新しいキーをマップに追加するには `Map.put_new/3`を使う。

## 構造体

```elixir
defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end
```
