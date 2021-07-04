

let print_matrix matrix =
    let size = Array.length matrix.(0) in
    let procedure_per_line line =
        Array.iteri (fun i x -> Printf.printf "%d%c" x (if i = size - 1 then '\n' else ' ')) line 
    in
    Array.iter (fun x -> procedure_per_line x) matrix
	
let () = 
	Random.init (read_int ());
	(* let h = (*(Random.int 500000) + 2*) 65536 in
	let w = (*(Random.int 500000) + 2*) 65536 in *)
	let d = 21474 in
	let matrix = Array.make_matrix d d 0 in
	let () = Array.iteri (
		fun i row -> Array.iteri (
			fun j _ -> if Random.bool () then matrix.(i).(j) <- 1
		) row
	) matrix
	in
	Printf.printf "%d\n%d\n" d d;
	print_matrix matrix