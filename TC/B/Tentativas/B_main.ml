(* ******************************** tipagem ******************************** *)

type regra = {
    simbolo:           string;
    l_string:      string list;
}

type gramatica = {
    p_simbolo:       string;
    regras:          regra list;
}

(* *************************** variaveis globais *************************** *)


(* *************************** debuging functions ************************** *)

let rec print_list = function 
    | []   -> ()
    | hd::tl -> 
        print_string hd; 
        print_string " "; 
        print_list tl

let rec print_regra_list = function 
    | []   -> ()
    | hd::tl -> 
        print_string hd.simbolo; 
        print_string " -> "; 
        print_list hd.l_string;
        print_string "\n";
        print_regra_list tl


(* **************************** tool functions ***************************** *)

let rec append_list (a:'a list) (b:'a list) =
    match a with
    | hd :: tl -> 
        hd::(append_list tl b)
    | [] -> b

(* 
 * For each com "break". Percorre a lista l e, se (f x), então break e 
 * devolve (b x). Se chegar ao fim da lista devolve s. 
 *)
let rec foreach l f b s =
  	match l with
  	| [] -> s
  	| x :: xs -> if f x then b x else foreach xs f b s


let adicionar_regra_gramatica (regra:regra) (regras:regra list) :regra list= 
	regra :: regras

(* *****************************  Simplificação  *************************** *)

(* (p.e.)
 *
 * S -> ABaC
 * A -> BC
 * B -> b|_
 * C -> D|_
 * D -> d
 * 
 * 1o Passo: remover regras vazias
 * 		- ver para que produções existem epsilons (_).
 *		p.e. 	S -> AC     ||   S -> AC   ||   S -> (A)C   ||   S -> AC|C
 *				A -> Bad    ||   A -> (B)ad||   A -> Bad|ad ||   A -> Bad|ad
 * 				B -> Cc|(_) ||   B -> Cc   ||   B -> Cc 	||   B -> Cc
 * 				...				 ...			...				 ...
 *)
let remover_regras_vazias (gramatica:gramatica) :gramatica =
	(* Eliminar epsilons (_) *)
	let check_for_epsilons (regras:regra list) =
		foreach regras 
(* PAREI AQUI *)



let simplificar (gramatica :gramatica) :gramatica = 
	gramatica 
	|> remover_regras_vazias 
	|> remover_regras_unitarias 
	|> remover_simbolos_inuteis


let gramatica_of_regras (regras :regra list) (sim :string) :gramatica =
	let regra = {
		simbolo =  (sim);
		l_string = ["S"];
	} in
	{
		p_simbolo = (sim);
		regras =    (adicionar_regra_gramatica regra regras);
	}
let gramatica_of_regras (regras:regra list) = gramatica_of_regras regras "S0"

(* ****************************  Input & Output  *************************** *)


(* Input *)
let entrada () = 
	let string_to_regra (x:string) :regra =
    	let str = String.split_on_char ' ' x in
    	let hd, tl = List.hd str, List.tl str in
    	{
    	    simbolo = hd; 
    	    l_string = (List.tl tl);
    	}
	in
	let rec get_regras (quantidade:int) :regra list=
		match quantidade with
		|0 -> []
		|_ -> let regra = string_to_regra (read_line ()) in
			  regra :: (get_regras (quantidade-1))
	in
	let distancia, quantidade = 
		int_of_string(read_line()), int_of_string(read_line()) in
	let regras = get_regras quantidade in
	distancia, quantidade, regras


(* Output *)
let saida () = ()

(* ************************************************************************* *)
(* *********************************  Main  ******************************** *)
(* ************************************************************************* *)

let () =
    let (distancia:int), (quantidade:int), (regras:regra list) = entrada () in
	let gramatica = gramatica_of_regras regras |> simplificar in
	()
    
(* Gramatica algebrica sem contexto *)