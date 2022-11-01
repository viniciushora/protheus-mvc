#include "TOTVS.ch"

User Function PM001()

    // Primeiramente crie um objeto da seguinte forma:
    oBrowse := FWMBrowse():New()

    // Definindo alias
    oBrowse:SetAlias('SB1')

    // Definindo uma descrição
    oBrowse:SetDescription('Cadastro de Produtos')

    // Ativando a classe
    oBrowse:Activate()

Return
