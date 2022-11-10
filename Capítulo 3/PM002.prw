#include "TOTVS.ch"

User Function PM002()
    Local oBrowse

    // Instanciamento da Classe de Browse
    oBrowse := FWMBrowse():New()

    // Definição da tabela do Browse
    oBrowse:SetAlias('SB1')
    
    // Definição da legenda
    oBrowse:AddLegend( "B1_GRUPO=='0008'", "YELLOW", "Grupo" )
    
    // Definição de filtro
    oBrowse:SetFilterDefault( "B1_GRUPO=='0008'" )
    
    // Titulo da Browse
    oBrowse:SetDescription('Cadastro de Cartas de Tarot')
   
    // Opcionalmente pode ser desligado a exibição dos detalhes
    //oBrowse:DisableDetails()
    
    // Ativação da Classe
    oBrowse:Activate()
    
Return NIL
