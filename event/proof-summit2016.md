# Proof Summit 2016
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [@ksknac さん「Bコンビネータの話」](#ksknac-%E3%81%95%E3%82%93%E3%80%8Cb%E3%82%B3%E3%83%B3%E3%83%93%E3%83%8D%E3%83%BC%E3%82%BF%E3%81%AE%E8%A9%B1%E3%80%8D)
- [@kaizen_nagoya さん: 「JAXA/IPA クリティカルソフトウェアワークショップ　言語系発表とその後」](#kaizen_nagoya-%E3%81%95%E3%82%93-%E3%80%8Cjaxaipa-%E3%82%AF%E3%83%AA%E3%83%86%E3%82%A3%E3%82%AB%E3%83%AB%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%83%E3%83%97%E3%80%80%E8%A8%80%E8%AA%9E%E7%B3%BB%E7%99%BA%E8%A1%A8%E3%81%A8%E3%81%9D%E3%81%AE%E5%BE%8C%E3%80%8D)
- [@erutuf13 さん: Coq で機械学習した話](#erutuf13-%E3%81%95%E3%82%93-coq-%E3%81%A7%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92%E3%81%97%E3%81%9F%E8%A9%B1)
  - [NVL : nested vector language](#nvl--nested-vector-language)
  - [Machine Learning の話](#machine-learning-%E3%81%AE%E8%A9%B1)
  - [Fiat](#fiat)
- [@pi8027 さん: 「線形算術の量化子除去の原理」](#pi8027-%E3%81%95%E3%82%93-%E3%80%8C%E7%B7%9A%E5%BD%A2%E7%AE%97%E8%A1%93%E3%81%AE%E9%87%8F%E5%8C%96%E5%AD%90%E9%99%A4%E5%8E%BB%E3%81%AE%E5%8E%9F%E7%90%86%E3%80%8D)
  - [何につかえるのか](#%E4%BD%95%E3%81%AB%E3%81%A4%E3%81%8B%E3%81%88%E3%82%8B%E3%81%AE%E3%81%8B)
  - [Farkas の補題](#farkas-%E3%81%AE%E8%A3%9C%E9%A1%8C)
- [@eldesh さん: 「VerifastによるPOSIX正規表現マッチングの検証に向けて」](#eldesh-%E3%81%95%E3%82%93-%E3%80%8Cverifast%E3%81%AB%E3%82%88%E3%82%8Bposix%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%8F%BE%E3%83%9E%E3%83%83%E3%83%81%E3%83%B3%E3%82%B0%E3%81%AE%E6%A4%9C%E8%A8%BC%E3%81%AB%E5%90%91%E3%81%91%E3%81%A6%E3%80%8D)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# @ksknac さん「Bコンビネータの話」

Bコンビネータ :=> コンポジション

```
C : (Q -> R) -> (P -> Q) -> (P -> R)
```

* `n-arg functions`

```
(Q -> R) -> (P1 -> Pn -> Q) -> (P1 -> Pn -> Q)
```

```
B^2 = B * B = BBB
B^3 = B * B * B = BBBBBBB
 -> B(BBB)B
 -> BB(BB)BB
 -> B(BB)BBBBBBB
 -> BBBBBBBBBBBB
```

 * B^4 は存在しない


# @kaizen_nagoya さん: 「JAXA/IPA クリティカルソフトウェアワークショップ　言語系発表とその後」

形式的検証などの研究が実用に結びつきにくいという問題

WOCS: Workshop on critical software systems

クリティカルソフトウェアワークショップ2011

「状態遷移の種類と形式検証の使い所」など

英語でスライドつくってslideshareに上げると海外の人が読んでくれるので英語で書くと良い

岡部さん : かつて Haskell で OS を書こうとしていた人（すごい頑張られる方）(www.masterq.net)
how to rewrite strong type などの論文書いてる
VeriFast と ATS の比較とか
CのヘッダファイルをATSに変換するライブラリとかあげてる

ATS と XMOS の動き

Alloy は図が作れるらしい

SPINはシーケンス図を自動生成する、検討範囲の確認の助けになる
論理系の状態遷移と状態方程式を組み合わせる模型の作り方

- お願いしたいこと

言語の機能、処理について教えたいときに順序を示して順序よく教えることが重要
キラーアプリケーションを題材にするといい

RTL設計スタイルガイド

"JAXA/IPA クリティカルソフトウェアワークショップ"は御茶ノ水でやるので東京の人は来てほしい

# @erutuf13 さん: Coq で機械学習した話

ICFPでパソコン壊れて黒板で発表

Adam Chipala さんのとこに行ってたらしい(!)

## NVL : nested vector language
SparkとかTensorFlowの代替言語として開発されている
これをCoqで検証付きで実装している

## Machine Learning の話

- 教師つき学習
たとえば画像を入力で取ってきて複数値判定する
数学的には `R^n -> R` の写像

- 教師データ
なんかいっぱい画像を用意してそれに1,0でラベリングする（二値判定の場合）

`{(🐱, 1), (⭐️, 0), …}`

教師データをもとに a_0 x^n + ... + a_n x みたいな多項式にパラメータをうまく与えてやるといい感じにほしい関数が近似できる

- ニューラルネット(single layer)

```
x < Rn |-> W x. + b (W は M(n,m), b はRm)
e(x) = tanh(x)
=> e(\sigmaW_ij x_j + bi)
```

- ニューラルネット(multi layer)

Deep Learning みたいなやつ

```
e1*** + ... ei(\sigmaW_ij x_j + bi) + ... + bk
```
みたいに e が多層になる

ここの係数を探していい感じの関数をCoqでつくる

適当にやって w's, bs などのパラメータに誤差が出て来る
この誤差を最小化していく（有名なやつだと勾配法）

- 勾配法(Gradient Decent)

`f : R^n -> R` みたいな関数に対して
`x(0)` みたいな初期値をとり、これを
`x(n+1) = x(n) - c * \delta f(x_n)` という漸化式で近似

`c * \delta f(x_n)` : 傾きに対して逆向きのベクトル

勾配をプログラムで計算

`(f: R -> R) ~~> \delta f` は必ずしも出せない

## Fiat

仕様を書いて、そこからプログラムを作っていくというのをサポートするもの

Mostly Automated Synthesis of Correct-by-Construction Programs http://plv.csail.mit.edu/fiat/
https://github.com/mit-plv/fiat

勾配法とかを例にとると、
```
is_grad (f f': R->R) : Prop
```
のとき
```
Definition grad (f: R->R): Comp(R->R) :=
 {f' | is_grad f f'}%comp.
```
のように書ける

`is_grad`のような二項関係があった時に、そこから関数を作りたい時に
`Comp`(戻り値の型)というコンストラクタと{ _ | _ }のような`syntax`を使って定義する手法。
全域関数になるかはわからないので`Comp`というコンストラクタにはいる

fiatの式で書くと

```
Definition : gd. x_0 : Comp R :=
f' <- grad f
ret (gd' f' c x_0)
```

↑f' に fの勾配が代入された気持ち
ちょっとついていけなくなってきた...

例
`(x - a)^2`
に対する勾配をfiatで書くと
```
Lemma guad_grad (a : R) :
{f' | refine (grad (fnn x => (x - a)^2))}
(ret f')}%type
```

Fiatには`refine`という型コンストラクタがある

`refine`で中身を書き換えられる

`Comp` は `Free Monad` っぽい？

https://github.com/mit-plv/fiat/blob/311cf123ba377d6c792b3a24db69d654917e9db0/src/Computation/Core.v#L5

機械学習を定式化するのすごい気合を感じる

# @pi8027 さん: 「線形算術の量化子除去の原理」

紙の資料を配られていたので、こちらにはあまりメモ残していません
一般的な量化子除去QEの原理を与える
有理数、有理数や実数の順序体に関する一次不等式の理論では Fourier-Motzkin 消去法が知られている
自然数、実数に関する一次不等式の理論（プレスバーガー算術）として幾つかの手法がある

## 何につかえるのか
- 決定可能であるという事実が自動証明に使われている
- Farkas の補題などはコンピュータサイエンスで広く応用されている
- 例えば整数のみのベクトルの集合、例) 文字の出現回数だけの情報に対し、pressburger で定義可能(semi-linear)

`Coq` でほとんど証明している
https://github.com/pi8027/vass

以下やらなかったsection 5, 6 の内容
## Farkas の補題
Fourier-Motzkin 消去法の応用
m * n 行列 A と m 次元ベクトル b において以下の 2 条件は同値である。

```
(exists x ∈ F^n_>=0). Ax = b - (1)
(forall y ∈ F^m) . 0 ≦ A^T y => 0 ≦ B^T y - (2)
```

より一般化したい(integral domain + order)

# @eldesh さん: 「VerifastによるPOSIX正規表現マッチングの検証に向けて」

- 一般的な正規表現

```ocaml
Regex
 = eps (空列)
 | \phi (何もマッチしない EOF)
 | l (symbol)
 | r1 + r2 (or)
 | r1 r2 (並び)
 | r1 * (0回以上のマッチ)
```


- 微分に関する幾つかの性質
```
r\l

r1 + r2\l = r1 \ l + r2 \ l
r1r2 \ l = {
 (r1 \ l) r2 + r2 \ l  ... \epsilon ∈ L(r1)
 (r1 \ l) r2
}
r1 *\ l = (r1 \ l) r1 *
l_1 \ l_2 {
\epsilon if l_1 = l_2
\phi
}
```

parsable関数は以下のようになる

```
parsable r [ ] = \epsilon ∈ L(r1)
      r lw = parse (r\l) w
```

```
|- [] : r*
|- v : r |- vs : r*
-------------------
|- (v :: vs) : r*
```

```
|- v1 : r1 |- v2 : r2
-------------------
|- (v1,  v2) : r1r2
```

```
|- v1 : r1
-------------------
|- Left v1 : r1 + r2
```

```
|- () : eps
|- v2 : r2
-------------------
|- Right v2 : r1 + r2
```

- POSIX マッチング戦略

```
POSIX(v, r) = forall v2 |- c2 : r ∧ |v2| = |v|
-> v ≧_r v2
```

Left vs Right の比較の強さは A1, A2 で、 len の比較に等号が入るかどうかであり
Right vs Right, Left vs Left は単に >_1  で比べている。

http://www.home.hs-karlsruhe.de/~suma0002/publications/regex-parsing-derivatives.pdf
