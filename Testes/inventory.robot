*** Settings ***
Resource    ../Resources/r_inventory.robot

Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***

Cenário: Acessar o produto "Sauce Labs Backpack"
    DADO que estou na página de inventário
    QUANDO clico no título do produto "Sauce Labs Backpack"
    ENTÃO devo ser redirecionado para a página do produto "Sauce Labs Backpack"

Cenário: Adicionar o produto "Sauce Labs Bike Light" no carrinho
    DADO que estou na página de inventário
    QUANDO clico no carrinho no produto "Sauce Labs Bike Light"
    ENTÃO o botão deve mudar para "Remove"
    E a quantidade de itens no carrinho deve somar um

Cenário: Remover o produto restante "Sauce Labs Bolt T-Shirt" do carrinho
    DADO que estou na página de inventário
    E possua o produto "Sauce Labs Bolt T-Shirt" adicionado ao carrinho
    E seja o único produto adicionado ao carrinho
    QUANDO clico no botão "Remove"
    ENTÃO o botão deve mudar para "Add to cart"
    E a quantidade de itens no carrinho deve desaparecer

Cenário: Realizar ordenação de produtos para "Name (Z to A)"
    DADO que estou na página de inventário
    QUANDO seleciono a opção de ordenação "Name (Z to A)"
    ENTÃO os produtos devem ser exibidos em ordem alfabética decrescente

Cenário: Realizar ordenação de produtos para "Price (high to low)"
    DADO que estou na página de inventário
    QUANDO seleciono a opção de ordenação "Price (high to low)"
    ENTÃO os produtos devem ser exibidos em ordem de preço decrescente

Cenário: Realizar ordenação de produtos para "Price (low to high)"
    DADO que estou na página de inventário
    QUANDO seleciono a opção de ordenação "Price (low to high)"
    ENTÃO os produtos devem ser exibidos em ordem de preço crescente

