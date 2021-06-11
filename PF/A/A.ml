(* Autor - Diogo Simões | 41266 *)

(*
Mudanças:
 - Eliminação de elementos repetidos em cada recursão 
*)

(* Variavel global. O programa deve acabar quando esta estiver a true *)
let got_42 = ref false

(** Identifica se o inteiro que lê é 42 e devolve o seu valor *)
let is_42 value = if value = 42 then got_42 := true; value

(** Identifica quais regras se aplicam a [m] e devolve num tuplo de 3 booleanos *)
let check_which_rules m = 
	((m mod 2) = 0, ((m mod 3) = 0 || (m mod 4) = 0), ((m mod 5) = 0))

(** gera uma lista dos possiveis balanços consoante as 3 regras através do [balance] *)
let next_step balance = 
	let (r1, r2, r3) = check_which_rules balance in
	(* aplicar regra 1 *)
	(if r1 then 
		let x = is_42 (balance/2) in
		if x < 42 then [] else [x]
	else [])
	@
	(* aplicar regra 2 *)
	(if r2 then 
		let x = is_42 (balance - (balance mod 10 * ((balance mod 100)/10))) in
		if x = balance || x < 42 then [] else [x]
	else [])
	@
	(* aplicar regra 3 *)
	(if r3 then
		let x = is_42 (balance - 42) in
		if x < 42 then [] else [x]
	else [])


(** Elimina todos os elementos repetidos de uma lista [l] *)
let unique l = 
  	let h = Hashtbl.create 1 in
  	let rec run = function
  	| [] -> Hashtbl.to_seq_keys h |> List.of_seq
  	| hd :: tl -> let () = if not (Hashtbl.mem h hd) then Hashtbl.add h hd () in run tl
  	in run l


(* Main *)
let () = 
	(** 
	A cada recursão verifica o booleano [got_42] e dá a resposta. 
	Caso a lista, gerada pela função [next_step], ainda não esteja 
	vazia ele executa mais uma recursão. 
	*)
	let rec exec lsd step =
		if !got_42 then 
			Printf.printf "%d\n" step
		else
			let x = List.concat_map next_step (unique lsd) in
			if x = [] then Printf.printf "BAD LUCK\n" else exec x (step+1)
	in
	let n = read_int () in
	if n = 42 then got_42 := true;
	exec [n] 0


(*  Exemplo de Execução:

	> Passo 1
	recebe: unique [250] = [250]
	Vê quantas são as regras que se aplicam.
		(250)
		r1 (X); r2 ( ); r3: (X);
		[125] @ [] @ [208]
		[125; 208]

	> Passo 2
	recebe: unique [125; 208] = [125; 208]
		(125)
		r1 ( ); r2 ( ); r3: (X);
		(208)
		r1 (X); r2 (X); r3: ( );
		
		[] @ [] @ [83] concat [104] @ [208] @ []
		[83; 104; 208]

	> Passo 3
	recebe: unique [83, 104, 208] = [83, 104, 208]
		(83)
		r1 ( ); r2 ( ); r3: ( );
		(104)
		r1 (X); r2 (X); r3: ( );
		(208)
		r1 (X); r2 (X); r3: ( );
	
		[] @ [] @ [] concat [52] @ [104] @ [] concat [104] @ [208] @ []
		[52; 104; 104; 208]
			
	> Passo 4
	recebe: unique [52; 104; 104; 208] = [52; 104; 208]
		(52)
		r1 (X); r2 (X); r3: ( );
		(104)
		r1 (X); r2 (X); r3: ( );
		(208)
		r1 (X); r2 (X); r3: ( );
	
		[26] @ [42] @ [] concat [52] @ [104] @ [] concat [104] @ [208] @ [] 
		** got_42 passa a true **
		[26; 42; 52; 104; 104; 208]

	Visto que a variavel got_42 = true então podemos concluir 
	que chegamos a 42 com 4 passos

	PS: A cada calculo de regra é verificado se o valor é 42 pela função is_42.
*)

