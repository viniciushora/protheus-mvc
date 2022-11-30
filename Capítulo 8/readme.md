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
- 

