let valor = ref 0 

let saida () = 
  Printf.printf "NÃO\n";
  exit 0

(*let rec sublist b e l = 
    match l with
    |[] -> failwith "sublist"
    |h :: t -> 
      let tail = if e=0 then [] else sublist (b-1) (e-1) t in
      if b>0 then tail else h :: tail*)

let verificador () =
  match str with
  |"var"^"E"^"var" -> "var"
  |"var"^"Ou"^"var" -> "var"
  |"var"^"Implica"^"var" -> "var"
  |"var"^"Equivalente"^"var" -> "var"
  |_ -> saida

let matchar c =
  match c with
  |"&" -> "E"
  |"|" -> "Ou"
  |"(" -> 
    valor := !valor + 1;
    "ParE"
  |")" -> 
    valor := !valor - 1;
    if !valor = -1 then saida else "ParD"
  |"->" -> "Implica"
  |"<->" -> "Equivalente"
  |"!" -> "Nega"
  |_ -> "Var"

let rec leitura n =
  if n <> 0 then
    let c = Scanf.sscanf (read_line()) "%s" (fun c -> (c)) in
    let s = matchar c in
    s :: leitura (n-1)
  else
  if !valor <> 0 then saida else [];

let () = 
  let k = Scanf.sscanf (read_line()) "%d" (fun k -> (k)) in
  leitura k