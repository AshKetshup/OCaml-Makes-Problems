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
        if !valor = -1 then saida () else "ParD"
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
    if !valor <> 0 then saida () else []

(* VERIFICAR PARTE DE TRÁS *)

let verifyOPb ()=
    try let x = Stack.pop steck in
    (if (x = "Var" ||x = "ParD") then () else saida()) with stack_empty -> saida()

let verifyNb () =
    try let x = Stack.pop steck in
    (if ( x = "Nega" || x = "Op" || x = "ParE" ) then () else saida()) with stack_empty -> ()

let verifyParEb ()=
    try let x = Stack.pop steck in
    (if ( x = "Nega" || x = "Op" || x = "ParE" ) then () else saida()) with stack_empty -> ()

let verifyParDb ()=
    try let x = Stack.pop steck in
    (if ( x = "Var" || x = "ParD" ) then () else saida()) with stack_empty -> saida()

let verifyVarb ()=
    try let x = Stack.pop steck in
    (if ( x = "Nega" || x = "Op" || x = "ParE" ) then () else saida()) with stack_empty -> ()
(* VERIFICAR PARTE DA FRENTE *)

let verifyOPf s =
    if List.length s > 2 then begin
    let x = List.nth s 1 in
    if not (List.mem x ["Var"; "ParE"; "Nega"]) then saida () end;
    let y = List.hd s in
    Stack.push y steck

let verifyNf s =
    if List.length s > 2 then begin
    let x = List.nth s 1 in
    if not (List.mem x ["Nega"; "ParE"; "Var"]) then saida () end;
    let y = List.hd s in
    Stack.push y steck

let verifyParEf s =
    if List.length s > 2 then begin
    let x = List.nth s 1 in
    if not (List.mem x ["Nega"; "ParE"; "Var"]) then saida () end;
    let y = List.hd s in
    Stack.push y steck

let verifyParDf s =
    if List.length s > 2 then begin
    let x = List.nth s 1 in
    if not (List.mem x ["Nega"; "ParD"; "Op"]) then saida() end;
    let y = List.hd s in
    Stack.push y steck

let verifyVarf s =
    if List.length s > 2 then begin
    let x = List.nth s 1 in
    if not (List.mem x ["ParD"; "Op"]) then saida() end;
    let y = List.hd s in
    Stack.push y steck

    (* Erros Em Baixo (38) *)

let rec recursive s n =
    if n > 0 then
        let () = match s with
        |h::t -> begin
            match h with
            |"Op" -> begin 
                verifyOPb ();
                verifyOPf s
            end
            |"Nega" -> begin
                verifyNb ();
                verifyNf s
            end
            |"ParE" -> begin
                verifyParEb ();
                verifyParEf s
            end
            |"ParD" -> begin
                verifyParDb ();
                verifyParDf s
            end
            |_ -> begin
                verifyVarb ();
                verifyVarf s
            end
        end
        |_-> ()
        in let m = List.tl s in
            recursive m (n-1)
    else Printf.printf "YES\n"

let () =
    let k = Scanf.sscanf (read_line()) "%d" (fun k -> (k)) in
    if k > 100 || k <= 0 then saida()
    else begin
        let str = leitura k in
        recursive str k
    end