# Construção de aplicação MVC com uma entidade
- Aplicação MVC com apenas uma entidade definida

## Construção de uma estrutura de dados (FWFormStruct)
1.  Criar a estrutura utilizada no modelo de dados (Model);
2.  Estruturas são objetos que contêm as definições dos dados necessárias para uso da ModelDef ou para a ViewDef;
3.  Contém:
    1.  Estrutura dos Campos; 
    2.  Índices;
    3.  Gatilhos;
    4.  Regras de preenchimento;
    5.  Etc.
- MVC não trabalha vinculado aos metadados;
- Trabalha vinculado a estruturas;
- Estruturas podem ser construídas através dos metadados;
- Com a função FWFormStruct a estrutura será criada a partir do metadado;

### FWMFormStruct
```
FWFormStruct( <nTipo>, <cAlias> )
```
| Variável | Descrição                                                                                  |
|----------|--------------------------------------------------------------------------------------------|
| nTipo    | Tipo da construção da estrutura: 1 para Modelo de dados (Model) e 2 para interface (View); |
| cAlias   | Alias da tabela no metadado;                                                               |

```
Local oStruSB1 := FWFormStruct( 1, 'ZA0' )
```
- Objeto oStruZA0 será uma estrutura para uso em um modelo de dados 
(Model);
- O primeiro parâmetro (1) indica que a estrutura é para uso no modelo e o segundo parâmetro indica qual a tabela dos metadados será usada para a criação da estrutura (ZA0).

```
Local oStruZA0 := FWFormStruct( 2, 'ZA0' )
```
- O objeto oStruZA0 será uma estrutura para uso em uma interface (View);
-  O 
primeiro parâmetro (2) indica que a estrutura é para uso em uma interface e o segundo 
parâmetro indica qual a tabela dos metadados será usada para a criação da estrutura (ZA0).

- Importante: Para o modelo de dados, a FWFormStruct trás todos os campos e também os virtuais.
- Para a interface view, trás os campos conforme o nível, uso ou módulo.

## Construção da função ModelDef
- Nesta função são definidas as regras de negócio ou modelo de 
dados (Model);
- Contém definições de:
  - Entidades envolvidas;
  - Validações;
  - Relacionamentos;
  - Persistência de dados (gravação);
  - Etc.
- Inicialização:

```
Static Function ModelDef()
    Local oStruZA0 := FWFormStruct( 1, 'ZA0' )
    Local oModel

    // Construindo o Model
    oModel := MPFormModel():New( 'PM003' )
```
- **MPFormModel** é a classe utilizada para a construção de um objeto de modelo de dados (Model);
- Deve-se dar um identificador (ID) único para cada componente (CARACTERÍSTICA DO MVC);
- COMP001 é o identificador do Model;
- Se a aplicação é uma Function, o identificador deve ser o nome da Function;
- Se for uma User Function, não pode ser o mesmo nome, por causa dos pontos de entrada criados automaticamente ao se desenvolver uma aplicação MVC.

##  Criação de um componente de formulários no modelo de dados (AddFields)
- **AddFields**: Adiciona um componente de formulário ao modelo;
- Estrutura do modelo de dados (Model) deve iniciar, obrigatoriamente, com um componente de formulário;

```
oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0 )
```
- Deve-se dar um ID para cada componente do modelo;
- **ZA0MASTER** é o identificador do componente;
-  **oStruZA0** é a estrutura que será usada;
-  O segundo parâmetro (owner) não foi informado, isso porque este é o 1º componente do modelo, é o Pai do modelo de dados e portanto não tem um componente superior ou owner.

## Descrição dos componentes do modelo de dados (SetDescription)
- **SetDescription**: Adiciona a descrição ao modelo de dados, essa descrição será usada em vários lugares como em Web Services por exemplo.

```
// Descrição do modelo de dados
oModel:SetDescription( 'Modelo de dados de Autor/Interprete' )
```


```
// Descrição dos componentes do modelo de dados
oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Dados de Autor/Interprete' )
```

## Finalização de ModelDef
- Ao final, deve retornar o objeto modelo de dados.

```
Return oModel
```

## Exemplo completo da ModelDef
- Exemplo: PM003.prw

## Construção da função ViewDef
- A interface View é responsável por renderizar o modelo de dados (Model) e possibilitar a interação com o usuário;
- 