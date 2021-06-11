(* 
INPUT

M = (Q, Γ, Σ, δ, s, #, F) 

O conjunto de dados Q é admitido na forma {1 ... n} (sendo n int)
que Σ = {a, ..., z}
que Γ = {#, A, B, ..., Z} U Σ
o estado inicial é o estado 1.

Primeira Linha:
	É introduzida a palavra por reconhecer.
	Esta palavra só é constituida por caracter do alfabeto Σ 
	tem por comprimento máximo 50 caracteres.

Nas Linhas Restantes:
	Introduzidos os dados necessarios à definição completa de maquina de Turing M.
	ou seja é introduzida por:
		
		* uma linha com inteiro n, especificado o conjunto Q = {1 ... n};
		
		* uma linha com o numero nf (cardinalidade do conjunto F dos estados finais);
		
		* uma linha com nf inteiros distintos (separados por um " ");
		
		* uma linha com o numero m de transições (a cardinalidade de δ);

		* m linhas em cada uma delas introduz uma transição sob a forma de i a b d j,
		sendo i o inteiro representando o estado de partida da transição, a o caracter no rotulo
		da transicao, b o caracter por escrever na fita, d ∈ {L, R} a direção do movimento da
		cabeça de leitura/escrita e j o inteiro que representa o estado de chagada;
*)

(* Passos & Passos Functions *)
let passos = ref 0

let inc_passos () = 
	passos := !passos + 1 

let get_passos () =
	!passos

(* Print Functions *)
(*
let rec printList first_text list=
	match list with
	|[] -> ()
	|hd::tl -> 
		Printf.printf first_text^hd;
		printList first_text tl 
*)


(* Input Functions *)
let input_palavra () = 
	read_line ()

let input_Q () = 
	int_of_string (read_line ())

let input_F () =
	int_of_string (read_line ())

let input_EstadosFinais () = 
	read_line ()

let input_Sigma () = 
	int_of_string (read_line ())

let rec m_linhas m = 
	match m with
	|0 -> []
	|_ -> let s = read_line () in
		  s :: m_linhas (m-1)


(* Main Function *)
let () = 
	let palavra = input_palavra () in
	let q = input_Q () in
	let f = input_F () in
	let eFinais = input_EstadosFinais () in
	let eFinaisList = String.split_on_char ' ' eFinais in
	let sigmaLines = m_linhas (input_Sigma ()) in
	()
	(*Printf.printf "Palavra: %s\nQ: %i\nF: %i\nEstados Finais: %s\nSigma:" palavra q f eFinais;
	printList "\n\t" sigmaLines *)