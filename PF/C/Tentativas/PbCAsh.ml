(* PF 2021 PbC
 * 41266 - Diogo Castanheira Simões *)

(* Lê o N e a lista de moedas conforme definido pelo enunciado.
 * A lista é trocada para ficar por ordem crescente. *)
let n = read_int ()
let (maximo, moedas) =
  let rec ler i =
    if i = 0 then []
    else read_int () :: ler (i - 1)
  in
    let moedas = ler n in (2 * List.hd moedas, List.rev moedas)

(* Array para aplicar a programação dinâmica *)
let memoria = Array.make maximo 0

(* Solução do problema *)
let () =
  (* Obtemos a moeda mais pequena para algumas condições de controlo e para definir o primeiro troco a testar *)
  let minimo = List.hd moedas in

  (* Função recursiva que faz a comparação entre o algoritmo guloso e o algoritmo otimizado *)
  let rec comparar teste =

    (* Faz o teste à lista de passos precisos para cada fazer o troco com cada moeda *)
    let testar lista =
      if lista = [] then 1 else
      let lista_rev = List.rev lista in
      let ultimo = List.hd lista_rev in
      let passos = List.fold_left (fun m v -> if v = 0 then m else min m v) (List.hd lista) (List.rev (List.tl lista_rev)) in
        (* Condições testadas e afinadas com tentativa-erro *)
        if (passos >= ultimo) || (passos = 0) then (
          if ultimo > 0 then (
            if passos = 0 then 0 else ultimo
          ) else passos
        )
        else -1
    in

    (* Faz o troco do valor de teste com a moeda dada *)
    let fazer_troco moeda =
      let troco = teste - moeda in
        if troco = 0 then 1             (* Caso trivial: troco = moeda *)
        else if troco < 0 then 0        (* Troco negativo *)
        else if troco < minimo then 0   (* Troco impossível com as moedas disponibilizadas *)
        else memoria.(troco-1) + 1      (* Troco otimizado até ao momento, segundo memorizado *)
    in

      (* Chegágmos ao fim do teste: o algoritmo guloso é também o otimizado *)
      if teste > maximo then 0

      (* Vamos então mapear as moedas que podem fazer troco do valor a ser testado com as funções criadas anteriormente *)
      else begin
        let passos = testar (List.map fazer_troco (List.filter (fun moeda -> moeda <= teste && teste - moeda >= 0) moedas)) in
        if passos = -1 then teste         (* O teste falhou: o algoritmo guloso não é o otimizado *)
        else begin
          memoria.(teste-1) <- passos;    (* Gravar no array de memória *)
          comparar (teste + 1)
        end
      end
  in
    
    (* Se recebemos 0, correu tudo bem, se não é o troco onde falhou o algoritmo guloso *)
    let teste = comparar minimo in
      if teste = 0 then print_endline "YES"
      else Printf.printf "%d\n" teste
