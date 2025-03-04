*** Settings ***
Resource    ../Resources/r_login.robot

Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador


*** Test Cases ***
Cenário 01: Realizar login com sucesso no sistema
    [Tags]    login    sucesso

    DADO que estou na página principal
    QUANDO digito um usuário com acesso válido
    E digito a senha correta
    E pressiono o botão 'Login'
    ENTÃO devo ser redirecinado para a página principal

Cenário 02: Falha ao inserir usuário bloqueado
    [Tags]    login    falha

    DADO que estou na página principal
    QUANDO digito um usuário com acesso bloqueado
    E digito a senha correta
    E pressiono o botão 'Login'
    ENTÃO deve ser exibida a mensagem 'Epic sadface: Sorry, this user has been locked out.'

Cenário 03: Falha ao inserir senha incorreta
    [Tags]    login     falha

    DADO que estou na página principal
    QUANDO digito um usuário com acesso válido
    E digito a senha incorreta
    E pressiono o botão 'Login'
    ENTÃO deve ser exibida a mensagem 'Epic sadface: Username and password do not match any user in this service'

Cenário 04: Falha ao não inserir usuário
    [Tags]    login     falha

    DADO que estou na página principal
    QUANDO digito uma senha correta com usuário em branco
    E pressiono o botão 'Login'
    ENTÃO deve ser exibida a mensagem 'Epic sadface: Username is required'

Cenário 05: Falha ao não inserir senha
    [Tags]    login     falha

    DADO que estou na página principal
    QUANDO digito um usuário com acesso válido com senha em branco
    E pressiono o botão 'Login'
    ENTÃO deve ser exibida a mensagem 'Epic sadface: Password is required'