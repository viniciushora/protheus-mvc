# Tratamentos para o modelo de dados
- Tratamentos:
  - Validações;
  - Comportamentos;
  - Manipulação da Grid.
  - Obter e atribuir valores ao modelo de dados (Model);
  - Gravação dos dados manualmente;
  - Regras de preenchimento.

## Mensagens exibidas na interface
- Usadas principalmente durante as validações feitas no modelo de dados;
- Ponto básico do MVC: Separação da lógica de negócio e interaface;
- Validação: feito na lógica de negócio;
- Mensagens: devem ser feitas na interface;
- Função **Help**: utilizada para tratar essa situação;
- **Help**: Pode ser utilizada dentro de um modelo de dados, porém será guardada pelo MVC e só será exibida quando voltar à interface;

```
If nPrcUnit == 0 // Preço unitário
  Help( ,, 'Help',, 'Preço unitário não informado.', 1, 0 )
EndIf
```

- Exemplo: PM004.prw
- A mensagem só será mostrada ao usuário se a condição for atingida.
- Somente a função Help pode ser mostrada.

## Obtenção de componente do modelo de dados (GetModel)
- Trabalhar uma parte específica do modelo;
- GetModel.

```
Local oModelSBM := oModel:GetModel( 'SBMDETAIL' )
```

- oModelSBM: Componente do modelo SB1;
- SBMDETAIL é o identificador do componente;<br>
- Se quiser pegar o modelo inteiro, usar o GetModel:

```
Local oModel := oModelZA2:GetModel()
```

- oModel é o objeto que contém o modelo de dados (Model) completo;

## Validações
- Pontos para validação;
- Modelo de dados pode ter seus pontos;

### Pós-validação do modelo
- Validação feita após o preenchimento do modelo de dados e sua confirmação;
- Equivalente ao antigo TudoOk;
- Modelo de dados já faz validação de campos obrigatórios preenchidos;
- É definida com um bloco de código no 3º parâmetro da classe de construção MPFormModel.

```
oModel := MPFormModel():New( 'COMP001', ,{ |oModel| COMP001POS( oModel ) } )
```

- Código do bloco de validação:
```
Static Function COMP011POS( oModel )
  Local lRet := .T.
  Local nOperation := oModel:GetOperation 
  // Segue a função ...
Return lRet
```

- A função retornará verdadeiro ou falso dependendo se a operação for executada;

### Pós-validação de linha
- Validação após execução das linhas de grid;
- Equivalente ao antigo LinhaOk;

```
oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM, , { |oModelGrid| COMP001LPOS(oModelGrid) }
```

- Será executado após a execução do grid;
- Deve retornar verdadeiro ou falso dependendo se a operação for executada;
  
### Validação de linha duplicada (SetUniqueLine)
- Definição de campos de grid que não podem ser repetidos;
- Método **SetUniqueLine**;

```
// Liga o controle de não repetição de linha
oModel:GetModel( 'SBMDETAIL' ):SetUniqueLine( { 'B1_COD' } )
```

- B1_COD não pode ser repetido na grid. Pode ser informado mais de um campo;

```
oModel:GetModel( 'SBMDETAIL' ):SetUniqueLine( { 'B1_COD', 'B1_GRUPO' } )
```

- Combinação de B1_COD e B1_GRUPO não podem ser repetidas no grid.

### Pré-validação de linha
- A validação da linha, só que antes;

```
oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM, { |oModelGrid, nLine, cAction, 
cField| COMP001LPRE(oModelGrid, nLine, cAction, cField) }
```

| Parâmetro                                                                                |                                               |
|------------------------------------------------------------------------------------------|-----------------------------------------------|
| Um objeto que é a parte do modelo correspondente apenas ao grid                          |                                               |
| O número da linha                                                                        |                                               |
| A ação executada:                                                                        |                                               |
|                                                                                          | SETVALUE – Para a atribuição de valores       |
|                                                                                          | DELETE – Para deleção e recuperação da linha. |
| Campo onde se esta atribuindo o valor, para deleção e recuperação da linha não é passado |                                               |<br>

- A função deve retornar verdadeiro ou falso dependendo se a operação foi executada;

```
  Static Function COMP023LPRE( oModelGrid, nLinha, cAcao, cCampo )

  Local lRet := .T.
  Local oModel := oModelGrid:GetModel()
  Local nOperation := oModel:GetOperation()

  // Valida se pode ou não apagar uma linha do Grid
  If cAcao == 'DELETE' .AND. nOperation == MODEL_OPERATION_UPDATE
    lRet := .F.

    Help( ,, 'Help',, 'Não permitido apagar linhas na alteração.' +;
    CRLF + 'Você esta na linha ' + Alltrim( Str( nLinha ) ), 1, 0 )

  EndIf

Return lRet
```

- Não será permitida a exclusão da linha na operação de alteração.

### Validação da ativação do modelo (SetVldActivate)
- Realizada no momento da ativação do modelo, permitindo ou não sua ativação;
- Método **SetVldActivate**.

```
oModel:SetVldActivate( { |oModel| COMP001ACT( oModel ) } )
```

- Bloco de código recebe como parâmetros um objeto do modelo de dados que ainda não teve seus dados carregados, pois a carga será feita após da ativação;
- A função deve retornar verdadeiro ou falso dependendo se a operação foi executada.

## Manipulação da componente de grid
- Tratamentos que podem ser feitos nos grids de um modelo.

### Quantidade de linhas do componente de grid (Length)
- **Length**: Obter a quantidade de linhas do grid;
- Linhas apagadas também são consideradas na contagem;

```
Static Function COMP011POS( oModel )

    Local lRet := .T.
    Local oModelSBM := oModel:GetModel( 'SBMDETAIL' )
    Local nI := 0

    For nI := 1 To oModelSBM:Length()
        // Segue a funcao ...
    Next nI

Return lRet
```

- Se for passado um parâmetro no método Length, o retorno será apenas a quantidade de linhas não apagadas no grid;

```
nLinhas := oModelSBM:Length( .T. ) // Quantidade linhas não apagadas
```

### Ir para uma linha do componente de grid (GoLine)
- Pra movimentar a linha no grid usa-se o método **GoLine**.

```
Static Function COMP011POS( oModel )

    Local lRet := .T.
    Local oModelSBM := oModel:GetModel( 'SBMDETAIL' )
    Local nI := 0

    For nI := 1 To oModelSBM:Length()
        oModelZA2:GoLine( nI )
        // Segue a funcao ...
    Next nI

Return lRet
```

### Status da linha de um componente de grid
- 3 funções básicas:
  - Inclusão;
  - Alteração;
  - Exclusão.
- Inclusão: todos os componentes do modelo de dados estão incluídos;
- Exclusão: todos os componentes do modelo de dados estão excluídos;
- Alteração: As linhas podem ser incluídas, excluídas e alteradas;
- É possível saber que operações uma linha sofreu pelos seguintes métodos de status:

| Método     | Descrição                                                                           |
|------------|-------------------------------------------------------------------------------------|
| IsDeleted  | Informa se uma linha foi apagada. Retornando .T. (verdadeiro) a linha foi apagada   |
| IsUpdated  | Informa se uma linha foi alterada. Retornando .T. (verdadeiro) a linha foi alterada |
| IsInserted | Informa se uma linha foi incluída. Retornando .T. (verdadeiro) a linha foi incluída |<br>

```
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
    Alltrim( Str( nCtInc ) ) + ' linhas incluídas' + CRLF + ;
    Alltrim( Str( nCtAlt ) ) + ' linhas alteradas' + CRLF + ;
    Alltrim( Str( nCtDel ) ) + ' linhas apagadas' + CRLF ;
    , 1, 0)

Return
```

- Os métodos retornam verdadeiro ou falso.

### Adição uma linha a grid (AddLine)
- Adicionar uma linha no componente grid;
- Método **AddLine**.

```
nLinha++
If oModelZA2:AddLine() == nLinha
  // Segue a função
EndIf
```
