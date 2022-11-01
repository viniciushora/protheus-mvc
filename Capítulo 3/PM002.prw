#include "TOTVS.ch"

User Function COMP011_MVC()
    Local oBrowse

    // Instanciamento da Classe de Browse
    oBrowse := FWMBrowse():New()

    // Defini��o da tabela do Browse
    oBrowse:SetAlias('ZA0')
    
    // Defini��o da legenda
    oBrowse:AddLegend( "ZA0_TIPO=='1'", "YELLOW", "Autor" )
    oBrowse:AddLegend( "ZA0_TIPO=='2'", "BLUE" , "Interprete" )
    
    // Defini��o de filtro
    oBrowse:SetFilterDefault( "ZA0_TIPO=='1'" )
    
    // Titulo da Browse
    oBrowse:SetDescription('Cadastro de Autor/Interprete')
   
    // Opcionalmente pode ser desligado a exibi��o dos detalhes
    //oBrowse:DisableDetails()
    
    // Ativa��o da Classe
    oBrowse:Activate()
    
Return NIL
