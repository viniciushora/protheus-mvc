#include "TOTVS.ch"

Static Function ModelDef()
    Local oStruZA0 := FWFormStruct( 1, 'ZA0' )
    Local oModel as object

    // Construindo o Model
    oModel := MPFormModel():New( 'COMP001' )

    // Adiciona um componente de formulário ao modelo
    oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0 )

    // Descrição do modelo de dados
    oModel:SetDescription( 'Modelo de dados de Autor/Interprete' )

    // Descrição dos componentes do modelo de dados
    oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Dados de Autor/Interprete' )

Return oModel
