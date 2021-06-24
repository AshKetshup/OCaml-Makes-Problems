(** Declaração de um array vazio para inserção de resultados *)
let results = ref [||]


(** 
 Recolhe do utilizador todos os dados necessarios para o funcionamento do 
 programa 
 *)
let read () = 
    let get_arr edges planets = 
        let holes = Array.make planets [] in
        let parents = Array.make planets (0,0) in
        let rec run n =
            if n > 0 then (
                Scanf.scanf " %d %d %d" (
                    fun a b c -> 
                        holes.(a - 1)<-((b, c) :: holes.(a - 1));
                        parents.(b - 1)<- (a, c)
                );
                run (n - 1)
            )
        in 
        run edges;
        holes, parents
    in
    let edge, planet = read_int (), read_int () in
    let holes, parents = get_arr edge planet in 
    edge, planet, holes, parents


(** Calcula o custo de cada aresta e coloca em `results` *)
let calc holes parents = 
    let rec calc_root planet price =
        let (parent, cost) = parents.(planet - 1) in
        if parent <> 0 then
            let m = max !results.(parent - 1) (price + cost) in
            !results.(parent - 1) <- m;
            calc_root parent (price + cost)
    in
    let rec calc_leafs planet price =
        match holes.(planet - 1) with
        | []   -> calc_root planet 0
        | next -> 
            List.iter (
                fun (son, cost) -> 
                    !results.(son - 1) <- price + cost; 
                    calc_leafs son (price + cost)
            ) next
    in
    calc_leafs 1 0


(** Apresenta de forma formatada o custo de cada aresta *)
let present () = 
    Array.iter (Printf.printf "%d\n") !results


(* Main *)
let () =
    let edge, planet, holes, parents = read () in
    results := Array.make planet 0;
    calc holes parents;
    present ()
