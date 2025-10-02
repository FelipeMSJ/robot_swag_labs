*** Settings ***
Resource    r_geral.robot
Resource    r_login.robot
Library    String

*** Variables ***
${PRODUCT_TITLE}    Products
@{LIST_NOME_BTN}    Add to cart    Remove
@{LIST_ORDER_PRODUCTS}    Name (A to Z)    Name (Z to A)    Price (low to high)    Price (high to low)

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
    VAR    ${TAG_PRODUCT_NAME}    ${PRODUCT_NAME}    scope=SUITE

ENTÃO o botão deve mudar para "${NOME_BTN}"
    IF    $NOME_BTN == $LIST_NOME_BTN[0]
        ${NOME_BTN}    Replace String    ${NOME_BTN}   ${SPACE}    -
        ${NOME_BTN}    Convert To Lower Case    ${NOME_BTN}
    ELSE IF  $NOME_BTN == $LIST_NOME_BTN[1]
        ${NOME_BTN}    Convert To Lower Case    ${NOME_BTN}
    END

    VAR    ${BTN_CARRINHO_LOCATOR}    //button[contains(@data-test,'${NOME_BTN.lower()}-${TAG_PRODUCT_NAME}')]    scope=SUITE
    Element Should Be Visible    ${BTN_CARRINHO_LOCATOR}

E a quantidade de itens no carrinho deve somar um
    Element Should Be Visible    //span[contains(@class,'shopping_cart_badge')]

E possua o produto "${PRODUCT_NAME}" adicionado ao carrinho
    QUANDO clico no carrinho no produto "${PRODUCT_NAME}"
    ENTÃO o botão deve mudar para "${LIST_NOME_BTN}[1]"

E seja o único produto adicionado ao carrinho
    Element Text Should Be    //span[contains(@class,'shopping_cart_badge')]   1

QUANDO clico no botão "${NOME_BTN}"
    Click Button    ${BTN_CARRINHO_LOCATOR}

E a quantidade de itens no carrinho deve desaparecer
    Element Should Not Be Visible    //span[contains(@data-test,'shopping_cart_badge')]

QUANDO seleciono a opção de ordenação "${ORDER_PRODUCT}"
    VAR    ${ORDER_VALUE}    scope=suite
    IF    $ORDER_PRODUCT == '${LIST_ORDER_PRODUCTS}[0]'
        ${ORDER_VALUE}    Replace Variables    az
    ELSE IF    $ORDER_PRODUCT == '${LIST_ORDER_PRODUCTS}[1]'
        ${ORDER_VALUE}    Replace Variables    za
    ELSE IF    $ORDER_PRODUCT == '${LIST_ORDER_PRODUCTS}[2]'
        ${ORDER_VALUE}    Replace Variables    hilo
    ELSE IF    $ORDER_PRODUCT == '${LIST_ORDER_PRODUCTS}[3]'
        ${ORDER_VALUE}    Replace Variables    lohi
    END
        
    Element Text Should Not Be    //span[contains(@data-test, 'active-option')]    ${ORDER_PRODUCT}
    Click Element    //select[contains(@data-test, 'product-sort-container')]
    Click Element    //option[contains(@value, '${ORDER_VALUE}')]

ENTÃO os produtos devem ser exibidos em ordem alfabética decrescente
    Element Text Should Be    //span[contains(@data-test, 'active-option')]    ${LIST_ORDER_PRODUCTS}[1]

ENTÃO os produtos devem ser exibidos em ordem de preço decrescente
    Element Text Should Be    //span[contains(@data-test, 'active-option')]    ${LIST_ORDER_PRODUCTS}[2]

ENTÃO os produtos devem ser exibidos em ordem de preço crescente
    Element Text Should Be    //span[contains(@data-test, 'active-option')]    ${LIST_ORDER_PRODUCTS}[3]
    