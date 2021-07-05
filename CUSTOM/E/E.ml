(* Input function *)
let entrada () =
    let get_matrix h w =
        let mat = Array.make_matrix h w 0 in
        let rec create_matrix size curr =
            let get_array_from_line () = 
                read_line () 
                |> String.split_on_char ' ' 
                |> Array.of_list 
                |> Array.map int_of_string
            in
            if curr < size then (
                mat.(curr) <- get_array_from_line ();
                create_matrix size (curr + 1)
            )
        in 
        create_matrix h 0;
        mat
    in			
    let h = read_int () in
    let w = read_int () in
    (get_matrix h w), h, w


(* Debug & Output *)
let print_matrix matrix =
    let size = Array.length matrix.(0) in
    let procedure_per_line line =
        Array.iteri (fun i x -> Printf.printf "%d%c" x (if i = size - 1 then '\n' else ' ')) line 
    in
    Array.iter (fun x -> procedure_per_line x) matrix


(* Checks borders for 1s and creates a new matrix with the adjecents. *)
let clean_island (mat, h, w) =
    let result = Array.make_matrix h w 0 in
    let h, w = (h-1), (w-1) in
    let rec fill (a, b) = 
        if mat.(a).(b) = 1 && result.(a).(b) = 0 then (
            result.(a).(b) <- 1;
            let possibilities =
                match a, b with
                | n, m when m = w && n = h -> []
                | _, m when m = w -> [(a+1, b); (a, b-1)]
                | n, _ when n = h -> [(a-1, b); (a, b+1)]
                | 0, _ | _, 0     -> [(a+1, b); (a, b+1)]
                | _, _ -> [(a-1, b); (a, b-1); (a, b+1); (a+1, b)]
            in 
            List.iter (fun x -> fill x) possibilities
        )
    in
    let rec run i j = 
        let () = fill (i,j) in
        match i, j with
        | n, m when (n, m) = (h, w) -> ()
        | _, m when m = w -> run (i+1) 0
        | n, _ when n = h -> run i (j+1)
        | 0, _ -> run i (j+1)
        | _, 0 -> run i w
        | _, _ -> ()
    in run 0 0;
    result


let () = 
    entrada ()   |> 
    clean_island |> 
    print_matrix