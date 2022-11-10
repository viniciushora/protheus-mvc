#include "TOTVS.ch"

User Function PM004()
    Local oBrowse as object

    oBrowse := FWmBrowse():New()
    oBrowse:SetAlias( 'SB1' )
    oBrowse:SetDescription( 'Cartas de Tarot' )
    oBrowse:Activate()

Return Nil

Static Function MenuDef()
Local aRotina := {}

    aAdd( aRotina, { 'Visualizar', 'VIEWDEF.PM004', 0, 2, 0, NIL } )
    aAdd( aRotina, { 'Incluir' , 'VIEWDEF.PM004', 0, 3, 0, NIL } )
    aAdd( aRotina, { 'Alterar' , 'VIEWDEF.PM004', 0, 4, 0, NIL } )
    aAdd( aRotina, { 'Excluir' , 'VIEWDEF.PM004', 0, 5, 0, NIL } )
    aAdd( aRotina, { 'Imprimir' , 'VIEWDEF.PM004', 0, 8, 0, NIL } )
    aAdd( aRotina, { 'Copiar' , 'VIEWDEF.PM004', 0, 9, 0, NIL } )

Return aRotina

Static Function ModelDef()
    Local oModel as object
    Local oStruSB1 := FWFormStruct( 1, 'SB1' )
    Local oStruSBM := FWFormStruct( 1, 'SBM' )

    // Construção do Model
    oModel := MPFormModel():New( 'COMP001' )

    // Adicionando ao modelo um componente de formúlario
    oModel:AddFields( 'SB1MASTER', /*cOwner*/, oStruSB1 )

    // Adicionando  ao modelo um componente de grid
    oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM )

    // Definindo a relação entre pai e filho
    oModel:SetRelation( 'SBMDETAIL', { { 'BM_FILIAL', 'xFilial( "SBM" )' }, { 'BM_GRUPO', 'B1_GRUPO' } }, SBM->( IndexKey( 1 ) ) )

    // Definindo a chave primária do modelo
    oModel:SetPrimaryKey( { "B1_FILIAL", "B1_COD" } )

    // Definindo a descrição do modelo
    oModel:SetDescription( 'Cartas de Tarot' )

    // Adicionando descrição dos componentes do modelo de dados
    oModel:GetModel( 'SB1MASTER' ):SetDescription( 'Dados das cartas' )
    oModel:GetModel( 'SBMDETAIL' ):SetDescription( 'Dados do grupo das cartas' )

Return oModel

Static Function ViewDef()
    Local oStruSB1 := FWFormStruct( 2, 'SB1' )
    Local oStruSBM := FWFormStruct( 2, 'SBM' )

    // Carregando o modelo
    Local oModel := FWLoadModel( 'PM004' )

    // Construção da interface
    oView := FWFormView():New()

    // Definindo o modelo de dados na interface
    oView:SetModel(oModel)

    // Adicionando na interface um controle do tipo formulário
    oView:AddField( 'VIEW_SB1', oStruSB1, 'SB1MASTER' )

    // Adicionando na interface um controle do tipo grid
    oView:AddGrid( 'VIEW_SBM', oStruSBM, 'SBMDETAIL' )

    // Criando uma box superior para receber o elemento da interface
    oView:CreateHorizontalBox( 'SUPERIOR', 15 )

    // Criando uma box inferior para receber o elemento da interface
    oView:CreateHorizontalBox( 'INFERIOR', 85 )

    // Relacionando o componente da interface com uma box
    oView:SetOwnerView( 'VIEW_SB1', 'SUPERIOR' )
    oView:SetOwnerView( 'VIEW_SBM', 'INFERIOR' )

Return oView
