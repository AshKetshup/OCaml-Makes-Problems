## Problema A

# Quantas cavalgadas?

Para começar a série de exercícios desta unidade curricular, eis um problema elucidativo. Espera-se que defina uma resolução recursiva mas também que tente definir uma solução concisa, eficaz e elegante.

## Problema

* Considere um tabuleiro de xadrez `N` por `N` e um **cavalo** posicionado na **célula `(a, b)`** (com 0 ≤ `a`, `b` < `N`).
* Levanta-se a questão seguinte, dado um inteiro natural positivo **`k`** (i.e. `k > 0`), quantas caminhos de cumprimento **`k`** e exclusivamente dentro dos limites do tabuleiro, o cavaleiro pode tomar.

O seu desafio é responder a esta questão.

## Formato de entrada

A entrada deste exercício consiste numa linha onde consta os 4 inteiros `N`, `k`, `a` e `b`, separados por um espaço.

## Formato de saida

Uma linha com o inteiro **`M`** que indica quantas calvagadas de cumprimento **`k`** diferences são possiveis no tabuleiro partindo de **`(a, b)`**.

## Limites

```
1 ≤ N ≤ 50,  1 ≤ k ≤ 8
```

## Exemplo de entrada

```
4 2 0 0
```

## Exemplo de saida

```
8
1
```