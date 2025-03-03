*** Settings ***
Resource    ../Resources/r_geral.robot

Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador


*** Test Cases ***
Cenário 01: Realizar login no sistema
    DADO que estou na página principal
    QUANDO digito um usuário válido
    E digito a senha correta
    E pressiono o botão 'Login'
    ENTÃO devo ser redirecinado para a página principal