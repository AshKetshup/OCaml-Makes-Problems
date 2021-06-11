(* 41330 - João Pedro Martins Pires Marques Freire
 * 41266 - Diogo Castanheira Simões 
 * 
 * Problema B
 *)

exception RegraInvalida

(* Tipos de dados *)
type simbolo =
  | Epsilon
  | Terminal    of string
  | NaoTerminal of string

type regra = simbolo list
type gramatica = (string, regra) Hashtbl.t

type regexp =
  | V  
  | E
  | C of string
  | U of regexp * regexp 
  | P of regexp * regexp 
  | S of regexp


(* Tipos de dados do Problema A *)
type etiqueta = string option
type transicao = int * etiqueta
type automato = transicao list array


(* Converte uma string num símbolo *)
let simbolo_of_string s =
  match s.[0] with
  | c when c >= 'a' && c <= 'z' -> Terminal s
  | c when c >= 'A' && c <= 'Z' -> NaoTerminal s
  | c when c =  '_'             -> Epsilon
  | _ -> failwith "simbolo_of_string falhou"

let rec string_of_regexp s =
  match s with
  | V        -> "0"
  | E        -> "1"
  | C  c     -> c
  | U (f, g) -> "(" ^ (string_of_regexp f) ^ " + " ^ (string_of_regexp g) ^ ")"
  | P (f, g) -> "(" ^ (string_of_regexp f) ^ " . " ^ (string_of_regexp g) ^ ")"
  | S  s     -> (string_of_regexp s) ^ "*"


(* Função dada pelo professor: devolve a lista sem repetidos *)
let normalize l =
  let tbl = Hashtbl.create (List.length l) in
  let f l e = try let _ = Hashtbl.find tbl e in l
              with Not_found ->  Hashtbl.add tbl e (); e::l
  in  List.rev (List.fold_left f [] l)


(* Primeiro e segundo elemento de um 2-tuplo *)
let prim (a, _) = a
let seg  (_, b) = b


(* Dado pelo professor no ano letivo anterior
 * Função que simplifica "um pouco" a expressão regular
 * Realiza uma simplificação maior do que a que foi sugerida no enunciado do problema 
 *)  
let rec simplify (a:regexp) = 
  match a with 
  | U (r,s) ->
    let sr = simplify r in
    let ss = simplify s in
    if sr = V then ss
    else if ss = V then sr
    else if ss = sr then sr
    else U (sr,ss) 
  | P (r,s) ->
    let sr = simplify r in
    let ss = simplify s in
    if sr = V then V
    else if ss = V then V
    else if sr = E then ss
      else if ss = E then sr
    else P (sr,ss) 
  | S r -> let sr = simplify r in
    if sr = V || sr = E 
    then E else (
      match sr with
        U (E,rr) | U (rr,E) -> S rr       
        | _ -> S sr
      )
  |  _ -> a


let regex_of_gramatica (g : gramatica) =
  let rec regra (sg : gramatica) r memoria =
    List.fold_left (fun a b ->
      U (a, List.fold_left (fun c d ->
        P (c, simbolo (Hashtbl.copy sg) r d (if d = NaoTerminal r then r :: memoria else memoria))
      ) E b)
    ) V (Hashtbl.find_all sg r)
  and simbolo (sg : gramatica) orig s memoria =
    match s with
    | Terminal c    -> C c
    | NaoTerminal c ->
      let sg = Hashtbl.copy sg in
      let () = Hashtbl.remove sg orig in
      let res = regra sg c (c :: memoria) in if List.mem c memoria && c <> "S" then S res else res
    | Epsilon       -> E
  in
    regra g "S" []


(* Calcula o autómato dada a expressão regular "r" (fonte: problema A) *)
let calcular_automato (g : gramatica) r =
  let rec calcular r a i l m =
    (* União ( A+B ) *)
    let uniao f g =
      let a = Array.append a (Array.make 4 []) in
        a.(i)   <- [(m+1, None); (m+2, None)];
        a.(m+3) <- [(l, None)];
        a.(m+4) <- [(l, None)];
      let (xl, a) = calcular f a (m+1) (m+3) (m+4) in
      let (yl, a) = calcular g a (m+2) (m+4) xl in
        (yl, a)
    in

    (* Produto ( A.B ) *)
    let produto f g =
      let a = Array.append a (Array.make 1 []) in
        a.(i)   <- [(m+1, None)];
        a.(m+1) <- [(l, None)];
      let (xl, a) = calcular f a i (m+1) (m+1) in
      let (yl, a) = calcular g a (m+1) l xl in
        (yl, a)
    in

    (* Fecho ( A* ) *)
    let fecho s =
        let a = Array.append a (Array.make 2 []) in
          a.(i)   <- [(l, None); (m+1, None)];
          a.(m+2) <- [(m+1, None); (l, None)];
        let (xl, a) = calcular s a (m+1) (m+2) (m+2) in
          (xl, a)
    in

      (* função calcular *)
      match r with
      | V        -> a.(i) <- []; (m, a)                 (* Vazio *)
      | E        -> a.(i) <- [(l, None)]; (m, a)        (* Epsilon *)
      | C  c     -> a.(i) <- [(l, Some c)]; (m, a)      (* Caracter *)
      | U (f, g) -> uniao f g
      | P (f, g) -> produto f g
      | S  s     -> fecho s

  in
    (* função calcular_automato *)
    let (_, a) = calcular r [|[]; []|] 0 1 1
    in a


let solucao (a : automato) (n : int) =
  (* Salta os épsilons no autómato sem entrar num ciclo infinito *)
  let saltar_epsilons (i : int) =
    let rec saltar (i : int) (v : int list) =  (* v é o registo por onde já passou *)
      let f (k, l) =
        match l with
          | None   -> if a.(k) <> [] then (if not (List.mem k v) then saltar k (k :: v) else [("", k)]) else [("", k)]
          | Some c -> [(c, k)]
      in
      List.concat (List.map f a.(i))
    in saltar i []
  in
  let resposta = ref [] in
  let res = ref [(0, "")] in
  let rec verificar i =
    if i = 0 then List.filter (fun s -> String.length s <= n) !resposta
    else begin
      res := normalize (List.concat (List.map (fun (y, st) -> List.map (fun (newst, z) -> (z, st ^ (if newst = "" then "" else if newst.[0] >= 'a' && newst.[0] <= 'z' then newst else ""))) (saltar_epsilons y)) !res));
      resposta := (List.map seg (List.filter (fun (y, _) -> y = 1) !res)) @ !resposta;
      res := List.filter (fun (y, st) -> y <> 1) !res;
      verificar (i - 1)
    end
  in List.sort (Stdlib.compare) (normalize (List.filter ((<>) "") (verificar (n + 1))))


(* Input *)
let entrada () = 
  let regra_of_string x =
    match String.split_on_char ' ' x with
    | hd :: tl -> (hd, List.map simbolo_of_string (List.tl tl))
    | _ -> raise RegraInvalida
  in
  let rec get_regras m : gramatica =
    let h  = Hashtbl.create m in
    let () = Array.iter (fun (r, p) -> Hashtbl.add h r p) (Array.init m (fun _ -> regra_of_string (read_line ())))
      in h
  in
    let n = read_int () in
    let m = read_int () in
    let regras = get_regras m in
      (n, m, regras)


(* Output *)
let saida resposta = List.iter print_endline resposta


(* main *)
let () =
  let n, m, g = entrada () in
  let rex = regex_of_gramatica g in
  let aut = calcular_automato g rex in
  let sol = solucao aut n in
    saida sol
