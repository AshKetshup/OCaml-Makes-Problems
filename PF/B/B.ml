(* Autor - Diogo Simões | 41266 *)

exception Not_Matrix_Size

type color = W | B 
type image =
| Leaf of color
| Node of image * image * image * image (* nw * ne * sw * se *)

(** Contador de folhas *)
let leaf_count = ref 0

(** Nivel da folha mais alto *)
let lower = ref Int.max_int

(** Devolve o quadrado do numero inteiro [x] *)
let square x = x*x


(** Função de debug tradução de Image para String *)
let rec string_of_image = function
    | Leaf W -> "WHITE"
    | Leaf B -> "BLACK"
    | Node (nw, ne, sw, se) -> 
        "Node (" ^ 
        string_of_image nw ^ ", " ^ 
        string_of_image ne ^ ", " ^ 
        string_of_image sw ^ ", " ^ 
        string_of_image se ^ 
        ")"


(** Outputs [matrix] *)
let print_matrix matrix =
    let size = Array.length matrix.(0) in
    (** Imprime o conteudo de cada array [line] *)
    let procedure_per_line line =
        Array.iteri (fun i x -> Printf.printf "%d%c" x (if i = size - 1 then '\n' else ' ')) line 
    in
    (* Executa [procedure_per_line] para cada um dos arrays contido em [matrix]*)
    Array.iter (fun x -> procedure_per_line x) matrix


(** Lê os valores de entrada [extensão], [(dimx, dimy)] e [p], juntamente com a [matriz] *)
let read_input () = 
    (* lê o nome do ficheiro (não importante) e é descartado *)
    let _ = read_line () in
    (* recolhe a dimensão da matriz (como a mesma será sempre quadrada só precisamos do primeiro valor) *)
    let dim = Scanf.sscanf (read_line ()) "%d %d" (fun a _ -> a) in
    (* inicializa a matriz com dimensão dim*dim a zeros *)
    let matrix = Array.make_matrix dim dim 0 in
    (* procedimento responsavel por preencher a matriz inicial com os inputs do teclado *)
    let rec create_matrix size curr =
        (* 
        * 	lê a linha input
        * 	-> separa a mesma por espaços numa lista 
        * 	-> passa a Array 
        * 	-> mapeia de array de strings para array de ints 
        *)
        let get_array_from_line () = 
            () |> read_line |> String.split_on_char ' ' |> Array.of_list |> Array.map int_of_string
        in
        (* Atribui a cada elemento do array *)
        if curr < size then (
            matrix.(curr) <- get_array_from_line ();
            create_matrix size (curr + 1)
        )
    in
    let create_matrix () = create_matrix dim 0 in
    let () = create_matrix () in
    (matrix, read_int ())


(** Constroi a arvore a partir da [matrix] *)
let rec split_image iteration matrix =
    (** cumprimento da metade da matriz *)
    let length = Array.length matrix / 2 in
    (** primeiro elemento da matriz *)
    let fst = matrix.(0).(0) in
    (** 
    Booleano verdadeiro quando poder ser splitted mais uma vez. 
        (Quando todos os elementos da matriz não forem iguais) 
    *)
    let is_splitable = 
        not (Array.for_all (fun a -> Array.for_all (fun b -> b = fst) a) matrix)
    in
    (** Preenche a matriz correspondente ao quadrante assinalado por [(x,y)] *)
    let rec create_submatrix mat size curr (x,y) =
        if curr < size then (
            mat.(curr) <- Array.sub matrix.(curr + y*size) (x*size) (size);
            create_submatrix mat size (curr+1) (x,y)
        ) else mat
    in
    (** Produz uma submatriz no quartil [(x, y)] *)
    let create_submatrix (x, y) = 
        create_submatrix (Array.make_matrix length length 0) length 0 (x,y) 
    in
    (* Caso seja possivel dividir: *)
    if is_splitable then
        (** Gera a submatriz do quadrante indicado pelo tuplo *)
        let procedure tuple = tuple |> create_submatrix |> split_image (iteration+1) in
        (* Gera o nó com os ramos correspondente a cada um dos quadrantes. *)
        Node (procedure (0,0), procedure (1,0), procedure (0,1), procedure (1,1))
    (* Caso não possamos dividir mais: *)
    else 
        (* atualiza a contagem de folhas encontradas *)
        let () = leaf_count := !leaf_count + 1 in
        (* atualiza o nivel da folha mais baixa *)
        let () = if !lower  > iteration then lower := iteration in
        (* Identifica a cor da folha *)
        match fst with
        | 0 -> Leaf W
        | _ -> Leaf B


(** Extrai da [image] a [thumbnail] requisitada *)
let get_thumbnail original size image =
    (* Matriz do tamanho da thumbnail inicializada a 0s *)
    let thumbnail = Array.make_matrix size size 0 in
    (* Encarregue de preêncher a thumbnail com os valores calculados *)
    let rec fill_thumbnail p curr (x,y) =
        if curr < p then (
            let () = Array.fill thumbnail.(curr + y) x p 1 in
            fill_thumbnail p (curr + 1) (x, y)
        )
    in
    (** Encarregue de preêncher a thumbnail com os valores calculados *)
    let fill_thumbnail p (x, y) = fill_thumbnail p 0 (x, y) in
    (** Calcula a cor na respetiva posição *)
    let rec get_value n = function
        | Leaf W -> 0
        | Leaf B -> square n
        | Node (nw, ne, sw, se) ->
            get_value (n/2) nw + get_value (n/2) ne + get_value (n/2) sw + get_value (n/2) se
    in
    (** Traduz o nó numa folha *)
    let node_to_leaf n image = 
        if get_value n image >= (square n) / 2 then Leaf B else Leaf W in
    (** Percorre a arvore prêenchendo a thumbnail e devolvendo a arvore *)
    let rec correr_arvore n p (x, y) = function
        | Leaf B -> (fill_thumbnail p (x,y); Leaf B)
        | Leaf W -> Leaf W
        | Node (nw, ne, sw, se) when p > 1 ->
            (** Correr a arvore para o quadrante especificado por [(a,b)] *)
            let procedure (a, b) img = 
                correr_arvore (n/2) (p/2) (x+a * p/2, y+b * p/2) img 
            in
            Node (procedure (0, 0) nw, procedure (1, 0) ne, procedure (0, 1) sw, procedure (1, 1) se)
        | image -> node_to_leaf n image |> correr_arvore n p (x,y)
    in 
    let _ = correr_arvore original size (0,0) image	in 
    thumbnail

(* Main *)
let () = 
    (* Input *)
    let matrix, p = 
        try read_input () with 
        | Not_Matrix_Size -> exit 1
    in
    (* Calculo da thumbnail *)
    let thumbnail = 
        matrix |> split_image 0 |> get_thumbnail (Array.length matrix.(0)) p 
    in
    (* Output *)
    Printf.printf "%d\n%d\n" !lower !leaf_count;
    print_matrix thumbnail


(* Exemplo de Execução: *)
(* Input: 
 *    P1                    Nome do ficheiro (Valor ignorado)
 *    8 8                   Dimensão da matriz
 *    0 0 0 0 1 0 1 0       Matriz de input
 *    0 0 0 0 0 0 0 1
 *    0 0 0 0 0 0 1 1
 *    0 0 0 0 0 1 1 1
 *    0 0 0 0 1 1 1 1
 *    0 0 0 0 1 1 1 1
 *    0 0 0 1 1 1 1 1
 *    0 0 1 1 1 1 1 1
 *    4                     Dimensão quadrada da thumbnail
 *
 *)

(* Calculo da thumbnail: 
 *
 *   Recebido a matriz vindo do input (chamemos de matrix) passamos agora ao 
 * calculo da thumbnail.
 *   
 *   1o Passo: 
 * Separar a thumbnail e traduzir numa `image` atravez da função `split_image` 
 * (ao gerar a arvore calculamos também o `lower` e `leaf_count`).
 * 
 * ```
 * image gerada =
 *   Node (
 *       WHITE, 
 *       Node (
 *           Node (BLACK, WHITE, WHITE, WHITE), 
 *           Node (BLACK, WHITE, WHITE, BLACK), 
 *           Node (WHITE, WHITE, WHITE, BLACK), 
 *           BLACK
 *       ), 
 *       Node (
 *           WHITE, 
 *           WHITE, 
 *           WHITE, 
 *           Node (WHITE, BLACK, BLACK, BLACK)
 *       ), 
 *       BLACK
 *   )
 * lower = 1  
 * leaf_count = 22
 * ```
 *
 *   2o Passo: 
 * Agora apartir da `image` gerada vamos construir uma matriz nova (thumbnail)
 * inicializada a 0s e com a dimensão da thumbnail dada durante o input que ao 
 * voltarmos a percorrer a `image` calculamos os valores certos da seguinte 
 * forma:
 *      
 *      Vamos percorrer a arvore recursivamente para os 4 nós correspondentes e
 *      a cada iteração da mesma dividimos o tamanho de p por 2.
 *          Caso nos deparemos com uma Leaf B (antes de p ser 1) enviamos as 
 *      coordenadas do quadrante atual juntamente com o valor de p que permitirá 
 *      calcular quais serão os elementos da thumbnail necessarios preencher.
 *          Caso encontremos uma Leaf W (antes de p ser 1) não fazemos nada pois
 *      a thumbnail é previamente preenchida com 0s.
 *          No caso de p deixar de ser maior que 1, passamos a transformar o Node
 *      em que nos encontramos em `Leaf` calculando qual a `Leaf` prevalente no
 *      Node e preenchendo nas coordenadas indicada na thumbnail o valor corres-
 *      pondente (1 caso Leaf B e não precisamos de fazer nada caso Leaf B).
 *      
 * (Para possivel debug devolve-se sempre a `image`)     
 * Devolvemos por fim a thumbnail alterada pronta para output.
 * 
 *)

(* Output: 
 *
 * !lower:                 1
 * !leaf_count:            22
 * print_matrix thumbnail: 0 0 0 1
 *                         0 0 0 1
 *                         0 0 1 1
 *                         0 1 1 1
 *)
