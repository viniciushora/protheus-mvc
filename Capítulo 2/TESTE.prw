#include "TOTVS.ch"

Static Function MenuDef()

    Local aRotina := {} as array

    aAdd( aRotina, { 'Visualizar', 'VIEWDEF.TESTE', 0, 2, 0, NIL } )
    aAdd( aRotina, { 'Incluir' , 'VIEWDEF.TESTE', 0, 3, 0, NIL } )
    aAdd( aRotina, { 'Alterar' , 'VIEWDEF.TESTE', 0, 4, 0, NIL } )
    aAdd( aRotina, { 'Excluir' , 'VIEWDEF.TESTE', 0, 5, 0, NIL } )
    aAdd( aRotina, { 'Imprimir' , 'VIEWDEF.TESTE', 0, 8, 0, NIL } )
    aAdd( aRotina, { 'Copiar' , 'VIEWDEF.TESTE', 0, 9, 0, NIL } )


Return aRotina
