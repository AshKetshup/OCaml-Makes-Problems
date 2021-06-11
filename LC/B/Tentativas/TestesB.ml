open Printf
exception Input_Invalido

let rec insertchar lst k =
    if k > 0 then
      let c = Scanf.sscanf (read_line()) "%s" (fun c-> (c)) in
      formin = formin @ [c];
      insertchar formin (k-1)
    else  List.iter (printf "%s ") formin

let rec conclusivo lista k =
  if k > 0 then
    match hd with
      |"(" -> 
      |")" ->
      |"|" -> 
      |"&" ->
      |"!" ->
      |"-" ->
      |"<" -> 
      |_ ->


    type variavel = string
    type formula = 
      | ParD
      | ParE
      | Implica of formula * formula
      | Equivale of formula * formula
      | Ou of formula * formula
      | E of formula * formula
      | Nao of formula
      | Var of variavel
      | Verdade
      | Falso

let rec fbf formin =
  match formin with
    | Var v -> v
    | Verdade -> "T"
    | Falso -> "F"
    | Implica(f, g) -> ("( "^ fbf f ^ " - " ^ fbf  g ^" )")
    | Equivale(f, g) -> ("( "^ fbf f ^ " < " ^ fbf  g ^" )")
    | E(f, g) -> ("( "^ fbf f ^ " & " ^ fbf g ^" )")
    | Ou(f, g) -> ("( "^ fbf f ^ " | " ^ fbf g ^" )")
    | Nao f -> ("!"^ fbf f )

let () =
  let k = Scanf.sscanf (read_line()) "%d" (fun k-> (k)) in
    let formin = []
    m=k
    insertchar formin k;
    conlusivo formin m;
    if fbf formin then
      Printf.printf "YES"
    else 
      Printf.printf "NO"