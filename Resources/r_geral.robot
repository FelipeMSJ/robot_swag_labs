*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}     https://www.saucedemo.com/
@{USERNAMES}    standard_user    locked_out_user    problem_user    performance_glitch_user    error_user    visual_user  
${PASSWORD}     secret_sauce
${BTN_LOGIN}    id=login-button

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome

Fechar o navegador
    Close Browser

DADO que estou na página principal
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${BTN_LOGIN}

QUANDO digito um usuário válido
    Input Text    id=user-name    ${USERNAMES}[0]

E digito a senha correta
    Input Text    id=password    ${PASSWORD}

E pressiono o botão 'Login'
    Click Button    ${BTN_LOGIN}

ENTÃO devo ser redirecinado para a página principal
    Element Should Be Visible    //div[@class='app_logo'][contains(.,'Swag Labs')]