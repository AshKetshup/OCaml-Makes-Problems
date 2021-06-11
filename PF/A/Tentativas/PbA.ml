let got_42 = ref false

let check_which_rules m = 
	((m mod 2) = 0, ((m mod 3) = 0 || (m mod 4) = 0), ((m mod 5) = 0))

let is_42 value = if value = 42 then got_42 := true; value

(* Main *)
let () = 
	let next_step balance = (* generates a list of possible balance *)
		let (r1, r2, r3) = check_which_rules balance in
		(if r1 then
			let x = is_42 (balance/2) in
			if x < 42 then [] else [x]
		else [])
		@
		(if r2 then 
			let x = is_42 (balance - (balance mod 10 * ((balance mod 100)/10))) in
			if x = balance || x < 42 then [] else [x]
		else [])
		@
		(if r3 then
			let x = is_42 (balance - 42) in
			if x < 42 then [] else [x]
		else [])
	in
	let rec exec lsd step =
		if !got_42 then Printf.printf "%d\n" step
		else
			let x = List.concat_map next_step lsd in
			if x = [] then Printf.printf "BAD LUCK\n" else exec x (step+1)
	in
	let n = read_int () in
	if n = 42 then got_42 := true;
	exec [n] 0