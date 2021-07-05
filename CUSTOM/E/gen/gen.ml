

let print_matrix matrix =
    let size = Array.length matrix.(0) in
    let procedure_per_line line =
        Array.iteri (fun i x -> Printf.printf "%d%c" x (if i = size - 1 then '\n' else ' ')) line 
    in
    Array.iter (fun x -> procedure_per_line x) matrix
	
let fill_matrix (h, w) = 
	let matrix = Array.make_matrix h w 0 in
	let () = Array.iteri (
		fun i row -> Array.iteri (
			fun j _ -> if Random.bool () then matrix.(i).(j) <- 1
		) row
	) matrix in
	matrix

let () = 
	Random.init (read_int ());
	let h = (Random.int 21474) + 2 in
	let w = (Random.int 21474) + 2 in 
	(* let d = 21474 in *)
	Printf.printf "%d\n%d\n" h w;
	(h, w) |> fill_matrix |> print_matrix