# Problema F

## Encontrar padrões regulares em ramos de ADN - BIS

### Problema - Este problema e uma variante do Problema C

* Um ramo de ADN e uma sequência nita de nucleotídeos adenina (A), citosina (C), guanina (G) e timina (T). 
* Consideremos para esse efeito o alfabeto A = fA;C;G;T g.
* Neste exercício pretendemos implementar um mecanismos de procura eciente de padrão regular num ramos de ADN. 
Por padrão entendemos uma disposição de nucleotdeos (i.e. caracteres A,C,G,T) que possa ser expressa por uma expressão regular sobre A.
* O objectivo deste exercício e, dada uma expressão regular sobre o alfabeto A e dado um ramos de ADN, mostrar onde ocorre no dado ramo de ADN a primeira sequncia de nucleotídeos que se assemelha ao padrão, de forma eficiente, claro. Por primeira entendemos que começa e termina em primeiro lugar.
* Para esse efeito fornece-se um conjunto de funções, em particular a função regexp que traduz uma string numa expressão regular. Estas funç~oes deverão ser copiadas integralmente no cabeçalho da vossa solução.
* Recomenda-se igualmente a leitura do artigo : [Regular Expression Search algorithm (link)](https://www.fing.edu.uy/inco/cursos/intropln/material/p419-thompson.pdf) e das paginas : 
  * [Regular Expression Matching Can Be Simple And Fast (link) ](https://swtch.com/~rsc/regexp/regexp1.html)
  * [A Regular Expression Matcher (link)](https://www.cs.princeton.edu/courses/archive/spr09/cos333/beautiful.html)
---
## Input

* A entrada consiste em duas linhas.
* A primeira linha e o padrão por procurar na forma de uma string. A sintaxe deste padrão e a sintaxe concreta esperada de uma expressão regular e espera-se que leia a referida string com a funçãoregexp fornecida.
* A linha seguinte contem a string que dene um ramos de ADN (exclusivamente constituída dos caracteres 'A', 'C', 'G' e 'T')

## Output

* A saida é organizada numa só linha. 
* Se o ramo contem uma sequência de nucleotideo que cumpre o padrão então nesta linha constam dois inteiros i j que indicam onde começa e termina a primeira substring que cumpre o padrão (as posições começam em 0). 
* No caso especial em que a string vazia veri ca o padrão então a resposta devera ser YES. A linha contem NOno caso em que não existe tal sequência.

## Limites

* O padrão tem um comprimento maximo 100, e adequadamente processado pela função regexp. 
* O ramo de ADN tem um comprimento positivo não nulo e e no maximo 5000.
* Tenha em atenção que os tempos de resolução consideram que a solução e eciente (linear, no m ínimo).

--- 

### Sample Input
```
(TAG+TC)(A+C+G+T)*TGC
ATTGCAGTAGGACTCGCCTGATGCAGTC
```
### Sample Output
```
7 23
```