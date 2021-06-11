(* 41330 - João Pedro Martins Pires Marques Freire
 * 41266 - Diogo Castanheira Simões 
 * 
 * Problema A
 *)


 type regexp =
  | V  
  | E
  | C of char
  | U of regexp * regexp 
  | P of regexp * regexp 
  | S of regexp
 
 module Parser_regexp = struct
 
   
 module MenhirBasics = struct
   
   exception Error
   
   type token = 
     | RPAREN
     | LPAREN
     | EPS
     | EOF
     | EMP
     | CONC
     | CHAR of (
        (char)
   )
     | AST
     | ALT
   
 end
 
 include MenhirBasics
 
 let _eRR =
   MenhirBasics.Error
 
 type _menhir_env = {
   _menhir_lexer: Lexing.lexbuf -> token;
   _menhir_lexbuf: Lexing.lexbuf;
   _menhir_token: token;
   mutable _menhir_error: bool
 }
 
 and _menhir_state = 
   | MenhirState12
   | MenhirState7
   | MenhirState6
   | MenhirState1
   | MenhirState0
 
 
 let rec _menhir_goto_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expr -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s _v ->
     let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
     match _menhir_s with
     | MenhirState6 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : (('freshtv47 * _menhir_state * 'tv_term)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : (('freshtv45 * _menhir_state * 'tv_term)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((let ((_menhir_stack, _menhir_s, (e1 : 'tv_term)), _, (e2 : 'tv_expr)) = _menhir_stack in
         let _2 = () in
         let _v : 'tv_expr = 
                                 ( P (e1, e2) )
          in
         _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv46)) : 'freshtv48)
     | MenhirState12 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : (('freshtv51 * _menhir_state * 'tv_term)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : (('freshtv49 * _menhir_state * 'tv_term)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((let ((_menhir_stack, _menhir_s, (e1 : 'tv_term)), _, (e2 : 'tv_expr)) = _menhir_stack in
         let _2 = () in
         let _v : 'tv_expr = 
                                 ( U (e1, e2) )
          in
         _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv50)) : 'freshtv52)
     | MenhirState1 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : ('freshtv59 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((assert (not _menhir_env._menhir_error);
         let _tok = _menhir_env._menhir_token in
         match _tok with
         | RPAREN ->
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : ('freshtv55 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let _menhir_env = _menhir_discard _menhir_env in
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : ('freshtv53 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_expr)) = _menhir_stack in
             let _3 = () in
             let _1 = () in
             let _v : 'tv_atom = 
                                 ( e )
              in
             _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv54)) : 'freshtv56)
         | _ ->
             assert (not _menhir_env._menhir_error);
             _menhir_env._menhir_error <- true;
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : ('freshtv57 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
             _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv58)) : 'freshtv60)
     | MenhirState0 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv73 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
         ((assert (not _menhir_env._menhir_error);
         let _tok = _menhir_env._menhir_token in
         match _tok with
         | EOF ->
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv69 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv67 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let (_menhir_stack, _menhir_s, (le : 'tv_expr)) = _menhir_stack in
             let _2 = () in
             let _v : (
        (regexp)
             ) = 
                                 ( le )
              in
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv65) = _menhir_stack in
             let (_menhir_s : _menhir_state) = _menhir_s in
             let (_v : (
        (regexp)
             )) = _v in
             ((let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv63) = Obj.magic _menhir_stack in
             let (_menhir_s : _menhir_state) = _menhir_s in
             let (_v : (
        (regexp)
             )) = _v in
             ((let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv61) = Obj.magic _menhir_stack in
             let (_menhir_s : _menhir_state) = _menhir_s in
             let ((_1 : (
        (regexp)
             )) : (
        (regexp)
             )) = _v in
             (Obj.magic _1 : 'freshtv62)) : 'freshtv64)) : 'freshtv66)) : 'freshtv68)) : 'freshtv70)
         | _ ->
             assert (not _menhir_env._menhir_error);
             _menhir_env._menhir_error <- true;
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv71 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
             ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
             _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)) : 'freshtv74)
     | _ ->
         let (() : unit) = () in
         ((Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
         assert false) : 'freshtv75)
 
 and _menhir_goto_term : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_term -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s _v ->
     let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
     match _menhir_s with
     | MenhirState0 | MenhirState12 | MenhirState6 | MenhirState1 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
         ((assert (not _menhir_env._menhir_error);
         let _tok = _menhir_env._menhir_token in
         match _tok with
         | ALT ->
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv31 * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
             ((let _menhir_env = _menhir_discard _menhir_env in
             let _tok = _menhir_env._menhir_token in
             match _tok with
             | CHAR _v ->
                 _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
             | EMP ->
                 _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState12
             | EPS ->
                 _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState12
             | LPAREN ->
                 _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState12
             | _ ->
                 assert (not _menhir_env._menhir_error);
                 _menhir_env._menhir_error <- true;
                 _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12) : 'freshtv32)
         | CONC ->
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv33 * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
             ((let _menhir_env = _menhir_discard _menhir_env in
             let _tok = _menhir_env._menhir_token in
             match _tok with
             | CHAR _v ->
                 _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
             | EMP ->
                 _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState6
             | EPS ->
                 _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState6
             | LPAREN ->
                 _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState6
             | _ ->
                 assert (not _menhir_env._menhir_error);
                 _menhir_env._menhir_error <- true;
                 _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6) : 'freshtv34)
         | EOF | RPAREN ->
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv35 * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
             ((let (_menhir_stack, _menhir_s, (e : 'tv_term)) = _menhir_stack in
             let _v : 'tv_expr = 
                                 ( e )
              in
             _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv36)
         | _ ->
             assert (not _menhir_env._menhir_error);
             _menhir_env._menhir_error <- true;
             let (_menhir_env : _menhir_env) = _menhir_env in
             let (_menhir_stack : 'freshtv37 * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
             ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
             _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)) : 'freshtv40)
     | MenhirState7 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : ('freshtv43 * _menhir_state * 'tv_factor) * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
         ((let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : ('freshtv41 * _menhir_state * 'tv_factor) * _menhir_state * 'tv_term) = Obj.magic _menhir_stack in
         ((let ((_menhir_stack, _menhir_s, (e1 : 'tv_factor)), _, (e2 : 'tv_term)) = _menhir_stack in
         let _v : 'tv_term = 
                                 ( P (e1, e2) )
          in
         _menhir_goto_term _menhir_env _menhir_stack _menhir_s _v) : 'freshtv42)) : 'freshtv44)
 
 and _menhir_goto_factor : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_factor -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s _v ->
     let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
     let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv29 * _menhir_state * 'tv_factor) = Obj.magic _menhir_stack in
     ((assert (not _menhir_env._menhir_error);
     let _tok = _menhir_env._menhir_token in
     match _tok with
     | CHAR _v ->
         _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState7 _v
     | EMP ->
         _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState7
     | EPS ->
         _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState7
     | LPAREN ->
         _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState7
     | ALT | CONC | EOF | RPAREN ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv27 * _menhir_state * 'tv_factor) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, (e : 'tv_factor)) = _menhir_stack in
         let _v : 'tv_term = 
                                 ( e )
          in
         _menhir_goto_term _menhir_env _menhir_stack _menhir_s _v) : 'freshtv28)
     | _ ->
         assert (not _menhir_env._menhir_error);
         _menhir_env._menhir_error <- true;
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState7) : 'freshtv30)
 
 and _menhir_goto_atom : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_atom -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s _v ->
     let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
     let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv25 * _menhir_state * 'tv_atom) = Obj.magic _menhir_stack in
     ((assert (not _menhir_env._menhir_error);
     let _tok = _menhir_env._menhir_token in
     match _tok with
     | AST ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv21 * _menhir_state * 'tv_atom) = Obj.magic _menhir_stack in
         ((let _menhir_env = _menhir_discard _menhir_env in
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv19 * _menhir_state * 'tv_atom) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, (e : 'tv_atom)) = _menhir_stack in
         let _2 = () in
         let _v : 'tv_factor = 
                                 ( S e )
          in
         _menhir_goto_factor _menhir_env _menhir_stack _menhir_s _v) : 'freshtv20)) : 'freshtv22)
     | ALT | CHAR _ | CONC | EMP | EOF | EPS | LPAREN | RPAREN ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv23 * _menhir_state * 'tv_atom) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, (e : 'tv_atom)) = _menhir_stack in
         let _v : 'tv_factor = 
                                 ( e )
          in
         _menhir_goto_factor _menhir_env _menhir_stack _menhir_s _v) : 'freshtv24)) : 'freshtv26)
 
 and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s ->
     match _menhir_s with
     | MenhirState12 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : ('freshtv9 * _menhir_state * 'tv_term)) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)
     | MenhirState7 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv11 * _menhir_state * 'tv_factor) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv12)
     | MenhirState6 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : ('freshtv13 * _menhir_state * 'tv_term)) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv14)
     | MenhirState1 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv15 * _menhir_state) = Obj.magic _menhir_stack in
         ((let (_menhir_stack, _menhir_s) = _menhir_stack in
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)
     | MenhirState0 ->
         let (_menhir_env : _menhir_env) = _menhir_env in
         let (_menhir_stack : 'freshtv17) = Obj.magic _menhir_stack in
         (raise _eRR : 'freshtv18)
 
 and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s ->
     let _menhir_stack = (_menhir_stack, _menhir_s) in
     let _menhir_env = _menhir_discard _menhir_env in
     let _tok = _menhir_env._menhir_token in
     match _tok with
     | CHAR _v ->
         _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
     | EMP ->
         _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState1
     | EPS ->
         _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1
     | LPAREN ->
         _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState1
     | _ ->
         assert (not _menhir_env._menhir_error);
         _menhir_env._menhir_error <- true;
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1
 
 and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s ->
     let _menhir_env = _menhir_discard _menhir_env in
     let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv7) = Obj.magic _menhir_stack in
     let (_menhir_s : _menhir_state) = _menhir_s in
     ((let _1 = () in
     let _v : 'tv_atom = 
                                 ( E )
      in
     _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv8)
 
 and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s ->
     let _menhir_env = _menhir_discard _menhir_env in
     let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
     let (_menhir_s : _menhir_state) = _menhir_s in
     ((let _1 = () in
     let _v : 'tv_atom = 
                                 ( V )
      in
     _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv6)
 
 and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
        (char)
 ) -> 'ttv_return =
   fun _menhir_env _menhir_stack _menhir_s _v ->
     let _menhir_env = _menhir_discard _menhir_env in
     let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv3) = Obj.magic _menhir_stack in
     let (_menhir_s : _menhir_state) = _menhir_s in
     let ((c : (
        (char)
     )) : (
        (char)
     )) = _v in
     ((let _v : 'tv_atom = 
                                 ( C c )
      in
     _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv4)
 
 and _menhir_discard : _menhir_env -> _menhir_env =
   fun _menhir_env ->
     let lexer = _menhir_env._menhir_lexer in
     let lexbuf = _menhir_env._menhir_lexbuf in
     let _tok = lexer lexbuf in
     {
       _menhir_lexer = lexer;
       _menhir_lexbuf = lexbuf;
       _menhir_token = _tok;
       _menhir_error = false;
     }
 
 and regexpr : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
        (regexp)
 ) =
   fun lexer lexbuf ->
     let _menhir_env =
       let (lexer : Lexing.lexbuf -> token) = lexer in
       let (lexbuf : Lexing.lexbuf) = lexbuf in
       ((let _tok = Obj.magic () in
       {
         _menhir_lexer = lexer;
         _menhir_lexbuf = lexbuf;
         _menhir_token = _tok;
         _menhir_error = false;
       }) : _menhir_env)
     in
     Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
     let (_menhir_stack : 'freshtv1) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
     ((let _menhir_env = _menhir_discard _menhir_env in
     let _tok = _menhir_env._menhir_token in
     match _tok with
     | CHAR _v ->
         _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
     | EMP ->
         _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
     | EPS ->
         _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
     | LPAREN ->
         _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
     | _ ->
         assert (not _menhir_env._menhir_error);
         _menhir_env._menhir_error <- true;
         _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2))
 
   
 
 
 
 end
 
 module Lexer_regexp = struct
  
   open Parser_regexp
 
   exception Error of string
 
 
   let __ocaml_lex_tables = {
     Lexing.lex_base =
     "\000\000\245\255\246\255\247\255\248\255\249\255\250\255\251\255\
       \252\255\253\255\254\255\255\255";
     Lexing.lex_backtrk =
     "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255";
     Lexing.lex_default =
     "\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000";
     Lexing.lex_trans =
     "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\011\000\011\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \011\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \004\000\003\000\007\000\009\000\000\000\000\000\008\000\000\000\
       \006\000\005\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
       \010\000\010\000\010\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \002\000";
     Lexing.lex_check =
     "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \000\000\000\000\000\000\000\000\255\255\255\255\000\000\255\255\
       \000\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
       \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
       \000\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
       \000\000";
     Lexing.lex_base_code =
     "";
     Lexing.lex_backtrk_code =
     "";
     Lexing.lex_default_code =
     "";
     Lexing.lex_trans_code =
     "";
     Lexing.lex_check_code =
     "";
     Lexing.lex_code =
     "";
   }
 
   let rec tokenize lexbuf =
     __ocaml_lex_tokenize_rec lexbuf 0
   and __ocaml_lex_tokenize_rec lexbuf __ocaml_lex_state =
     match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
         | 0 ->
                                         ( tokenize lexbuf )
 
     | 1 ->
   let
                           s
   = Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
                                         ( CHAR s )
 
     | 2 ->
                                         ( ALT )
 
     | 3 ->
                                         ( CONC )
 
     | 4 ->
                                         ( AST )
 
     | 5 ->
                                         ( EMP )
 
     | 6 ->
                                         ( EPS )
 
     | 7 ->
                                         ( LPAREN )
 
     | 8 ->
                                         ( RPAREN )
 
     | 9 ->
                                         ( EOF )
 
     | 10 ->
         ( raise (Error (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) )
 
     | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
         __ocaml_lex_tokenize_rec lexbuf __ocaml_lex_state
 
   ;;
 end
 
(* --------------------------------- fim lexing/parsing code ----------------------------------------------------- *)

open Parser_regexp


(* função principal de leitura de uma expressão regular (a partir de uma string) *)
let regexp st =
   let linebuf = Lexing.from_string st in
   try regexpr Lexer_regexp.tokenize linebuf
   with _ -> failwith "regexp: input problem"

(* Função dada pelo professor: devolve a lista sem repetidos *)
let unique l =
  let tbl = Hashtbl.create (List.length l) in
  let f l e = try let _ = Hashtbl.find tbl e in l
              with Not_found ->  Hashtbl.add tbl e (); e::l
  in  List.rev (List.fold_left f [] l)


(* **************************************************************************************************************** *)
(* ********************************************   Começar aqui **************************************************** *)

(* exemplo de código para ilustrar o uso da função regexp e o tipo regexp *)
let rec string_of_regexp s =
  match s with
  | V        -> "0"
  | E        -> "1"
  | C  c     -> String.make 1 c    
  | U (f, g) -> "(" ^ (string_of_regexp f) ^ " + " ^ (string_of_regexp g) ^ ")"
  | P (f, g) -> "(" ^ (string_of_regexp f) ^ " . " ^ (string_of_regexp g) ^ ")"
  | S  s     -> (string_of_regexp s) ^ "*"


(* Tipos de dados *)
type etiqueta = char option
type transicao = int * etiqueta
type automato = transicao list array

(* Primeiro e segundo elemento de um 2-tuplo *)
let prim (a, _) = a
let seg  (_, b) = b

(* Devolve o próprio valor *)
let self x = x

(* For each com "break". Percorre a lista l e, se (f x), então break e devolve (b x). Se chegar ao fim da lista devolve s. *)
let rec foreach l f b s =
  match l with
  | [] -> s
  | x :: xs -> if f x then b x else foreach xs f b s


(* Calcula o autómato dada a expressão regular r. *)
let calcular_automato r =
  let rec calcular r a i l m =
    (* União ( A+B ) *)
    let uniao f g =
      let a = Array.append a (Array.make 4 []) in
        a.(i)   <- [(m+1, None); (m+2, None)];
        a.(m+3) <- [(l, None)];
        a.(m+4) <- [(l, None)];
      let (xl, a) = calcular f a (m+1) (m+3) (m+4) in
      let (yl, a) = calcular g a (m+2) (m+4) xl in
        (yl, a)
    in

    (* Produto ( A.B ) *)
    let produto f g =
      let a = Array.append a (Array.make 1 []) in
        a.(i)   <- [(m+1, None)];
        a.(m+1) <- [(l, None)];
      let (xl, a) = calcular f a i (m+1) (m+1) in
      let (yl, a) = calcular g a (m+1) l xl in
        (yl, a)
    in

    (* Fecho ( A* ) *)
    let fecho s =
        let a = Array.append a (Array.make 2 []) in
          a.(i)   <- [(l, None); (m+1, None)];
          a.(m+2) <- [(m+1, None); (l, None)];
        let (xl, a) = calcular s a (m+1) (m+2) (m+2) in
          (xl, a)
    in

      (* função calcular *)
      match r with
      | V        -> a.(i) <- []; (m, a)                 (* Vazio *)
      | E        -> a.(i) <- [(l, None)]; (m, a)        (* Epsilon *)
      | C  c     -> a.(i) <- [(l, Some c)]; (m, a)      (* Caracter *)
      | U (f, g) -> uniao f g
      | P (f, g) -> produto f g
      | S  s     -> fecho s

  in
    (* função calcular_automato *)
    let (_, a) = calcular r [|[]; []|] 0 1 1
    in  (* Adiciona o dicionário em loop ao nodo 0 e devolve o autómato *)
      a.(0) <- [(0, Some 'A'); (0, Some 'T'); (0, Some 'G'); (0, Some 'C')] @ a.(0); a


(* Procura a solução ao problema: devolve (início, fim) em sucesso ou "falhou" (-1, 0) caso contrário *)
let solucao (a : automato) (s : string) =
  (* Constante *)
  let falhou = (-1, 0) in

  (* Salta os épsilons no autómato sem entrar num ciclo infinito *)
  let saltar_epsilons (ch : char) (i : int) =
    let rec saltar (i : int) (v : int list) =  (* v é o registo por onde já passou *)
      let f (k, l) =
        match l with
          | None   -> if k <> 1 then (if not (List.mem k v) then saltar k (k :: v) else [k]) else [k]
          | Some c -> if c = ch then [k] else []
      in
      List.concat (List.map f a.(i))
    in saltar i []
  in
  let len = String.length s in
  let res = ref [(0, 0)] in     (* Começamos no 1° caracter no nodo 0 do autómato *)
  let rec verificar i =
    if i < len then (
      (* Mapeia os nodos atuais para encontrar os próximos dado o caracter atual *)
      res := unique (List.concat (List.map (fun (x, y) -> List.map (fun z -> (x, z)) (saltar_epsilons s.[i] y)) !res));

      (* Organiza pelo n° do caracter pois precisamos da primeira ocorrência *)
      res := List.sort (fun (x, _) (y, _) -> x - y) !res;

      (* Printf.printf "%2d: " i; List.iter (fun (a, b) -> Printf.printf "(%2d, %2d); " a b) !res; Printf.printf "\n\n"; *)

      (* Percorre a lista e verifica se algum caminho chegou ao nodo 1 (final) *)
      let resultado = foreach !res (fun (_, y) -> y = 1) (self) (falhou)

      (* Se há solução, devolvemos o tuplo (início, fim), se não filtramos os nodos "inúteis" e voltamos a verificar com o caracter seguinte *)
      in if resultado <> falhou then (fst resultado, i) else (
        res := List.filter (fun (x, y) -> x > i || y <> 0) !res;
        res := (i + 1, 0) :: !res;
        verificar (i + 1)
      )
    ) else falhou   (* Chegou ao fim sem encontrar solução *)
  in verificar 0


(* Função de output: início = -1 indica que não há solução *)
let saida (inicio, fim) =
  match inicio with
  | -1              -> Printf.printf "NO\n"
  | i when i = fim  -> Printf.printf "YES\n"
  | _               -> Printf.printf "%d %d\n" inicio fim

(* Função de input *)
let entrada () = 
  let regex = read_line () in 
  let adn = read_line () in
    (regexp regex, adn)


(* main *)
let () =
  let (r, s) = entrada () in
  let a = calcular_automato r in
    saida (solucao a s)


(* BIBLIOGRAFIA:
 * 
 * https://github.com/thoga31/TComp/blob/main/src/PbC/PbC.ml
 * 
 * Agradecemos ao Igor por nos ter ajudado a compreender os autómatos e a sua técnica de os representar.
 * Ele também nos recomendou a leitura do seguinte artigo para perceber como adicionar nodos:
 * 
 * https://deniskyashif.com/2019/02/17/implementing-a-regular-expression-engine/
 * 
 *)