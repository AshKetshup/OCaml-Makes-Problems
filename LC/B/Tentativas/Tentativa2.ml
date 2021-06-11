let valor = ref 0 
let steck = Stack.create ()
let saida () = 
  Printf.printf "NO\n";
  exit 0

let matchar c =
  match c with
  |"&" -> "Op"
  |"|" -> "Op"
  |"(" -> 
    valor := !valor + 1;
    "ParE"
  |")" -> 
    valor := !valor - 1;
    if !valor = -1 then saida else "ParD"
  |"->" -> "Op"
  |"<->" -> "Op"
  |"!" -> "Nega"
  |_ -> "Var"

let rec leitura n =
  if n > 0 then
    let c = Scanf.sscanf (read_line()) "%s" (fun c -> (c)) in
    let s = matchar c in
    s :: leitura (n-1)
  else
  if !valor <> 0 then saida else [];

(* VERIFICAR PARTE DE TRÁS *)

let verifyOPb str =
  try Some(if (Stack.pop steck) = ("var" || "ParD") then () else saida) with stack_empty -> saida;

let verifyNb str =
  try Some(if (Stack.pop steck) = ("Nega" || "Op" || "ParD") then () else saida) with stack_empty -> None;

let verifyParEb str =
  try Some(if (Stack.pop steck) = ("Nega" || "Op" || "ParD") then () else saida) with stack_empty -> None;

let verifyParDb str =
  try Some(if (Stack.pop steck) = ( "var" || "ParD" ) then () else saida) with stack_empty -> saida;

let verifyVarb str =
  try Some(if (Stack.pop steck) = ( "Nega" || "Op" || "ParE" ) then () else saida) with stack_empty -> None;

(* VERIFICAR PARTE DA FRENTE *)

let verifyOPf str =
  if (List.nth str 1) = ( "var" || "ParE" || "Nega" ) then () else saida
  Stack.push (List.hd str) steck;

let verifyNf str =
  if (List.nth str 1) = ( "Nega" || "ParE" || "var" ) then () else saida
  Stack.push (List.hd str) steck;

let verifyParEf str =
  if (List.nth str 1) = ( "Nega" || "var" || "ParE" ) then () else saida
  Stack.push (List.hd str) steck;

let verifyParDf str =
  if (List.nth str 1) = ( [] || "Nega" || "Op" || "ParD" ) then () else saida
  Stack.push (List.hd str) steck;

let verifyVarf str =
  if (List.nth str 1) = ( "Op" || "ParD" || [] ) then () else saida
  Stack.push (List.hd str) steck;

let recursive s n =
  if n <> 0 then begin
    match List.hd with
    |"Op" -> begin
      try Some (verifyOPb s) with e -> saida;
      verifyOPf s
    end
    |"Nega" -> begin
      verifyNb s;
      verifyNf s
    end
    |"ParE" -> begin
      verifyParEb s;
      verifyParEf s
    end
    |"ParD" -> begin
      try Some (verifyParDb s) with e -> saida;
      verifyParDf s
    end
    |_ -> begin
      verifyVarb s;
      verifyVarf s
    end
    recursive (List.tl s (n-1))
  end else Printf.printf "YES\n"

let () = 
  let k = Scanf.sscanf (read_line()) "%d" (fun k -> (k)) in
  if k >= 100 || k <= 0 then saida
  else begin
    let str = leitura k in
    recursive str k
  end