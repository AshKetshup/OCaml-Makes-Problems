## Problema C 

# Validade de fórmulas FNC

O problema por resolver neste exercício consiste em averiguar se uma FNC é uma tautologia
ou não, usando o resultado (Lema 8.1) que estabelece quando um disjuntório de literais é
uma autologia e quando um conjuntório de tais disjuntórios o é igualmente.
Recorda-se que este Lema destaca que um disjuntório que contém **`T`** ou um literal e a
sua negação é necessáriamente válido.

## Tarefa

Ler a fórmula em entrada que está em forma normal conjunctiva, calcular e estatuar se é
uma fórmula válida ou não.

## Input

Na primeira linha é introduzido o inteiro `n`, o número de disjuntórios.
* As `n` linhas seguintes introduzem individualmente cadadisjuntório da FNC.
* Por exemplo **`(A ∨ T ∨ ⊥ ∨ ¬B)`** é introduzida numalinha como:
	`A 1 0 ~B`
onde *`0`* é **`⊥`**, *`1`* é **`T`** e ` ̃` é a **`negação`**. Como apresentado no exemplo, cadaelemento do disjuntório é separado dos outros por umespaço.

## Restrições

* Os identificadores de variáveis são formados exclusivamente por letras.
* O número de variáveis diferentes é limitado a 100. `0 < n < 100`

## Output

Uma linha com a palavra `VALIDA` caso a FNC seja válida ou `NAO E VALIDA` no caso contrário.

## Input 1

```
4
~p p q
~p p s
~q ~s p q
~q ~s p s
```

## Output 1

```VALIDA```

## Input 2

```
4
~p s q
~p r s
~q ~s p
~q 0 p s
```

## Output 2

```NAO E VALIDA```
