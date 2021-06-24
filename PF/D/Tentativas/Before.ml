let results = ref [||]

(* input *)
let get_arr edges planets = 
	let arr1 = Array.make (planets) [] in
	let arr2 = Array.make (planets) (0,0) in
	let rec run n =
		(* Printf.printf "%d\n" m; *)
		if n > 0 then (
			Scanf.scanf " %d %d %d" (
				fun a b c -> 
					arr1.(a-1)<-((b, c) :: arr1.(a-1));
					arr2.(b-1)<- (a, c)
			);
			run (n-1)
		)
	in 
	run edges;
	arr1, arr2

let rec calc_root holes fathers planet price  = 
	let (p, c) = fathers.(planet-1) in
	if p <> 0 then 
		let m = max !results.(p-1) (price + c) in
		(* Printf.printf "%d\n" m; *)
		!results.(p-1) <- m;
		calc_root holes fathers p (price+c)


let rec calc_leafs holes fathers planet price = 
	match holes.(planet-1) with
	| [] -> calc_root holes fathers planet 0
	| next -> 
		List.iter (
			fun (son, cost) -> 
				(* Printf.printf "%d, %d\n" son cost; *)
				!results.(son-1) <- price + cost; 
				calc_leafs holes fathers son (price + cost)
		) next


(** [| [(2, 12), (5, 7), (3, 10)], [ ], [(10, 11), (8, 15), (4, 9)], [(9, 7)], [(7, 6), (6, 15)], [ ], [ ], [ ], [ ], [(11, 5), (12, 7)], [ ], [ ] |] *)

let () =
  	let edge, planet = read_int (), read_int () in
  	let holes, fathers = get_arr edge planet in
	let () = results := Array.make planet 0 in
  	let () = calc_leafs holes fathers 1 0 in
  	Array.iter (Printf.printf "%d\n") !results