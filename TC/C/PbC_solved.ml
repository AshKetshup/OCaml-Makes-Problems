(* 41330 - João Pedro Martins Pires Marques Freire
 * 41266 - Diogo Castanheira Simões 
 * 
 * Problema C
 *)

exception FitaOutOfBounds of string * int         (* Posição negativa na fita (demasiado à esquerda) *)
exception TuringTimeout                           (* Máquina demorou demasiado tempo *)
exception TuringVoidTransition of string * int    (* Não há transições para a posição atual *)

(* Caracter branco e limite de execução *)
let branco   = '#'
let branco_s = "#"
let fim      = 200


(* Classe para gerir a fita de forma simplificada *)
class fita init = object (self)
  (* Posição atual na fita *)
  val mutable p : int = 0

  (* Sequência de bytes que representa a fita *)
  val mutable s : bytes = Bytes.init (String.length init) (fun i -> init.[i])

  (* Passos dados até ao momento (limite do problema: 200) *)
  val mutable k : int = 0

  (* Move a fita para a esquerda e levanta exceção se for para uma posição inválida *)
  method esquerda =
    p <- p - 1;
    k <- k + 1;
    if p < 0 then raise (FitaOutOfBounds (self#fita, self#passos))

  (* Move a fita para a direita e redimensiona a fita com um caracter branco caso seja necessário. *)
  method direita =
    p <- p + 1;
    k <- k + 1;
    if p >= Bytes.length s then s <- Bytes.cat s (Bytes.of_string branco_s)
  
  (* Determina automaticamente para que sentido andar conforme a direção indicada. É case-insensitive. *)
  method andar d =
    match d with
    | 'R' | 'r' -> self#direita
    | 'L' | 'l' -> self#esquerda
    | _         -> ()

  (* Definir o caracter na posição atual *)
  method definir c = Bytes.set s p c
  
  (* Devolve o caracter da posição atual *)
  method ch = Bytes.get s p
  
  (* Devolve a fita "truncada" em formato string *)
  method fita =
    try
      let i = Bytes.index_from s (p - 1) branco in Bytes.sub_string s 0 (i + 1)
    with _ -> (Bytes.to_string s) ^ branco_s

  (* Devolve a posição atual na fita *)
  method pos = p

  (* Devolve o número de passos dados até ao momento *)
  method passos = k
end


(* Tipos de dados *)
type transicao      = { a : char;  b : char;  d : char;  j : int; }     (* Transição com etiqueta "a", escreve "b" na fita, desloca-se no sentido "d" e passa ao estado "j" *)
type transicoes     = (int, transicao) Hashtbl.t                        (* Para cada estado da máquina (hash key) existe uma série de transições possíveis (bindings) *)
type estados_finais = int list                                          (* Lista de estados finais possíveis *)
type turing         = transicoes * fita * int * estados_finais          (* Máquina de Turing inclui tabela de transições, fita, estado atual e lista de estados finais *)


(* Executar a Máquina de Turing com as transições "t", fita "f", posição "p" e estados finais "ef". *)
let executar ((t, f, p, ef) : turing) =
  let rec exec f p =
    if f#passos > fim then raise TuringTimeout                 (* Exceção: mais de 200 passos *)
    else
      if List.mem p ef then (f#fita, f#passos)                 (* Estado final encontrado *)
      else
        let l = List.filter (fun {a; b; d; j} -> a = f#ch) (Hashtbl.find_all t p)
        in if l = [] then raise (TuringVoidTransition (f#fita, f#passos))    (* Exceção: não há transições disponíveis *)
        else
          let c, d, j = (fun {a; b; d; j} -> b, d, j) (List.hd l) in
            f#definir c;            (* Definir o novo caracter atual na fita *)
            f#andar d;              (* Andar para a esquerda ou a direita - pode dar exceção FitaOutOfBounds *)
            exec f j                (* Executar a próxima instrução *)
  in exec f p


(* Constrói uma Máquina de Turing dadas as transições "t", a palavra "p" e o conjunto de estados finais "f" *)
let construir_turing t p f : turing = (t, new fita p, 1, f)


(* Lê as transições para uma Hash Table *)
let ler_transicoes n m : transicoes =
  let ler () = Scanf.scanf " %d %c %c %c %d" (fun i a b d j -> i, {a = a; b = b; d = d; j = j}) in
  let h      = Hashtbl.create n in
  let ()     = Array.iter (fun (i, t) -> Hashtbl.add h i t) (Array.init m (fun _ -> ler ()))
  in h

(* Lê uma linha com os estados finais *)
let ler_estados_finais () = List.map (int_of_string) (String.split_on_char ' ' (read_line ()))


(* Faz o output formatado em caso de sucesso *)
let saida ok (fita, passos) = Printf.printf "%s\n%s\n%d\n" (if ok then "YES" else "NO") fita passos


(* main *)
let () =
  let p = read_line () in             (* Palavra *)
  let n = read_int () in              (* Conjunto Q = {1..n} *)
  let _ = read_int () in              (* Cardinalidade do conjunto f *)
  let f = ler_estados_finais () in    (* Conjunto f dos estados finais *)
  let m = read_int () in              (* Cardinalidade de δ *)
  let t = ler_transicoes n m in       (* Transições *)
    try
      saida true (executar (construir_turing t p f))
    with
      | FitaOutOfBounds      (fita, passos)
      | TuringVoidTransition (fita, passos) -> saida false (fita, passos)
      | TuringTimeout                       -> print_endline "DON'T KNOW"


(* Bibliografia
 * -> Aulas teóricas do professor.
 * 
 * Webografia
 * -> https://caml.inria.fr/pub/docs/manual-ocaml/libref/Hashtbl.html
 * -> https://caml.inria.fr/pub/docs/manual-ocaml/libref/Bytes.html#VALset
 * -> https://dev.realworldocaml.org/classes.html
 *)