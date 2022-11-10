#include "TOTVS.ch"

Static Function ModelDef()
    Local oStruZA0 := FWFormStruct( 1, 'ZA0' )
    Local oModel as object

    // Construindo o Model
    oModel := MPFormModel():New( 'COMP001' )

    // Adiciona um componente de formul�rio ao modelo
    oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0 )

    // Descri��o do modelo de dados
    oModel:SetDescription( 'Modelo de dados de Autor/Interprete' )

    // Descri��o dos componentes do modelo de dados
    oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Dados de Autor/Interprete' )

Return oModel
