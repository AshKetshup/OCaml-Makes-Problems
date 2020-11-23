Problema G

Gerac~ao de palavras a partir de gramaticas

Problema

Considere uma gramatica algebrica G = (;N;P;S ) com possivelmente produc~oes epsilon.

Escreva um programa que l^e um inteiro n e uma gramatica G e que calcule o conjunto de palavras de tamanho menor ou igual a n. Estas palavras ser~ao listadas por ordem alfabetica, uma por linha.

Entrada

Para simplicar o formatos dos dados em entrada admitiremos aqui que os smbolos n~ao terminais

s~ao representadas por nomes (string) comecados por maiusculas e os smbolos terminais s~ao consti- tudos exclusivamente por minusculas. Em particular o smbolo inicial sera sempre o n~ao-terminal S. Uma produc~ao tera sempre o formato N -> em que e uma sequ^encia n~ao vazia de smbolos (terminais ou n~ao-terminais separados por um espaco). Em particular o smbolo  e representado pelo caracter \_ (underscore).

O formato dos dados em entrada e ent~ao o seguinte.

Na primeira linha consta o inteiro n que e o inteiro que representa o tamanho maximo das palavras por gerar.

Na segunda linha consta um inteiro m que indica quantas produc~oes tem a gramatica.

As restantes m linhas introduzem as produc~oes da gramatica (uma por linha).

Sa da

Imagine que a gramatica em entrada gere k palavras distintas de tamanho menor ou igual a n, ent~ao a sada do programa s~ao estas k palavras, ordenadas alfabeticamente, uma por linha.

Exemplo de entrada

2

11

S -> A

S -> B D e A -> A e A -> e

B -> d

B -> C C C -> e C

C -> e

C -> \_

D -> a D D -> a

Exemplo de Sada

ae e ee

1
