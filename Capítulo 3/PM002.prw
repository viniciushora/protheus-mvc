#include "TOTVS.ch"

User Function PM002()
    Local oBrowse

    // Instanciamento da Classe de Browse
    oBrowse := FWMBrowse():New()

    // Defini��o da tabela do Browse
    oBrowse:SetAlias('SB1')
    
    // Defini��o da legenda
    oBrowse:AddLegend( "B1_GRUPO=='0008'", "YELLOW", "Grupo" )
    
    // Defini��o de filtro
    oBrowse:SetFilterDefault( "B1_GRUPO=='0008'" )
    
    // Titulo da Browse
    oBrowse:SetDescription('Cadastro de Cartas de Tarot')
   
    // Opcionalmente pode ser desligado a exibi��o dos detalhes
    //oBrowse:DisableDetails()
    
    // Ativa��o da Classe
    oBrowse:Activate()
    
Return NIL
