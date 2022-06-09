:- module(
       usuarios,
       [usuarios/17]
   ).

:- use_module(library(persistency)).

:- persistent
   usuarios(
            id_usuario: positive_integer,
            usu_nome:atom,
            usu_email:atom,
            usu_datanasc:atom,
            usu_sexo:char,
            usu_cpf:integer,
            usu_endereco:atom,
            usu_cep:integer,
            usu_bairro:atom,
            usu_cidade:atom,
            id_estado:integer,
            usu_telefone:integer,
            usu_login:atom,
            usu_senha:atom,
			usu_privilegio:atom,
            usu_primeiroacesso:integer,
			usu_ativo: integer
   ).

:- initialization(db_attach('tbl_usuarios.pl', [])).

insere(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo):-
    with_mutex(usuarios,
               assert_reservas(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo)).

remove(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo):-
    with_mutex(usuarios,
               retract_reservas(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo)).

atualiza(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo):-
    with_mutex(usuarios,
               (retractall_reservas(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo),
               assert_reservas(IdUsu,UsuNome,UsuEmail,UsuDatanasc,UsuSexo,UsuCpf,UsuEnd,UsuCep,UsuBairro,UsuCid,IdEstado,UsuTele,UsuLog,UsuSen,UsuPrivi,UsuPrimei,UsuAtivo))).

sincroniza:-
    db_sync(gc(always)).