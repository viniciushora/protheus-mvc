# Construção de uma aplicação MVC com duas ou mais entidades
- Mesma coisa só que com mais fontes;

## Construção de estruturas para uma aplicação MVC com duas ou mais entidades
- Criar a estrutura utilizada no modelo de dados;
- Uma entidade (fonte) para cada estrutura;

**Aplicação com dependência pai-filho**
- Construção das estruturas:

```
Local oStruSB1 := FWFormStruct( 1, 'ZA1' )
Local oStruSBM := FWFormStruct( 1, 'SBM' )
```
- oStruZA1: Estrutura pai
- oStruSBM: Estrutura filho
- Parâmetro (1):  Estrutura é para ser utilizada em um modelo de dados.

```
Local oStruZA1 := FWFormStruct( 2, 'ZA1' )
Local oStruZA2 := FWFormStruct( 2, 'ZA2' )
```

- Parâmetro (2): Indica que a estrutura é para ser utilizada em uma interface.

## Construção de uma função ModelDef
```
Static Function ModelDef()
    Local oModel as object
    Local oStruZA1 := FWFormStruct( 1, 'SB1' )
    Local oStruZA2 := FWFormStruct( 1, 'SBM' )
    Local oModel as object

    // Construção do Model
    oModel := MPFormModel():New( 'COMP001' )
```

## Criação de um componente de formulários no modelo de dados (AddFields)
- Adicionar ao modelo um componente de formúlario.

```
oModel:AddFields( 'SB1MASTER', /*cOwner*/, oStruSB1 )
```

## Criação de um componente de grid no Modelo de dados (AddGrid)
- Relação 1 para n de pai para filho;
- Quando se tem essa relação, deve-se definir um componente de Grid para esta entidade;
-  **AddGrid**: Adiciona ao modelo um componente de grid;

```
oModel:AddGrid( 'SBMDETAIL', 'SB1MASTER', oStruSBM )
```

- SBMDETAIL: ID;
- SB1MASTER: Owner do SBMDETAIL
- oStruSBM: Estrutura usada

## Criação de relação entre as entidades do modelo (SetRelation)
- Relacionar as entidades;
- Toda entidade com Owner deve ter seu relacionamento com ele bem definido;
- **SetRelation**: Definir a relação entre duas entidades.

```
oModel:SetRelation( 'SBMDETAIL', { { 'BM_FILIAL', 'xFilial( "SBM" )' }, { 'BM_GRUPO', 
'B1_GRUPO' } }, SBM->( IndexKey( 1 ) ) )
```

- **SBMDETAIL** é o ID da entidade Detail;
- 2º parâmetro é um vetor onde define a relação (JOIN);
- 3º parâmetro é a ordenação dos dados.

- O relacionamento sempre é definido do Detail (Filho) para o Master (Pai), 
tanto no identificador (ID) quanto na ordem do vetor bi-dimensional.

## Definição da chave primária (SetPrimaryKey)
- Seta a chave primária.

```
oModel: SetPrimaryKey( { "B1_FILIAL", "B1_COD" } )
```
- Deve ser usado somente se preciso.
- Se não for possível passar uma chave primária:

```
oModel: SetPrimaryKey( {} )
```

## Descrevendo os componentes do modelo de dados (SetDescription)
- Adicionando descrição

```
oModel:SetDescription( 'Cartas de Tarot' )
```

- Adicionando descrição dos componentes do modelo de dados

```
oModel:GetModel( SB1MASTER' ):SetDescription( 'Dados das cartas' )
oModel:GetModel( 'SBMDETAIL' ):SetDescription( 'Dados do grupo das cartas' )
```

## Finalização da ModelDef
- Retorno do objeto modelo de dados

```
Return oModel
```

## Construção da função ViewDef
- Início da função
```
Static Function ViewDef()
```

- Carregando o modelo
```
Local oModel := FWLoadModel( 'PM004' )
```

- Construção da interface
```
oView := FWFormView():New()
```

- Definindo o modelo de dados da interface
```
oView:SetModel( oModel )
```

## Criação de um componente de formulários na interface (AddField)
- Adicionando na interface um controle do tipo formulário

```
oView:AddField( 'VIEW_SB1', oStruSB1, 'SB1MASTER' )
```

## Criação de um componente de grid na interface (AddGrid)
- Adicionando na interface um controle do tipo grid
```
oView:AddGrid( 'VIEW_SBM', oStruSBM, 'SBMDETAIL' )
```

## Exibição dos dados na interface (CreateHorizontalBox / CreateVerticalBox)
- Criando uma box superior para receber o elemento da interface
```
oView:CreateHorizontalBox( 'SUPERIOR', 15 )
```

- Criando uma box inferior para receber o elemento da interface
```
oView:CreateHorizontalBox( 'INFERIOR', 85 )
```

## Relacionando o componente da interface (SetOwnerView)
- Relacionando o componente da interface com uma box
```
oView:SetOwnerView( 'VIEW_SB1', 'SUPERIOR' )
oView:SetOwnerView( 'VIEW_SBM', 'INFERIOR' )
```

- Entidade pai ocupa 15% da tela;
- Entidade filho ocupa 85% da tela.

## Finalização da ViewDef
- Retornar o objeto oView
