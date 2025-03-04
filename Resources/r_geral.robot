*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}     https://www.saucedemo.com/

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome

Fechar o navegador
    Close Browser