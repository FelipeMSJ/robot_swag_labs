*** Settings ***
Resource    r_geral.robot
Resource    r_login.robot
Library    String

*** Variables ***
${PRODUCT_TITLE}    Products
@{LIST_NOME_BTN}    Add to cart    Remove

*** Keywords ***
DADO que estou na página de inventário
    Realizar Login
    Element Text Should Be    //span[@class='title'][contains(.,'${PRODUCT_TITLE}')]    ${PRODUCT_TITLE}

QUANDO clico no título do produto "${PRODUCT_NAME}"
    Click Element    //div[@class='inventory_item_name '][contains(.,'${PRODUCT_NAME}')]

ENTÃO devo ser redirecionado para a página do produto "${PRODUCT_NAME}"
    Element Text Should Be    //div[@class='inventory_details_name large_size'][contains(.,'${PRODUCT_NAME}')]    ${PRODUCT_NAME}

QUANDO clico no carrinho no produto "${PRODUCT_NAME}"
    ${PRODUCT_NAME}    Replace String    ${PRODUCT_NAME}   ${SPACE}    -
    ${PRODUCT_NAME}    Convert To Lower Case    ${PRODUCT_NAME}
    Click Button    //button[contains(@data-test,'add-to-cart-${PRODUCT_NAME}')]
    Set Suite Variable    ${TAG_PRODUCT_NAME}    ${PRODUCT_NAME}

ENTÃO o botão deve mudar para "${NOME_BTN}"
    IF    $NOME_BTN == $LIST_NOME_BTN[0]
        ${NOME_BTN}    Replace String    ${NOME_BTN}   ${SPACE}    -
        ${NOME_BTN}    Convert To Lower Case    ${NOME_BTN}
    ELSE IF  $NOME_BTN == $LIST_NOME_BTN[1]
        ${NOME_BTN}    Convert To Lower Case    ${NOME_BTN}
    END

    Set Suite Variable    ${BTN_CARRINHO_LOCATOR}    //button[contains(@data-test,'${NOME_BTN.lower()}-${TAG_PRODUCT_NAME}')]
    Element Should Be Visible    ${BTN_CARRINHO_LOCATOR}

E a quantidade de itens no carrinho deve somar um
    Element Should Be Visible    //span[contains(@class,'shopping_cart_badge')]

E possua o produto "${PRODUCT_NAME}" adicionado ao carrinho
    QUANDO clico no carrinho no produto "${PRODUCT_NAME}"
    ENTÃO o botão deve mudar para "${LIST_NOME_BTN}[1]"

QUANDO clico no botão "${NOME_BTN}"
    Click Button    ${BTN_CARRINHO_LOCATOR}