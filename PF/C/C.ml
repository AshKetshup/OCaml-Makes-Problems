(* Autor - Diogo Simões | 41266 *)

(** Exceção levantada quando o sistema é comprovado não canonico. *)
exception Nao_Canonico of int

(** Lê o Input do utilizador devolve [sistema monetario] *)
let leitura n =
    (** Array inicializado de `n` elementos a `0` *)
    let resultado = 
        Array.make n 0 
    in
    (** Pede um inteiro por cada linha em `m` *)
    let rec exec m = 
        if m = 0 then resultado else (resultado.(m-1) <- read_int (); exec (m-1))
    in exec n

(** Avalia o sistema monetario.
 * Lista de moedas está ordenada do maior para o menor. *)
let avaliar sist = 
    (* Define a menor e a maior moeda do sistema dado *)
    let (menor, maior) = 
        sist.(Array.length sist - 1), sist.(0) 
    in
    (** Lista do sistema *)
    let sist = 
        Array.to_list sist 
    in
    (** Valor maximo a testar *)
    let max_test = 
        maior * 2
    in
    (** Hashtable vazia com maxtest elementos *)
    let h = 
        Hashtbl.create max_test 
    in
    (** Testa e compara ambos os algoritmos (otimo e guloso) *)
    let rec testa_isto pagamento = 
        (* Enquanto o valor a ser testado não estiver acima do maximo *)
        if not (pagamento >= max_test) then 
            (** gera lista trocavel filtrando o `sist` ao comparar o troco.
             *  Para cada elemento:
             *  - Caso `troco` for 0 então devolvemos `1`;
             *  - Caso `troco` for < que 0 devolvemos `None` (porque não 
             *  dá para fazer troco de negativos); 
             *  - Caso `troco` for < que a menor moeda existente devolvemos 0;
             *  - Caso nenhuma das anteriores será o resultado da pesquisa na 
             *  tabela hash +1;
             *)
            let trocavel = sist |> List.filter_map (
                fun moeda -> 
                    match (pagamento - moeda) with 
                    | 0 -> Some 1
                    | troco when troco < 0 -> None
                    | troco when troco < menor -> Some 0 
                    | troco -> Some (Hashtbl.find h troco + 1)
            ) in
            (** o valor guloso é encontrado sempre na cabeça da lista trocavel *)
            let guloso = 
                List.hd trocavel 
            in
            (** o valor otimo é definido pelo minimo de moedas usadas na cauda 
            ou quando a cauda da lista trocavel é vazia o proprio guloso *)
            let otimo = 
                let cauda = List.tl trocavel in
                if cauda = [] then 
                    guloso
                else 
                    List.fold_left min (List.hd cauda) cauda
            in
            (* Se o guloso for <= ao otimo ou o otimo for 0 então o pagamento 
            é valido e é adicionado com o pagamento como key juntamente com 
            a quantidade menor de moedas usadas. Caso contrario é levantada
            a exception `Nao_Canonico` com o valor pagamento. *)
            if guloso <= otimo || otimo = 0 then (
                Hashtbl.add h pagamento (
                    match guloso, otimo with
                    | gul, 0 when gul > 0 -> 0
                    | gul, _ when gul > 0 -> gul
                    | _, opt -> opt
                );
                testa_isto (pagamento+1)
            ) else
                raise (Nao_Canonico pagamento)
    in
    testa_isto menor

(* Main *)
let () = 
    (** Lê a quantidade de moedas *)
    let quant = read_int () in
    (** Lê o sistema de moedas *)
    let sistema = leitura quant in
    (* Tenta avaliar o sistema. Se passar sem levantar `exception Nao_canonico` 
    então é aprovado caso contrario é apresentado a que pagamento falhou. *)
    try avaliar sistema; print_endline "YES" with 
        Nao_Canonico n -> Printf.printf "%d\n" n


(* Exemplo de Execução: *)
(* Input:
 *      3       Quantidade de elementos que o sistema irá conter. 
 *      1       Elementos do sistema monetario:
 *      3       .
 *      4       .
 *
 *   resultado = [|4;3;1|]
 *)

(* Algoritmo:
 * Durante a minha pesquisa encontrei algures na internet que o minimo necessario 
 * de casos para determinar se o sistema é canonico seria o dobro do valor maximo
 * do mesmo. (Infelizmente não consegui voltar a encontrar o artigo)
 *  Logo sabemos que o minimo de tentativas a fazer é 2n.
 *  O algoritmo assume que o utilizador dê input por ordem crescente.
 * 
 *  A ideia é conseguir calcular o minimo de moedas (a partir de resultados ante-
 * riores) e comparar os resultados obtidos.
 * 
 * São definidos então os valores `menor` e `maior`.
 *   (menor, maior) = (1, 4)
 * 
 * Vamos então criar uma nova lista em que por cada moeda no sistema é filtrado pelo
 * gerar do troco (pagamento - moeda): 
 *  caso este troco = 0 então é devolvido 1;
 *  caso este troco < 0 então é devolvido None (Vazio);
 *  caso este troco < menor (menor elemento do sistema) então é devolvido 0;
 *  caso não seja nenhuma das condições anteriores então é porque precisamos de consultar
 * a tabela pelo já calculado `troco`.
 * 
 * (.) - Porque o resultado do guloso = optimal então é guardado na tabela 
 * (-) - É requisitado o troco na tabela e somado 1 ao resultado
 * _#_ - Resultado do guloso e optimal.
 * _#  - Resultado do guloso (sempre a cabeça da lista em questão).
 *  #_ - Resultado do optimal.
 *  X  - Não é calculado.
 * 
 * Neste caso o seguinte:
 *           4€  3€  1€
 *      1€         [_1_]    1 - 4 < 0   logo None;  1 - 3 < 0   logo None;  1 - 1 = 0  logo 1 (.)
 *      2€         [_2_]    2 - 4 < 0   logo None;  2 - 3 < 0   logo None;  2 - 1 = 1 (-) = 2 (.)
 *      3€     [_1_; 3 ]    3 - 4 < 0   logo None;  3 - 3 = 0  logo 1 (.);  3 - 1 = 2 (-) = 3    
 *      4€ [_1_; 2 ; 2 ]    4 - 4 = 0  logo 1 (.);  4 - 3 = 1 (-) = 2    ;  4 - 1 = 3 (-) = 2    
 *      5€ [_2_; 3 ; 2 ]    5 - 4 = 1 (-) = 2 (.);  5 - 3 = 2 (-) = 3    ;  5 - 1 = 4 (-) = 2    
 *      6€ [_3 ; 2_; 3 ]    6 - 4 = 2 (-) = 3    ;  6 - 3 = 3 (-) = 2    ;  6 - 1 = 5 (-) = 3    
 *      7€ [   ;   ;   ]    X | É levantada a exceção Nao_Canonico com o valor do pagamento (6),
 *      8€ [   ;   ;   ]    X | pois o optimal e o guloso não coincidem e por isso o sistema não é
 *                              canonico.
 *
 *  Visto que não chegamos ao final podemos anunciar o primeiro de caso em que falha.
 *  Seguimos então para o output.
 *)

(* Output:
 *      6
 *)


(* Consulta:
 *   "Determine if a coin system is Canonical" (stackexchange)
 *   https://codegolf.stackexchange.com/questions/96134/determine-if-a-coin-system-is-canonical
 *   
 *   "Canonical Coin Systems for Change-Making Problems by Xuan Cai"
 *   https://arxiv.org/pdf/0809.0400.pdf
 *   
 *   "The Change Making Problem - Fewest Coins To Make Change Dynamic Programming" 
 *   by Back To Back SWE (youtube)
 *   https://youtu.be/jgiZlGzXMBw
 *)