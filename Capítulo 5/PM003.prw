#include "TOTVS.ch"

User Function PM003()
    local oBrowse as object

    oBrowse := FWLoadBrw("PM003")

    oBrowse:Activate()
    oBrowse:DeActivate()
    oBrowse:Destroy()

    FreeObj(oBrowse)
    oBrowse := nil

Return Nil

Static Function BrowseDef()
    Local oBrowse as object

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("SB1")
    oBrowse:SetDescription("Cartas de Tarot")

Return oBrowse

Static Function ModelDef()
    Local oStruSB1 := FWFormStruct( 1, 'SB1' )
    Local oModel as object

    // Construindo o Model
    oModel := MPFormModel():New( 'COMP001' )

    // Adiciona um componente de formul�rio ao modelo
    oModel:AddFields( 'SB1MASTER', /*cOwner*/, oStruSB1 )

    // Descri��o do modelo de dados
    oModel:SetDescription( 'Modelo de Cartas de Tarot' )

    // Descri��o dos componentes do modelo de dados
    oModel:GetModel( 'SB1MASTER' ):SetDescription( 'Cartas de Tarot' )

Return oModel

Static Function ViewDef()
    // Obtendo o modelo de dados do fonte
    Local oModel := FWLoadModel( 'PM003' )

    // Iniciando a constru��o da interface (View)
    oView := FWFormView():New()

    // Definindo qual o modelo de dados que ser� utilizado na interface
    oView:SetModel( oModel )

    // Inicializando a view com componente do tipo formul�rio
    oView:AddField( 'VIEW_SB1', oStruSB1, 'SB1MASTER' )

    // Cria��o de um box horizontal
    oView:CreateHorizontalBox( 'TELA' , 100 )

    // Relacionando view com o box
    oView:SetOwnerView( 'VIEW_SB1', 'TELA' )

Return oView
