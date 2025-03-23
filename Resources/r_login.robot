*** Settings ***
Resource    r_geral.robot
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
@{USERNAMES}    standard_user    locked_out_user    problem_user    performance_glitch_user    error_user    visual_user  
${PASSWORD}     secret_sauce
${BTN_LOGIN_LOCATOR}   id=login-button
${PASSWORD_LOCATOR}    id=password
${USERNAME_LOCATOR}    id=user-name

*** Keywords ***
DADO que estou na página principal
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${BTN_LOGIN_LOCATOR}

QUANDO digito um usuário com acesso válido
    Input Text    ${USERNAME_LOCATOR}    ${USERNAMES}[0]

E digito a senha correta
    Input Password    ${PASSWORD_LOCATOR}    ${PASSWORD}

E digito a senha incorreta
    ${PASSWORD_INCORRETO}    FakerLibrary.Password    length=8
    Input Password    ${PASSWORD_LOCATOR}    ${PASSWORD_INCORRETO}
    Log    ${PASSWORD_INCORRETO}

E pressiono o botão 'Login'
    Click Button    ${BTN_LOGIN_LOCATOR}

ENTÃO devo ser redirecinado para a página principal
    Element Should Be Visible    //div[@class='app_logo'][contains(.,'Swag Labs')]

QUANDO digito um usuário com acesso bloqueado
    Input Text    ${USERNAME_LOCATOR}    ${USERNAMES}[1]

ENTÃO deve ser exibida a mensagem '${MENSAGEM_ERRO}'
    Element Should Contain    //h3[@data-test='error'][contains(.,'${MENSAGEM_ERRO}')]    ${MENSAGEM_ERRO}

QUANDO digito uma senha correta com usuário em branco
    E digito a senha correta
    Textfield Value Should Be    ${USERNAME_LOCATOR}    expected=

QUANDO digito um usuário com acesso válido com senha em branco
    QUANDO digito um usuário com acesso válido
    Textfield Value Should Be    ${PASSWORD_LOCATOR}    expected=

Realizar Login
    DADO que estou na página principal
    QUANDO digito um usuário com acesso válido
    E digito a senha correta
    E pressiono o botão 'Login'
    ENTÃO devo ser redirecinado para a página principal