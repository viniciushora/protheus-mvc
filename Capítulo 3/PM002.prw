#include "TOTVS.ch"

User Function COMP011_MVC()
    Local oBrowse

    // Instanciamento da Classe de Browse
    oBrowse := FWMBrowse():New()

    // Definição da tabela do Browse
    oBrowse:SetAlias('ZA0')
    
    // Definição da legenda
    oBrowse:AddLegend( "ZA0_TIPO=='1'", "YELLOW", "Autor" )
    oBrowse:AddLegend( "ZA0_TIPO=='2'", "BLUE" , "Interprete" )
    
    // Definição de filtro
    oBrowse:SetFilterDefault( "ZA0_TIPO=='1'" )
    
    // Titulo da Browse
    oBrowse:SetDescription('Cadastro de Autor/Interprete')
   
    // Opcionalmente pode ser desligado a exibição dos detalhes
    //oBrowse:DisableDetails()
    
    // Ativação da Classe
    oBrowse:Activate()
    
Return NIL
