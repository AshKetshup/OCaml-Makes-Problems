exception Input_invalido
let value = ref true


let rec estaIncluido a b =
    match a, b with
    | "1", _    -> true
    | _, []     -> false
    | a, hd::tl ->
        let str =
            if String.contains a '~' then     (* Procurar por apenas a sem ~ na lista *)
                String.sub a 1 ((String.length a) - 1)
            else                              (* Procurar por a com ~ na lista *)
                "~" ^ a
        in if (List.mem str b) then true else estaIncluido hd tl


let rec funcao k = 
    if k > 0 then (
        let lista = read_line () |> String.split_on_char ' ' in
        if estaIncluido (List.hd lista) (List.tl lista) then
            funcao (k-1) 
        else
            value := false
    )


let () = 
    read_int () |> funcao; 
    if !value then 
        Printf.printf "VALIDA\n" 
    else 
        Printf.printf "NAO E VALIDA\n"