(* Verifica se m é um múltiplo de d. *)
let (%) m d = m mod d = 0

(* Calcula o produto dos últimos dois dígitos de m. *)
let prod_of_last m = (m mod 10) * ((m / 10) mod 10)

let solve m =
  let win = ref false in
  let apply_rules x =
    let rule d f =
      if List.exists ((%) x) d then
        let y = x - f x in
        if y >= 42 && x <> y then (
          if y = 42 then win := true;
          [y]
        ) else []
      else []
    in
    (rule [2] (fun z -> z / 2)) @ (rule [3; 4] prod_of_last) @ (rule [5] (fun _ -> 42))
  in
  let rec run l s =
    if !win then s else let r = List.concat_map apply_rules l in if r = [] then -1 else run r (s + 1)
  in if m = 42 then 0 else run [m] 0

(* Bloco principal *)
let () =
  let r = solve (read_int ()) in
  if r >= 0 then Printf.printf "%d\n" r
  else print_endline "BAD LUCK"