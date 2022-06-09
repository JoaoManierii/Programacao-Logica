:- module(
       dependente,
       [
       carrega_tab/1,
       insere/17,
       remove/1,
       atualiza/17]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   dependente(
            id:positive_integer,
            id_usuario:string,
            id_dependente: string,
            dep_nome:string,
            dep_email:string,
            dep_datanasc:string,
            dep_sexo:string,
            dep_cpf:string,
            dep_endereco:string,
            dep_cep:string,
            dep_bairro:string,
            dep_cidade:string,
            id_estado:string,
            dep_telefone:string,
            dep_login:string,
            dep_senha:string,
            dep_primeiroacesso:string
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso):-
    chave:pk(dependente,Id),
    with_mutex(dependente,
               assert_dependente(Id,IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso)).

remove(Id):-
    with_mutex(dependente,
               retractall_dependente(Id,_IdUser,_IdDep,_Nome,_Email,_DataNasc,_Sexo,_Cpf,_End,_Cep,_Bairro,_Cidade,_Estado,_Tel,_Login,_Senha,_PrimeiroAcesso)).

atualiza(Id,IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso):-
    with_mutex(dependente,
               (retract_dependente(Id,_IdUser,_IdDep,_Nome,_Email,_DataNasc,_Sexo,_Cpf,_End,_Cep,_Bairro,_Cidade,_Estado,_Tel,_Login,_Senha,_PrimeiroAcesso),
                assert_dependente(Id,IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso))).

