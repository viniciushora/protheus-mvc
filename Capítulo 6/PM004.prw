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

    // Constru��o do Model sem p�s-valida��o
    //oModel := MPFormModel():New( 'COMP001' )

    // Constru��o do Model com p�s-valida��o
    oModel := MPFormModel():New( 'COMP001', ,{ |oModel| COMP001POS( oModel ) } )

    // Valida��o de ativa��o do modelo
    // oModel:SetVldActivate( { |oModel| COMP001ACT( oModel ) } )

    // Adicionando ao modelo um componente de form�lario
    oModel:AddFields( 'SB1MASTER', /*cOwner*/, oStruSB1 )

    // Adicionando  ao modelo um componente de grid sem p�s-valida��o de linha
    // oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM )

    // Adicionando  ao modelo um componente de grid com pr�-valida��o de linha
    oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM, { |oModelGrid, nLine, cAction, cField| COMP001LPRE(oModelGrid, nLine, cAction, cField) })

    // Adicionando  ao modelo um componente de grid com p�s-valida��o de linha
    oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM, , { |oModelGrid| COMP001LPOS(oModelGrid) })

    // Definindo a rela��o entre pai e filho
    oModel:SetRelation( 'SBMDETAIL', { { 'BM_FILIAL', 'xFilial( "SBM" )' }, { 'BM_GRUPO', 'B1_GRUPO' } }, SBM->( IndexKey( 1 ) ) )

    // Liga o controle de n�o repeti��o de linha
    oModel:GetModel( 'SBMDETAIL' ):SetUniqueLine( { 'B1_COD' } )

    // Definindo a chave prim�ria do modelo
    oModel:SetPrimaryKey( { "B1_FILIAL", "B1_COD" } )

    // Definindo a descri��o do modelo
    oModel:SetDescription( 'Cartas de Tarot' )

    // Adicionando descri��o dos componentes do modelo de dados
    oModel:GetModel( 'SB1MASTER' ):SetDescription( 'Dados das cartas' )
    oModel:GetModel( 'SBMDETAIL' ):SetDescription( 'Dados do grupo das cartas' )

    Local oModelSBM := oModel:GetModel( 'SBMDETAIL' )
    nLinhas := oModelSBM:Length( .T. )
    Help( ,, 'Help',, 'N�mero de linhas n�o apagadas: ' + cValToChar(nLinhas), 1, 0 )

    // Local nPrcUnit := 0 as numeric
    // If nPrcUnit == 0 // Pre�o unit�rio
    //     Help( ,, 'Help',, 'Pre�o unit�rio n�o informado.', 1, 0 )
    // EndIf

Return oModel

Static Function ViewDef()
    Local oStruSB1 := FWFormStruct( 2, 'SB1' )
    Local oStruSBM := FWFormStruct( 2, 'SBM' )

    // Carregando o modelo
    Local oModel := FWLoadModel( 'PM004' )

    // Constru��o da interface
    oView := FWFormView():New()

    // Definindo o modelo de dados na interface
    oView:SetModel(oModel)

    // Adicionando na interface um controle do tipo formul�rio
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

// P�S-VALIDA��O DO MODELO
Static Function COMP011POS( oModel )

    Local lRet := .T.
    Local oModelSBM := oModel:GetModel( 'SBMDETAIL' )
    Local nI := 0

    For nI := 1 To oModelSBM:Length()
        oModelZA2:GoLine( nI )
        // Segue a funcao ...
    Next nI

Return lRet

// P�S-VALIDA��O DA LINHA
Static Function COMP011LPOS( oModelGrid )

  Local lRet := .T.
  Local nOperation := oModelGrid:GetOperation()

  // Segue a fun��o ...

Return lRet

// PR�-VALIDA��O DA LINHA
Static Function COMP001LPRE( oModelGrid, nLinha, cAcao, cCampo )

    Local lRet := .T.
    Local oModel := oModelGrid:GetModel()
    Local nOperation := oModel:GetOperation()

    // Valida se pode ou n�o apagar uma linha do Grid
    If cAcao == 'DELETE' .AND. nOperation == MODEL_OPERATION_UPDATE
        lRet := .F.

        Help( ,, 'Help',, 'N�o permitido apagar linhas na altera��o.' +;
        CRLF + 'Voc� esta na linha ' + Alltrim( Str( nLinha ) ), 1, 0 )

    EndIf

Return lRet

Static Function COMP23ACAO()
    Local oModel := FWModelActive()
    Local oModelZA2 := oModel:GetModel( 'ZA2DETAIL' )
    Local nI := 0
    Local nCtInc := 0
    Local nCtAlt := 0
    Local nCtDel := 0
    Local aSaveLines := FWSaveRows()

    For nI := 1 To oModelZA2:Length()

        oModelZA2:GoLine( nI )

        If oModelZA2:IsDeleted()
            nCtDel++

        ElseIf oModelZA2:IsInserted()
            nCtInc++

        ElseIf oModelZA2:IsUpdated()
            nCtAlt++

        EndIf

    Next
    
    Help( ,, 'HELP',, 'Existem na grid' + CRLF + ;
    Alltrim( Str( nCtInc ) ) + ' linhas inclu�das' + CRLF + ;
    Alltrim( Str( nCtAlt ) ) + ' linhas alteradas' + CRLF + ;
    Alltrim( Str( nCtDel ) ) + ' linhas apagadas' + CRLF ;
    , 1, 0)

Return
