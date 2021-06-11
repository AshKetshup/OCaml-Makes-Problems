# Problema B

## Geração de palavras a partir de gramaticas
---
## Problema:

* Considere uma gramatica algebrica G = (;N;P;S ) com possivelmente produções epsilon.
* Escreva um programa que lê um inteiro n e uma gramatica G 
* Calcule o conjunto de palavras de tamanho menor ou igual a n. 
* Estas palavras serão listadas por ordem alfabetica, uma por linha.
--- 
## Entrada

### Para simplicar o formatos dos dados em entrada admitiremos aqui que: 

* os simbolos não terminais são representadas por nomes (string) começados por **MAIUSCULAS**;
* e os simbolos terminais são constituidos exclusivamente por **minusculas**. 
* Em particular o simbolo inicial sera sempre o não-terminal **S**.
* Uma produção tera sempre o formato **N ->** em que uma sequência não vazia de simbolos (terminais ou não-terminais separados por um espaço). 
  * Em particular o simbolo **€ (epsilon)** e representado pelo caracter **_ (underscore)**.

### O formato dos dados em entrada e então o seguinte.

* Na primeira linha consta o inteiro n que e o inteiro que representa o tamanho maximo das palavras por gerar.
* Na segunda linha consta um inteiro m que indica quantas produções tem a gramatica.
* As restantes m linhas introduzem as produções da gramatica (uma por linha).

## Saida

***Imagine que a gramatica em entrada gere k palavras distintas de tamanho menor ou igual a n, então a saida do programa são estas k palavras, ordenadas alfabeticamente, uma por linha.***

#### Exemplo de entrada

```
2
11
S -> A
S -> B D e 
A -> A e 
A -> e
B -> d
B -> C C 
C -> e C
C -> e
C -> _
D -> a D 
D -> a
```

#### Exemplo de Saida

```
ae e ee
1
```